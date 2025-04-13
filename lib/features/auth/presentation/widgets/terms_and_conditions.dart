// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zhks/core/presentation/screens/policy_screen.dart';
import 'package:zhks/core/themes/theme_extensions.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return PolicyScreen();
            },
          ),
        );
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: context.texts.bodySmall,
          children: [
            const TextSpan(text: 'Нажимая "Далее" вы соглашаетесь на '),
            TextSpan(
              text:
                  'обработку персональных данных и пользовательское соглашение',
              style: context.texts.bodySmall.copyWith(
                color: context.colors.primary.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
