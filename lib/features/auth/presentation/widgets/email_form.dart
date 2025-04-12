// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zhks/core/themes/theme_extensions.dart';
import 'package:zhks/features/auth/presentation/widgets/terms_and_conditions.dart';

class EmailForm extends StatelessWidget {
  final TextEditingController emailController;
  final bool isEmailValid;
  final VoidCallback onContinue;
  final VoidCallback? onSecondaryAction;
  final String? secondaryButtonLabel;

  const EmailForm({
    super.key,
    required this.emailController,
    required this.isEmailValid,
    required this.onContinue,
    this.onSecondaryAction,
    this.secondaryButtonLabel = 'Регистрация',
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Эл. Почта', style: context.texts.bodyLarge),
          const SizedBox(height: 8),
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Введите адрес эл. почты',
              filled: true,
              fillColor: context.colors.tertiary.gray,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Мы отправим сообщение с кодом на вашу электронную почту',
            style: context.texts.bodySmall.copyWith(
              color: context.colors.primary.gray,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 200),
          const TermsAndConditions(),
          const SizedBox(height: 16),
          ElevatedButton(
            style:
                isEmailValid
                    ? context.buttons.primaryButtonStyle
                    : context.buttons.secondaryButtonStyle.copyWith(
                      foregroundColor: WidgetStateProperty.all(
                        context.colors.white,
                      ),
                      backgroundColor: WidgetStateProperty.all(
                        context.colors.secondary.blue,
                      ),
                    ),
            onPressed: isEmailValid ? onContinue : null,
            child: const Text('Далее'),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            style:
                isEmailValid
                    ? context.buttons.secondaryButtonStyle
                    : context.buttons.secondaryButtonStyle.copyWith(
                      foregroundColor: WidgetStateProperty.all(
                        context.colors.primary.gray,
                      ),
                    ),
            onPressed: isEmailValid ? onSecondaryAction : null,
            child: Text(secondaryButtonLabel!),
          ),
        ],
      ),
    );
  }
}
