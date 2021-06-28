import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/spec/sharePreference.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebaseAuth.dart';

abstract class BaseProfile {
  Future<void> createAccount({@required String email, @required String id});

  void getUsers();
}

class FireProfile implements BaseProfile {
  final _database = FirebaseDatabase.instance.reference();

  static List<String> users;

  @override
  Future<void> createAccount({
    @required String email,
    @required String id,
    @required String phone,
  }) {
    // FirebaseMessaging.instance.getToken().then((token) {
    //   update(token, id);
    // });
    saveStringShare(key: "firebaseUserId", data: id);
    return _database.child("Users").child(phone).set({
      "id": id,
      "email": email,
      "phone": phone,
      "online": true,
    });
  }

  // update(String token, String id) async {
  //   print(token);
  //   DatabaseReference databaseReference = new FirebaseDatabase().reference();
  //   databaseReference.child('AllDeviceToken/$id').set({
  //     "id": firebaseUserId,
  //     "token": token,
  //     "createdAt": ServerValue.timestamp,
  //     "platform": Platform.operatingSystem,
  //     "version": VERSIONNUMBER,
  //   });
  // }

  @override
  Future<void> getUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    firebaseUserId = prefs.getString("firebaseUserId");
    users = [];
    _database.child("Users").once().then((DataSnapshot dataSnapshot) {
      Map<dynamic, dynamic> values = dataSnapshot.value;
      values.forEach((key, value) {
        users = users + [key];
      });
      // print(users);
    });
  }
}
