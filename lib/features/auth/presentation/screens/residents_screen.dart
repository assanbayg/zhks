// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:zhks/core/presentation/providers/profile_providers.dart';
import 'package:zhks/core/presentation/widgets/custom_app_bar.dart';
import 'package:zhks/core/themes/theme_extensions.dart';
import 'package:zhks/features/auth/presentation/providers/auth_provider.dart';

class ResidentsScreen extends ConsumerWidget {
  const ResidentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileStateProvider);
    final profile = profileState.profile;

    return Scaffold(
      appBar: CustomAppBar(
        label: 'Сожители',
        showBackButton: true,
        location: '/account',
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'Вы',
                style: context.texts.bodyLarge.copyWith(
                  color: context.colors.primary.gray,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: context.colors.tertiary.gray,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(profile?.fullName ?? ''),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Map<dynamic, dynamic>>>(
                future: ref.read(authStateProvider.notifier).getResidents(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Ошибка: ${snapshot.error}'));
                  }

                  final residents = snapshot.data ?? [];

                  if (residents.isEmpty) {
                    return const Center(child: Text('Список сожителей пуст'));
                  }

                  return ListView.builder(
                    itemCount: residents.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'Сожитель ${index + 1}',
                              style: context.texts.bodyLarge.copyWith(
                                color: context.colors.primary.gray,
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              color: context.colors.tertiary.gray,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${residents[index]['first_name']} ${residents[index]['last_name']}',
                                ),
                                GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(authStateProvider.notifier)
                                        .deleteResident(residents[index]['id']);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Сожитель ${residents[index]['first_name']} ${residents[index]['last_name']} удалён',
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.delete_outline_rounded,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/add-resident');
              },
              style: context.buttons.primaryButtonStyle,
              child: const Text('Добавить ещё'),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
