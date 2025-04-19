// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zhks/core/themes/theme_extensions.dart';

class LoginVerificationForm extends StatelessWidget {
  final String email;
  final List<TextEditingController> codeControllers;
  final bool isCodeComplete;
  final int remainingSeconds;
  final VoidCallback onSubmit;
  final VoidCallback? onResend;

  const LoginVerificationForm({
    super.key,
    required this.email,
    required this.codeControllers,
    required this.isCodeComplete,
    required this.remainingSeconds,
    required this.onSubmit,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Мы отправили код на адрес',
            textAlign: TextAlign.center,
            style: context.texts.titleSmall.copyWith(
              color: context.colors.primary.gray,
            ),
          ),
          Text(
            email,
            textAlign: TextAlign.center,
            style: context.texts.titleSmall.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          _buildVerificationCodeFields(context),
          const SizedBox(height: 16),
          _buildResendTimer(context),
          const SizedBox(height: 40),
          ElevatedButton(
            style:
                isCodeComplete
                    ? context.buttons.primaryButtonStyle
                    : context.buttons.secondaryButtonStyle.copyWith(
                      backgroundColor: WidgetStateProperty.all(
                        context.colors.secondary.blue,
                      ),
                      foregroundColor: WidgetStateProperty.all(
                        context.colors.white,
                      ),
                    ),
            onPressed: isCodeComplete ? onSubmit : null,
            child: const Text('Войти'),
          ),
          const SizedBox(height: 18),
          TextButton(
            onPressed: onResend,
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.disabled)) {
                  return context.colors.primary.gray;
                }
                return context.colors.primary.blue;
              }),
              overlayColor: WidgetStateProperty.all(Colors.transparent),
            ),
            child: const Text('Отправить код ещё раз'),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationCodeFields(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Container(
          width: 60,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: TextField(
            controller: codeControllers[index],
            textAlign: TextAlign.center,
            maxLength: 1,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (value.isNotEmpty && index < 3) {
                FocusScope.of(context).nextFocus();
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: context.colors.tertiary.gray,
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: context.colors.primary.gray),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildResendTimer(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: context.texts.bodySmall.copyWith(
          color: context.colors.primary.gray,
        ),
        children: [
          const TextSpan(text: 'Повторная отправка кода через '),
          TextSpan(
            text: '( $remainingSeconds )',
            style: context.texts.bodySmall,
          ),
        ],
      ),
    );
  }
}
