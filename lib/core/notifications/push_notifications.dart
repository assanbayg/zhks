// Dart imports:
import 'dart:io';

// Package imports:
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final pushNotificationsProvider = Provider<PushNotifications>((ref) {
  return PushNotifications();
});

class PushNotifications {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final _localNotifications = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // Handle notification permission
    final PermissionStatus status = await Permission.notification.status;

    if (status.isDenied) {
      final result = await Permission.notification.request();
      if (!result.isGranted) {
        return;
      }
    }

    // iOS permission
    if (Platform.isIOS) {
      await _firebaseMessaging.requestPermission();
    }

    // Get and print token (send this to backend later)
    // final token = await _firebaseMessaging.getToken();
    // print("FCM Token: $token");

    // Local notifications setup (foreground support)
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    await _localNotifications.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showLocalNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // Handle navigation if needed
    });
  }

  static Future<void> showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    final androidDetails = AndroidNotificationDetails(
      'default_channel',
      'General Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    if (notification != null) {
      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(android: androidDetails),
      );
    }
  }
}

// import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';

// // This handler will be called when the app is in the background
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   debugPrint('Background message received: ${message.messageId}');
// }

// class PushNotificationss {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

//   Future<void> initialize() async {
//     if (Platform.isIOS) {
//       final notificationSettings = await FirebaseMessaging.instance
//           .requestPermission(provisional: true);

//       // For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
//       final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
//       if (apnsToken != null) {
//         // APNS token is available, make FCM plugin API requests...
//       }
//     }

//     FirebaseMessaging.instance.onTokenRefresh
//         .listen((fcmToken) {
//           // TODO: If necessary send token to application server.

//           // Note: This callback is fired at each app startup and whenever a new
//           // token is generated.
//         })
//         .onError((err) {
//           // Error getting token.
//         });
//   }
// }
