// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:zhks/core/themes/theme_extensions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String label;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.label,
    this.showBackButton = true,
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
              ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  // TODO: разобраться что не так и почему не отправляет назад
                  context.pop();
                },
              )
              : null,
      title: Text(label, style: context.texts.titleSmall),
      // ),
    );
  }
}
