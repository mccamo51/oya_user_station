import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/spec/colors.dart';
import 'pages/auth/authenticationPage.dart';
import 'pages/porter/homePage/homePageWithNav.dart';

void main() {
  runApp(MyApp());
}

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
      // home: AuthenticationPage(),
      home: PorterHomePage(),
    );
  }
}
