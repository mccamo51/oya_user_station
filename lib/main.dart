import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:oya_porter/spec/colors.dart';
import 'pages/auth/authenticationPage.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_impotance_channel', //id
    'Hight importance Notification', //titile
    'This channel is used for important notification',
    importance: Importance.high,
    playSound: true);

// Toggle this for testing Crashlytics in your app locally.
final _kTestingCrashlytics = true;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroudHandler(RemoteMessage message) async {
  Firebase.initializeApp();
}

FirebaseAnalytics analytics = FirebaseAnalytics();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroudHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, sound: true, badge: true);

  runApp(MyApp());
}

//  // Define an async function to initialize FlutterFire
//   Future<void> _initializeFlutterFire() async {
//     if (_kTestingCrashlytics) {
//       // Force enable crashlytics collection enabled if we're testing it.
//       await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
//       FirebaseCrashlytics.instance.setCustomKey('crash', 'flutterfire');
//     } else {
//       // Else only enable it in non-debug builds.
//       // You could additionally extend this to allow users to opt-in.
//       // await FirebaseCrashlytics.instance
//       //     .setCrashlyticsCollectionEnabled(!kDebugMode);
//     }

//     // Pass all uncaught errors to Crashlytics.
//     Function originalOnError = FlutterError.onError;
//     FlutterError.onError = (FlutterErrorDetails errorDetails) async {
//       await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
//       // Forward to original handler.
//       originalOnError(errorDetails);
//     };

//     if (_kShouldTestAsyncErrorOnInit) {
//       await _testAsyncErrorOnInit();
//     }
//   }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: WHITE,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      home: AuthenticationPage(),
      // home: MainHomePage(),
    );
  }
}
