// Flutter imports:
import 'package:flutter/material.dart';

class GroupedListView<T> extends StatelessWidget {
  final List<T> items;
  final String Function(T item) groupBy;
  final Widget Function(String groupLabel) groupHeaderBuilder;
  final Widget Function(T item) itemBuilder;
  final EdgeInsetsGeometry padding;

  const GroupedListView({
    super.key,
    required this.items,
    required this.groupBy,
    required this.groupHeaderBuilder,
    required this.itemBuilder,
    this.padding = const EdgeInsets.all(16),
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
                groupHeaderBuilder(entry.key),
                const SizedBox(height: 8),
                ...entry.value.map(itemBuilder),
              ],
            );
          }).toList(),
    );
  }
}
