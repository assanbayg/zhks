// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zhks/core/themes/theme_extensions.dart';

class ReportsToggle extends StatelessWidget {
  final bool isFinanceSelected;
  final void Function(bool isFinance) onToggle;

  const ReportsToggle({
    super.key,
    required this.isFinanceSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final blue = context.colors.primary.blue;
    final textStyle = context.texts.bodyMedium;
    return Container(
      decoration: BoxDecoration(
        color: blue,
        border: Border.all(color: blue, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          _buildTab(
            label: 'Финансы',
            selected: isFinanceSelected,
            onTap: () => onToggle(true),
            color: blue,
            textStyle: textStyle,
          ),

          _buildTab(
            label: 'Работы по дому',
            selected: !isFinanceSelected,
            onTap: () => onToggle(false),
            color: blue,
            textStyle: textStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required String label,
    required bool selected,
    required VoidCallback onTap,
    required Color color,
    required TextStyle textStyle,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? Colors.white : color,
            borderRadius: BorderRadius.all(
              selected ? const Radius.circular(4) : Radius.zero,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: textStyle.copyWith(
              color: selected ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
