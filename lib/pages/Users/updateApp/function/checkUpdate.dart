import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/pages/Users/config/checkConnection.dart';
import 'package:oya_porter/pages/Users/config/firebase/firebaseAuth.dart';
import 'package:oya_porter/pages/Users/config/functions.dart';
import 'package:oya_porter/pages/Users/config/locator.dart';
import 'package:oya_porter/pages/Users/routers/routeName.dart';
import 'package:oya_porter/pages/Users/service/navigationService.dart';
import 'package:oya_porter/spec/properties.dart';
import 'package:oya_porter/spec/sharePreference.dart';

Future<void> checkUpdate(BuildContext context) async {
  final NavigationService _navigationService = locator<NavigationService>();

  checkConnection().then((connection) async {
    if (connection) {
      await FirebaseDatabase.instance
          .reference()
          .child("Others")
          .child("Update")
          .once()
          .then((DataSnapshot snapshot) async {
        dynamic values = snapshot.value;
        print(values);
        int buildNumber = values["buildNumber"];
        bool userLogout = values["userLogout"];
        if (BUILDNUMBER >= buildNumber) {
          print("current version up to date with build: $buildNumber");
        } else {
          if (userLogout) {
            await deleteCache(context).whenComplete(() {
              saveBoolShare(key: "auth", data: false);
              FireAuth _fireAuth = new FireAuth();
              _fireAuth.signOut().then((value) {
                saveBoolShare(key: "auth", data: false);
              });
            });
          }
          _navigationService.navigateTo(UpdateViewRoute, arguments: values);
        }
      });
    } else {
      print("No internet connection");
    }
  });
}
