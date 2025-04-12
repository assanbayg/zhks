// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:zhks/core/notifications/push_notifications.dart';

class TestScreen extends ConsumerStatefulWidget {
  const TestScreen({super.key});

  @override
  ConsumerState<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends ConsumerState<TestScreen> {
  String? _token;
  String? _lastNotification;

  @override
  void initState() {
    super.initState();
    _initFCM();
    _listenToMessages();
  }

  Future<void> _initFCM() async {
    final token = await FirebaseMessaging.instance.getToken();
    setState(() => _token = token);
  }

  void _listenToMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setState(() {
        _lastNotification =
            '${message.notification?.title ?? ''}: ${message.notification?.body ?? ''}';
      });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _showSnackBar('Tapped Notification: ${message.notification?.title}');
    });
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> _simulateLocalNotification() async {
    final fakeMessage = RemoteMessage(
      notification: RemoteNotification(
        title: 'Test Title',
        body: 'This is a simulated notification!',
      ),
    );

    await PushNotifications.showLocalNotification(fakeMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Test Screen")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "FCM Token:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SelectableText(_token ?? 'Fetching...'),
            const SizedBox(height: 20),
            const Text("Last Notification:"),
            Text(_lastNotification ?? 'No messages yet'),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _simulateLocalNotification,
              child: const Text("Simulate Local Notification"),
            ),
            ElevatedButton(
              onPressed: () => _showSnackBar("This is just a UI test."),
              child: const Text("Test Snackbar"),
            ),
          ],
        ),
      ),
    );
  }
}
