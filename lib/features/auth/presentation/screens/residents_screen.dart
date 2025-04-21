// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zhks/core/presentation/providers/profile_providers.dart';

// Project imports:
import 'package:zhks/core/presentation/widgets/custom_app_bar.dart';
import 'package:zhks/core/themes/theme_extensions.dart';
import 'package:zhks/features/auth/presentation/providers/roommates_provider.dart';

class ResidentsScreen extends ConsumerWidget {
  const ResidentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roommates = ref.watch(roommatesProvider);
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
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: context.colors.tertiary.gray,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(profile?.fullName ?? ''),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              child: SizedBox(
                height: 475,
                child: ListView.builder(
                  itemCount: roommates.length,
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
                          padding: EdgeInsets.symmetric(
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
                                '${roommates[index].firstName} ${roommates[index].lastName}',
                              ),
                              GestureDetector(
                                onTap: () {
                                  // TODO: Implement delete roommate functionality
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Сожитель ${roommates[index].firstName} ${roommates[index].lastName} удалён',
                                      ),
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.delete_outline_rounded,
                                  color: Colors.red,
                                ),
                                // child: Icon(Icons.arrow_forward_ios),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                      ],
                    );
                  },
                ),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                context.go('/add-roommate');
              },
              style: context.buttons.primaryButtonStyle,
              child: Text('Добавить ещё'),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
