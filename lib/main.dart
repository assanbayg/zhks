// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:zhks/app.dart';
import 'package:zhks/core/config/firebase_options.dart';
import 'package:zhks/core/notifications/push_notifications.dart';

Future main() async {
  // Ensure that neccessary services are initialized
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await PushNotifications.initialize();

  // Lock device orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Wrap an app to read Riverpod providers
  runApp(const ProviderScope(child: MyApp()));
}

// TODO: write comments for this project
// - resolve Missing concrete implementation error for freezer + json seriailzation ===> create FUNCTIONING Resident class
