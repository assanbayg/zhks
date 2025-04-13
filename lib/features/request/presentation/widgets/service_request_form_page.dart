// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:zhks/core/themes/theme_extensions.dart';
import 'package:zhks/features/request/presentation/service_providers.dart';

class ServiceRequestFormPage extends ConsumerStatefulWidget {
  final VoidCallback onBackPressed;

  const ServiceRequestFormPage({super.key, required this.onBackPressed});

  @override
  ConsumerState<ServiceRequestFormPage> createState() =>
      _ServiceRequestFormPageState();
}

class _ServiceRequestFormPageState
    extends ConsumerState<ServiceRequestFormPage> {
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final description = ref.read(serviceRequestFormProvider).description;
    if (description != null) {
      _descriptionController.text = description;
    }
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
        ref
            .read(serviceRequestFormProvider.notifier)
            .updatePhoto(File(image.path));
      }
    } catch (e) {
      if (!context.mounted) return;
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка при выборе изображения: $e')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final currentDate = ref.read(serviceRequestFormProvider).requestedDate;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );

    if (picked != null && picked != currentDate) {
      ref.read(serviceRequestFormProvider.notifier).updateRequestedDate(picked);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final currentTimeStr = ref.read(serviceRequestFormProvider).requestedTime;

    // парсим под формат (format: "HH:MM" или "HH:MM:SS")
    final timeParts = currentTimeStr.split(':');
    final currentTime = TimeOfDay(
      hour: int.parse(timeParts[0]),
      minute: int.parse(timeParts[1]),
    );

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: currentTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null && picked != currentTime) {
      // Format as "HH:MM"
      final formattedTime =
          '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';

      // Validate time is between 12:00-18:00
      if (picked.hour < 12 || picked.hour >= 18) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Время должно быть между 12:00 и 18:00')),
        );
      } else {
        ref
            .read(serviceRequestFormProvider.notifier)
            .updateRequestedTime(formattedTime);
      }
    }
  }

  void _submitRequest() async {
    // Проверяем все поля
    final description = _descriptionController.text.trim();
    if (description.isNotEmpty) {
      ref
          .read(serviceRequestFormProvider.notifier)
          .updateDescription(description);
    }

    final request = ref.read(serviceRequestFormProvider);

    final timeParts = request.requestedTime.split(':');
    final hour = int.parse(timeParts[0]);
    if (hour < 12 || hour >= 18) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Время должно быть между 12:00 и 18:00')),
      );
      return;
    }

    try {
      await ref.read(submitServiceRequestProvider(request).future);

      // obnulyaem formu
      ref.read(serviceRequestFormProvider.notifier).reset();

      // Show success message
      _showConfirmationDialog();
    } catch (e) {
      if (!mounted) return;

      // Show error message
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Ошибка при отправке заявки: $e')));
    }
  }

  Future<void> _showConfirmationDialog() {
    return showDialog(
      context: context,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: context.colors.primary.blue,
                    size: 49,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Заявка подана!',
                    style: context.texts.bodyLargeSemibold,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/');
                      Navigator.of(context).pop();
                    },
                    style: context.buttons.primaryButtonStyle,
                    child: Text('Вернуться на главную'),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = ref.watch(serviceRequestFormProvider);
    final formattedDate = DateFormat(
      'dd.MM.yyyy',
    ).format(request.requestedDate);

    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date and time picker
                      InkWell(
                        onTap: () {
                          _selectDate(context);
                          _selectTime(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  '$formattedDate, ${request.requestedTime}',
                                  style: TextStyle(fontSize: 16),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      // Description field
                      TextField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Описание',
                          labelStyle: TextStyle(
                            color: context.colors.primary.gray,
                          ),
                          alignLabelWithHint: true,
                          hintText: 'Введите описание проблемы',
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
                      ),
                      SizedBox(height: 16),

                      // Photo upload
                      InkWell(
                        onTap: _pickImage,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(12),
                          dashPattern: [8, 4, 8, 4],
                          color: context.colors.primary.gray,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              color: context.colors.tertiary.gray,
                            ),
                            child:
                                request.photo == null
                                    ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.attach_file_rounded,
                                          color: context.colors.primary.blue,
                                        ),
                                        SizedBox(width: 4),
                                        Flexible(
                                          child: Text(
                                            'Прикрепить фото',
                                            style: context.texts.bodyLarge
                                                .copyWith(
                                                  color:
                                                      context
                                                          .colors
                                                          .primary
                                                          .gray,
                                                ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    )
                                    : ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Image.file(
                                        request.photo!,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      // Submit button
                      ElevatedButton(
                        onPressed: _submitRequest,
                        style: context.buttons.primaryButtonStyle,
                        child: Text('Начать', style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
