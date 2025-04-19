// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zhks/core/presentation/widgets/date_label.dart';

class GroupedListView<T> extends StatelessWidget {
  final List<T> items;
  final String Function(T item) groupBy;
  final Widget Function(T item) itemBuilder;
  final EdgeInsetsGeometry padding;

  const GroupedListView({
    super.key,
    required this.items,
    required this.groupBy,
    required this.itemBuilder,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
  });

  @override
  Widget build(BuildContext context) {
    final grouped = <String, List<T>>{};
    for (final item in items) {
      final label = groupBy(item);
      grouped.putIfAbsent(label, () => []).add(item);
    }

    if (grouped.isEmpty) {
      return const Center(child: Text('Нет данных'));
    }

    return ListView(
      padding: padding,
      children:
          grouped.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                DateLabel(label: entry.key),
                const SizedBox(height: 8),
                ...entry.value.map(itemBuilder),
              ],
            );
          }).toList(),
    );
  }
}
