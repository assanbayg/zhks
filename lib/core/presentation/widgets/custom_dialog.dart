// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:zhks/core/themes/theme_extensions.dart';

void showCustomDialog(
  BuildContext context,
  String description,
  String location,
) {
  showDialog(
    context: context,
    builder:
        (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          contentPadding: const EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_rounded,
                color: context.colors.primary.blue,
                size: 49,
              ),
              const SizedBox(height: 16),
              Text(description, style: context.texts.bodyLargeSemibold),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.go(location);
                  },
                  style: context.buttons.primaryButtonStyle,
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        ),
  );
}
