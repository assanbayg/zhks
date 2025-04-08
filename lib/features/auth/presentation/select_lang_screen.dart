// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

class SelectLangScreen extends StatelessWidget {
  const SelectLangScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // TODO: replace with another icon
          Center(child: Icon(Icons.home_work_rounded, size: 100)),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Выберите язык',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 16),
                  // TODO: actually change language
                  ElevatedButton.icon(
                    onPressed: () => context.go('/onboarding'),
                    icon: Icon(Icons.flag, size: 20),
                    label: Text('Қазақ тілі', style: TextStyle(fontSize: 15)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF4F6FA),
                      foregroundColor: Colors.black87,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                  ),
                  SizedBox(height: 6),
                  ElevatedButton.icon(
                    onPressed: () => context.go('/onboarding'),
                    icon: Icon(Icons.flag, size: 20),
                    label: Text('Русский язык', style: TextStyle(fontSize: 15)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF4F6FA),
                      foregroundColor: Colors.black87,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
