// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:zhks/core/themes/theme_extensions.dart';

class PropertyForm extends StatelessWidget {
  final List<String> rcOptions;
  final List<String> queueOptions;
  final String? selectedRC;
  final String? selectedQueue;
  final TextEditingController entranceController;
  final TextEditingController floorController;
  final TextEditingController flatNumberController;
  final bool isFormValid;
  final ValueChanged<String?> onRCChanged;
  final ValueChanged<String?> onQueueChanged;
  final VoidCallback onContinue;

  const PropertyForm({
    super.key,
    required this.rcOptions,
    required this.queueOptions,
    required this.selectedRC,
    required this.selectedQueue,
    required this.floorController,
    required this.flatNumberController,
    required this.isFormValid,
    required this.onRCChanged,
    required this.onQueueChanged,
    required this.onContinue,
    required this.entranceController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ---
          Text('ЖК', style: context.texts.bodyLarge),
          const SizedBox(height: 4),
          _buildDropdown(
            context,
            value: selectedRC,
            items: rcOptions,
            hint: 'Не выбран',
            onChanged: onRCChanged,
          ),
          const SizedBox(height: 18),
          // ---
          Text('Очередь', style: context.texts.bodyLarge),
          const SizedBox(height: 4),
          _buildDropdown(
            context,
            value: selectedQueue,
            items: queueOptions,
            hint: 'Не выбран',
            onChanged: onQueueChanged,
          ),
          const SizedBox(height: 18),
          // ---
          Text('Подъезд', style: context.texts.bodyLarge),
          const SizedBox(height: 4),
          TextField(
            controller: entranceController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
            decoration: InputDecoration(
              hintText: 'Введите номер подьезда',
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
          Text('Этаж', style: context.texts.bodyLarge),
          const SizedBox(height: 4),
          TextField(
            controller: floorController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
            decoration: InputDecoration(
              hintText: 'Введите этаж',
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
          Text('Номер квартиры', style: context.texts.bodyLarge),
          const SizedBox(height: 8),
          TextField(
            controller: flatNumberController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(4),
            ],
            decoration: InputDecoration(
              hintText: 'Введите номер квартиры',
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
          const SizedBox(height: 48),
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
            onPressed: isFormValid ? onContinue : null,
            child: const Text('Далее'),
          ),
        ],
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
