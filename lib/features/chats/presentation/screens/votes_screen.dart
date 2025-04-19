// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zhks/core/presentation/widgets/custom_app_bar.dart';
import 'package:zhks/features/chats/presentation/widgets/message_permitted.dart';

class VotesScreen extends StatelessWidget {
  const VotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(label: 'Голосования', location: '/home/chats'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return null;
                  },
                ),
              ),
            ),
            MessagePermitted(),
          ],
        ),
      ),
    );
  }
}
