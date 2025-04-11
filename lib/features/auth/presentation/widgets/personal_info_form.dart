// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// Project imports:
import 'package:zhks/core/themes/theme_extensions.dart';

class PersonalInfoForm extends StatelessWidget {
  final String gender;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final TextEditingController emailController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final bool isFormValid;
  final ValueChanged<String> onGenderChanged;
  final VoidCallback onSubmit;
  final VoidCallback onBack;

  final String submitButtonText;

  const PersonalInfoForm({
    super.key,
    required this.gender,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.emailController,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneController,
    required this.isFormValid,
    required this.onGenderChanged,
    required this.onSubmit,
    required this.onBack,
    this.submitButtonText = 'Зарегистрироваться',
  });

  @override
  Widget build(BuildContext context) {
    final phoneMaskFormatter = MaskTextInputFormatter(
      mask: '(###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      initialText: phoneNumber,
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ---
          Text('Пол', style: context.texts.bodyLarge),
          const SizedBox(height: 4),
          _buildGenderDropdown(context),
          const SizedBox(height: 18),

          // ---
          Text('Имя', style: context.texts.bodyLarge),
          const SizedBox(height: 4),
          TextField(
            controller: firstNameController,
            decoration: InputDecoration(
              hintText: 'Введите имя',
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
          // ---
          Text('Фамилия', style: context.texts.bodyLarge),
          const SizedBox(height: 4),
          TextField(
            controller: lastNameController,
            decoration: InputDecoration(
              hintText: 'Введите фамилию',
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
          // ---
          Text('E-mail', style: context.texts.bodyLarge),
          const SizedBox(height: 4),
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
          // ---
          Text('Телефон', style: context.texts.bodyLarge),
          const SizedBox(height: 4),
          TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            inputFormatters: [phoneMaskFormatter],
            decoration: InputDecoration(
              hintText: '(XXX) XXX XX-XX',
              hintStyle: TextStyle(color: context.colors.primary.gray),
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
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text('+7', style: context.texts.bodyLarge),
              ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 0,
                minHeight: 0,
              ),
            ),
          ),
          const SizedBox(height: 48),
          // ---
          ElevatedButton(
            style:
                isFormValid
                    ? context.buttons.primaryButtonStyle
                    : context.buttons.secondaryButtonStyle.copyWith(
                      foregroundColor: WidgetStateProperty.all(
                        context.colors.white,
                      ),
                      backgroundColor: WidgetStateProperty.all(
                        context.colors.secondary.blue,
                      ),
                    ),
            onPressed: isFormValid ? onSubmit : null,
            child: Text(submitButtonText),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderDropdown(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.tertiary.gray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField<String>(
        value: gender,
        items: const [
          DropdownMenuItem<String>(value: '', child: Text('Не выбран')),
          DropdownMenuItem<String>(value: 'male', child: Text('Мужской')),
          DropdownMenuItem<String>(value: 'female', child: Text('Женский')),
        ],
        onChanged: (value) {
          if (value != null) {
            onGenderChanged(value);
          }
        },
        decoration: InputDecoration(
          border: InputBorder.none,
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
