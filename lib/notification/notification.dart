// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import '../main.dart';

// int _notificationId = 10;

// Future<void> showNotification(Map<String, dynamic> msg) async {
//   var bigTextStyleInformation = BigTextStyleInformation(
//       Platform.isIOS
//           ? '${msg["aps"]["alert"]["body"]}'
//           : '${msg["notification"]["body"]}',
//       htmlFormatBigText: true,
//       contentTitle: Platform.isIOS
//           ? '${msg["aps"]["alert"]["title"]}'
//           : '${msg["notification"]["title"]}',
//       htmlFormatContentTitle: true,
//       // summaryText: 'summary <i>text</i>',
//       htmlFormatSummaryText: true);
//   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       (++_notificationId).toString(),
//       Platform.isIOS
//           ? '${msg["aps"]["alert"]["title"]}'
//           : '${msg["notification"]["title"]}',
//       Platform.isIOS
//           ? '${msg["aps"]["alert"]["body"]}'
//           : '${msg["notification"]["body"]}',
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker',
//       styleInformation: bigTextStyleInformation);
//   var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//   var platformChannelSpecifics = NotificationDetails(
//     android: androidPlatformChannelSpecifics,
//     iOS: iOSPlatformChannelSpecifics,
//   );
//   await flutterLocalNotificationsPlugin.show(
//       _notificationId++,
//       Platform.isIOS
//           ? '${msg["aps"]["alert"]["title"]}'
//           : '${msg["notification"]["title"]}',
//       Platform.isIOS
//           ? '${msg["aps"]["alert"]["body"]}'
//           : '${msg["notification"]["body"]}',
//       platformChannelSpecifics,
//       payload: json.encode(msg["data"]));
// }
