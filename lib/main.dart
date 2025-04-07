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

Future main() async {
  // Ensure that neccessary services are initialized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");

  // Lock device orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Wrap an app to read Riverpod providers
  runApp(const ProviderScope(child: MyApp()));
}
