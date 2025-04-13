// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:zhks/core/presentation/widgets/custom_app_bar.dart';
import 'package:zhks/core/presentation/widgets/settings_card.dart';
import 'package:zhks/core/themes/theme_extensions.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(label: 'Настройки'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),

        children: [
          Row(
            spacing: 16,
            children: [
              // TODO: make it changing photo button later
              CircleAvatar(backgroundColor: context.colors.black, radius: 45),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name', style: context.texts.titleMedium),
                  Text('Собственник квартиры'),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Column(
            spacing: 12,
            children: [
              SettingsCard(
                label: 'Новости',
                // TODO: navigate to chats/announcements
                onTap: () {},
                icon: Icons.campaign_rounded,
              ),
              SettingsCard(
                label: 'Добавить сожителя',
                onTap: () {
                  // TODO: prevent navigation to Thanks Screen after adding roommate
                  context.go('/add-roommate');
                },
                icon: Icons.person_add_alt_rounded,
              ),
              SettingsCard(
                label: 'Работы',
                onTap: () {
                  // TODO: show all services
                  context.go('/add-roommate');
                },
                icon: Icons.person_add_alt_rounded,
              ),
              SettingsCard(
                label: 'Язык приложения',
                onTap: () {
                  // TODO: show some dialog
                },
                icon: Icons.translate_rounded,
              ),
              SettingsCard(
                label: 'Политика конфиденциальности',
                onTap: () {
                  // TODO: create some screen for it
                },
                icon: Icons.policy_rounded,
              ),
              SettingsCard(
                label: 'Помощь',
                onTap: () {
                  // TODO: url to whatsapp
                },
                icon: Icons.help_outline_rounded,
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
