// import 'dart:convert';
// import 'dart:io';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:rxdart/rxdart.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
//     BehaviorSubject<ReceivedNotification>();

// class ReceivedNotification {
//   final int id;
//   final String title;
//   final String body;
//   final String payload;

//   ReceivedNotification({
//     @required this.id,
//     @required this.title,
//     @required this.body,
//     @required this.payload,
//   });
// }

// class PushNotificationService {
//   final NavigationService _navigationService = locator<NavigationService>();
//   FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

//   onNotificationSettings() async {
//     var initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');
//     var initializationSettingsIOS = IOSInitializationSettings(
//         requestAlertPermission: false,
//         requestBadgePermission: false,
//         requestSoundPermission: false,
//         onDidReceiveLocalNotification:
//             (int id, String title, String body, String payload) async {
//           print(body);
//           didReceiveLocalNotificationSubject.add(
//             ReceivedNotification(
//               id: id,
//               title: title,
//               body: body,
//               payload: payload,
//             ),
//           );
//         });
//     var initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: (String payload) {
//       if (payload != null) {
//         debugPrint('notification payload: ' + payload);
//         _serialiseAndNavigate(json.decode(payload));
//       }
//       return;
//     });

//     _firebaseMessaging.configure(
//       onLaunch: (Map<String, dynamic> msg) {
//         print(" onLaunch called ${(msg)}");
//         _serialiseAndNavigate(msg, r: true);
//         return;
//       },
//       onResume: (Map<String, dynamic> msg) {
//         print(" onResume called ${(msg)}");
//         _serialiseAndNavigate(msg, r: true);
//         return;
//       },
//       onMessage: (Map<String, dynamic> msg) {
//         print(" onMessage called ${(msg)}");
//         _onMessage(msg);
//         return;
//       },
//     );

//     _firebaseMessaging.requestNotificationPermissions(
//         const IosNotificationSettings(sound: true, alert: true, badge: true));
//     _firebaseMessaging.onIosSettingsRegistered
//         .listen((IosNotificationSettings setting) {
//       print('IOS Setting Registed');
//     });
//     _firebaseMessaging.requestNotificationPermissions(
//         const IosNotificationSettings(sound: true, alert: true, badge: true));

//     _firebaseMessaging.getToken().then((token) {
//       update(token);
//     });

//     // _firebaseMessaging
//     //     .subscribeToTopic("patients")
//     //     .then((value) => print("Subscribe to topic patients"));

//     // _firebaseMessaging
//     //     .subscribeToTopic("all")
//     //     .then((value) => print("Subscribe to topic patients"));

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (prefs.containsKey("notificationSubscribe")) {
//       if (prefs.getBool("notificationSubscribe"))
//         notificationSubscribe(true);
//       else
//         print("user disable notification subscription");
//     } else {
//       notificationSubscribe(true);
//     }
//   }

//   update(String token) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (prefs.containsKey("firebaseUserId")) {
//       firebaseUserId = prefs.getString("firebaseUserId");
//       DatabaseReference databaseReference = new FirebaseDatabase().reference();
//       databaseReference
//           .child('AllDeviceToken/$firebaseUserId')
//           .set({"token": token});
//     } else {
//       print("Not log in yet");
//     }
//   }

//   _onMessage(Map<String, dynamic> msg) async {
//     print(msg);
//     String screen =
//         Platform.isIOS ? msg["from_screen"] : msg["data"]["from_screen"];

//     if (screen == "doctor_ready") {
//       // var decodeMetaData = Platform.isIOS
//       //     ? json.decode(msg["from_meta"])
//       //     : json.decode(msg["data"]["from_meta"]);
//       // String from = Platform.isIOS
//       //     ? msg["from_sender_id"]
//       //     : msg["data"]["from_sender_id"];
//       // Map<String, dynamic> argument = {"meta": decodeMetaData, "from": from};
//       // _navigationService.navigateTo(AudoiCallPickerViewRoute,
//       //     arguments: argument);
//     } else {
//       showNotification(msg);
//     }
//   }

//   Future _serialiseAndNavigate(Map<String, dynamic> message,
//       {bool r = false}) async {
//     String screen;
//     if (Platform.isIOS)
//       screen = message["from_screen"];
//     else
//       screen = r ? message["data"]["from_screen"] : message["from_screen"];
//     print(screen);
//     if (screen != null) {
//       if (screen.toLowerCase() == "doctor_assigned") {
//         var decodeMeta;
//         if (Platform.isIOS)
//           decodeMeta = json.decode(message["from_meta"]);
//         else
//           decodeMeta = r
//               ? json.decode(message["data"]["from_meta"])
//               : json.decode(message["from_meta"]);
//         print(decodeMeta);
//         _navigationService.navigateTo(AppointmentSummaryViewRoute,
//             arguments: decodeMeta);
//       } else if (screen.toLowerCase() == "diagnosis") {
//         var decodeMeta;
//         if (Platform.isIOS)
//           decodeMeta = json.decode(message["from_meta"]);
//         else
//           decodeMeta = r
//               ? json.decode(message["data"]["from_meta"])
//               : json.decode(message["from_meta"]);
//         print(decodeMeta);
//         _navigationService.navigateTo(VisitDetailsViewRoute,
//             arguments: decodeMeta);
//       } else if (screen.toLowerCase() == "prescription_bill") {
//         var decodeMeta;
//         if (Platform.isIOS)
//           decodeMeta = json.decode(message["from_meta"]);
//         else
//           decodeMeta = r
//               ? json.decode(message["data"]["from_meta"])
//               : json.decode(message["from_meta"]);
//         print(decodeMeta);
//         _navigationService.navigateTo(PrescriptionBIllViewRoute,
//             arguments: decodeMeta);
//       } else if (screen.toLowerCase() == "public" ||
//           screen.toLowerCase() == "general_notification") {
//         _navigationService.navigateTo(NotificationViewRoute, arguments: null);
//       } else {
//         _navigationService.navigateTo(HomepageViewRoute, arguments: null);
//       }
//     }
//   }

//   Future<void> fetchDoctorDetails(
//       {@required String doctorid, @required String bookingCode}) async {
//     final response = await http
//         .get("$DOCTORDETIALS_URL/$doctorid")
//         .timeout(Duration(seconds: 15), onTimeout: () {
//       return;
//     });
//     if (response.statusCode == 200) {
//       var responseData = json.decode(response.body);
//       if (responseData['ok'] == true) {
//         if (responseData != null) {
//           print(responseData["data"]);
//           final appointmentResponse = await http
//               .get("$BOOKHISTORY_URL/$bookingCode/fetch_appointment")
//               .timeout(Duration(seconds: 15), onTimeout: () {
//             return;
//           });
//           print(appointmentResponse.body);
//           var decodeAppointment = json.decode(appointmentResponse.body);
//           if (decodeAppointment["ok"] == true) {
//             Map<String, dynamic> dataPass = {
//               "decode": responseData,
//               "appointment": decodeAppointment,
//               "doctorId": doctorid
//             };
//             _navigationService.navigateTo(AppointmentSummaryViewRoute,
//                 arguments: json.encode(dataPass));
//           }
//         }
//       }
//     }
//   }
// }
