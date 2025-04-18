// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:zhks/core/presentation/widgets/custom_dialog.dart';
import 'package:zhks/core/themes/theme_extensions.dart';
import 'package:zhks/features/posts/data/post.dart';
import 'package:zhks/features/posts/presentation/providers/posts_providers.dart';
import 'package:zhks/features/posts/presentation/widgets/post_widget.dart';

class ComplainScreen extends StatefulWidget {
  final Post post;
  const ComplainScreen({super.key, required this.post});

  @override
  State<ComplainScreen> createState() => _ComplainScreenState();
}

class _ComplainScreenState extends State<ComplainScreen> {
  String? _selectedReason;
  bool get _isComplainValid => _selectedReason != null;
  final List<String> _complainReasons = [
    'Нецензурная лексика',
    'Провакационный контент',
    'Спам',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Жалоба', style: context.texts.titleSmall),
        // ),)
      ),

      body: Consumer(
        builder:
            (context, ref, child) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PostWidget(post: widget.post, ref: ref),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Характер жалобы',
                      style: context.texts.bodyLarge,
                    ),
                  ),
                  _buildDropdown(
                    context,
                    value: _selectedReason,
                    items: _complainReasons,
                    hint: 'Не выбран',
                    onChanged: (value) {
                      setState(() {
                        _selectedReason = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_isComplainValid) {
                        try {
                          await ref.read(
                            complainPostProvider(widget.post.id).future,
                          );
                          if (!mounted) return;
                          showCustomDialog(
                            context,
                            'Жалоба отправлена на проверку',
                            '/home/posts',
                          );
                        } catch (e) {
                          late String text;
                          if (e.toString().contains(
                            'You have already reported this post',
                          )) {
                            text = 'Вы уже жаловались на этот пост';
                          } else {
                            text = 'Не удалось отправить жалобу';
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(text),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Выберите причину жалобы'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    style: context.buttons.primaryButtonStyle,
                    child: Text("Пожаловаться"),
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
    required String hint,
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
          hintText: hint,
          hintStyle: TextStyle(color: context.colors.primary.gray),
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
        dropdownColor: context.colors.white,
        isExpanded: true,
      ),
    );
  }
}
