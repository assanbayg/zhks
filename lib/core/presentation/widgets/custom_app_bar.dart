// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Package imports:
import 'package:go_router/go_router.dart';
import 'package:zhks/core/providers/onboarding_provider.dart';

// Project imports:
import 'package:zhks/core/themes/theme_extensions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String label;
  final bool showBackButton;
  final String location;

  const CustomAppBar({
    super.key,
    required this.label,
    this.showBackButton = false,
    this.location = '',
  });

  @override
  Size get preferredSize => Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: showBackButton,
      centerTitle: true,
      leading:
          showBackButton
              // TODO: use custom icons
              ? Consumer(
                builder:
                    (context, ref, child) => IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () async {
                        if (location == '/onboarding') {
                          await ref.read(onboardingIncompleteProvider.future);
                        }
                        if (!context.mounted) return;
                        context.go(location);
                      },
                    ),
              )
              : null,
      title: Text(label, style: context.texts.titleSmall),
      // ),
    );
  }
}
