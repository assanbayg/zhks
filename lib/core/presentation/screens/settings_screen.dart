// Flutter imports:
import 'package:flutter/material.dart';

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
          Column(
            children: [
              SettingsCard(
                label: 'Новости',
                onTap: () {},
                icon: Icons.campaign_rounded,
              ),
            ],
          ),
          Row(),
        ],
      ),
    );
  }
}
