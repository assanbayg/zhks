// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

// Project imports:
import 'package:zhks/core/presentation/providers/profile_repository.dart';
import 'package:zhks/core/presentation/widgets/custom_app_bar.dart';
import 'package:zhks/core/presentation/widgets/custom_dialog.dart';
import 'package:zhks/core/themes/theme_extensions.dart';
import 'package:zhks/features/posts/presentation/providers/posts_providers.dart';

// Define a state class for our post form
class PostFormState {
  final String? description;
  final bool? isAnonymous;
  final List<File> photos;

  PostFormState({this.description, this.isAnonymous, this.photos = const []});

  PostFormState copyWith({
    String? description,
    bool? isAnonymous,
    List<File>? photos,
  }) {
    return PostFormState(
      description: description ?? this.description,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      photos: photos ?? this.photos,
    );
  }
}

// Create a provider for our post form state
final postFormProvider = StateNotifierProvider<PostFormNotifier, PostFormState>(
  (ref) {
    return PostFormNotifier();
  },
);

class PostFormNotifier extends StateNotifier<PostFormState> {
  PostFormNotifier() : super(PostFormState());

  void updateDescription(String description) {
    state = state.copyWith(description: description);
  }

  void toggleAnonymous(bool isAnonymous) {
    state = state.copyWith(isAnonymous: isAnonymous);
  }

  void addPhoto(File photo) {
    final currentPhotos = List<File>.from(state.photos);
    currentPhotos.add(photo);
    state = state.copyWith(photos: currentPhotos);
  }

  void removePhoto(int index) {
    if (index >= 0 && index < state.photos.length) {
      final currentPhotos = List<File>.from(state.photos);
      currentPhotos.removeAt(index);
      state = state.copyWith(photos: currentPhotos);
    }
  }

  void reset() {
    state = PostFormState();
  }
}

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool _isAnonymous = true;

  @override
  void initState() {
    super.initState();
    // Check if we have existing description in the state
    final description = ref.read(postFormProvider).description;
    if (description != null) {
      _descriptionController.text = description;
    }

    // Set initial anonymous state
    final isAnonymous = ref.read(postFormProvider).isAnonymous;
    if (isAnonymous != null) {
      _isAnonymous = isAnonymous;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.read(profileStateProvider).profile == null &&
          !ref.read(profileStateProvider).isLoading) {
        ref.read(profileStateProvider.notifier).fetchUserProfile();
      }
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );

      if (image != null) {
        final file = File(image.path);
        final fileSizeInBytes = await file.length();
        const maxSizeInBytes = 5 * 1024 * 1024; // 5MB

        if (fileSizeInBytes > maxSizeInBytes) {
          if (!context.mounted) return;
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Файл слишком большой. Максимум 5MB.'),
            ),
          );
          return;
        }

        ref.read(postFormProvider.notifier).addPhoto(file);
      }
    } catch (e) {
      if (!context.mounted) return;
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка при выборе изображения: $e')),
      );
    }
  }

  void _submitPost() async {
    // Validate and get our form data
    final description = _descriptionController.text.trim();
    if (description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста, напишите текст для поста')),
      );
      return;
    }

    // Update form state
    ref.read(postFormProvider.notifier).updateDescription(description);
    ref.read(postFormProvider.notifier).toggleAnonymous(_isAnonymous);

    // Get form data from state
    final formState = ref.read(postFormProvider);
    final photos = formState.photos;

    try {
      // Use the CreatePost provider to submit the post
      await ref
          .read(createPostProvider.notifier)
          .create(text: description, photos: photos, anonymous: _isAnonymous);

      if (!mounted) return;

      // Show success message
      showCustomDialog(context, 'Запись создана!', '/home/posts');

      // Reset the form after successful submission
      ref.read(postFormProvider.notifier).reset();
      _descriptionController.clear();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Ошибка при создании поста: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(postFormProvider);
    final profileState = ref.watch(profileStateProvider);
    final profile = profileState.profile;
    final isLoading = profileState.isLoading;

    return Scaffold(
      appBar: CustomAppBar(
        label: 'Новая запись',
        showBackButton: true,
        location: '/home/posts',
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Anonymous or not dropdown
                      _buildDropdown(
                        context,
                        value:
                            _isAnonymous ? 'Анонимно' : profile!.apartmentInfo,
                        items: ['Анонимно', profile!.apartmentInfo],
                        onChanged: (value) {
                          setState(() {
                            _isAnonymous = value == 'Анонимно';
                            ref
                                .read(postFormProvider.notifier)
                                .toggleAnonymous(_isAnonymous);
                          });
                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text('Запись', style: context.texts.bodyLarge),
                      ),

                      // Post content field
                      TextField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          hintText: 'О чём будете писать?',
                          hintStyle: TextStyle(
                            color: context.colors.primary.gray,
                          ),
                          filled: true,
                          fillColor: context.colors.tertiary.gray,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                        maxLines: 8,
                        onChanged: (value) {
                          ref
                              .read(postFormProvider.notifier)
                              .updateDescription(value);
                        },
                      ),

                      const SizedBox(height: 16),

                      // Display selected photos
                      if (formState.photos.isNotEmpty) ...[
                        SizedBox(
                          height: 80,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: formState.photos.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        formState.photos[index],
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          ref
                                              .read(postFormProvider.notifier)
                                              .removePhoto(index);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: context.colors.primary.red,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Photo upload button
                      InkWell(
                        onTap: _pickImage,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          dashPattern: const [8, 4, 8, 4],
                          color: context.colors.primary.gray,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              color: context.colors.tertiary.gray,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.attach_file_rounded,
                                  color: context.colors.primary.blue,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    formState.photos.isNotEmpty
                                        ? 'Добавить ещё'
                                        : 'Прикрепить фото',
                                    style: context.texts.bodyLarge.copyWith(
                                      color: context.colors.primary.gray,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      ElevatedButton(
                        onPressed: _submitPost,
                        style: context.buttons.primaryButtonStyle,
                        child: const Text(
                          'Опубликовать',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }

  Widget _buildDropdown(
    BuildContext context, {
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.tertiary.gray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        items:
            items.map((item) {
              return DropdownMenuItem<String>(value: item, child: Text(item));
            }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        icon: Icon(Icons.arrow_drop_down, color: context.colors.primary.black),
        style: context.texts.bodyMedium,
        dropdownColor: context.colors.tertiary.gray,
      ),
    );
  }
}
