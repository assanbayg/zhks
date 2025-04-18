// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:zhks/core/presentation/providers/profile_repository.dart';
import 'package:zhks/core/presentation/screens/policy_screen.dart';
import 'package:zhks/core/presentation/widgets/custom_app_bar.dart';
import 'package:zhks/core/presentation/widgets/settings_card.dart';
import 'package:zhks/core/themes/theme_extensions.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(profileStateProvider.notifier).fetchUserProfile(),
    );
  }

  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // ignore: avoid_print
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileStateProvider);
    final profile = profileState.profile;
    final isLoading = profileState.isLoading;

    return Scaffold(
      appBar: CustomAppBar(label: 'Настройки'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          if (isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: CircularProgressIndicator(),
              ),
            )
          else if (profile != null)
            Row(
              children: [
                // TODO: make it changing photo button later
                const CircleAvatar(backgroundColor: Colors.black, radius: 45),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(profile.fullName, style: context.texts.titleMedium),
                      Text(profile.apartmentInfo),
                    ],
                  ),
                ),
              ],
            )
          else if (profileState.error != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Ошибка загрузки профиля',
                      style: context.texts.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        ref
                            .read(profileStateProvider.notifier)
                            .fetchUserProfile();
                      },
                      child: const Text('Попробовать снова'),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 20),
          Column(
            children: [
              SettingsCard(
                label: 'Новости',
                // TODO: navigate to chats/announcements
                onTap: () {},
                icon: Icons.campaign_rounded,
              ),
              const SizedBox(height: 12),
              SettingsCard(
                label: 'Добавить сожителя',
                onTap: () {
                  // TODO: prevent navigation to Thanks Screen after adding roommate
                  context.go('/add-roommate');
                },
                icon: Icons.person_add_alt_rounded,
              ),
              const SizedBox(height: 12),
              SettingsCard(
                label: 'Работы',
                onTap: () {
                  context.goNamed('jobs');
                },
                icon: Icons.person_add_alt_rounded,
              ),
              const SizedBox(height: 12),
              SettingsCard(
                label: 'Язык приложения',
                onTap: () {
                  // TODO: show some dialog
                },
                icon: Icons.translate_rounded,
              ),
              const SizedBox(height: 12),
              SettingsCard(
                label: 'Политика конфиденциальности',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const PolicyScreen();
                      },
                    ),
                  );
                },
                icon: Icons.policy_rounded,
              ),
              const SizedBox(height: 12),
              SettingsCard(
                label: 'Помощь',
                onTap: () {
                  openUrl(
                    // TODO: change to real number
                    'https://api.whatsapp.com/send/?phone=%2B77777777777&text&type=phone_number&app_absent=0',
                  );
                },
                icon: Icons.help_outline_rounded,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: context.colors.tertiary.gray,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Push-уведомления', style: context.texts.bodyLarge),
                Switch(
                  value: true,
                  onChanged: (value) {
                    // TODO: change permission
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
