// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:zhks/core/themes/theme_extensions.dart';
import 'package:zhks/features/onboarding/presentation/onboarding_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String label;
  final bool showBackButton;
  final String location;
  final Widget action;

  const CustomAppBar({
    super.key,
    required this.label,
    this.showBackButton = false,
    this.location = '',
    this.action = const SizedBox.shrink(),
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
      actions: [action],
    );
  }
}
