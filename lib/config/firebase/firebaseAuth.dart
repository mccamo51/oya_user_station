import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/spec/sharePreference.dart';

import 'firebaseProfile.dart';

String firebaseUserId;

abstract class BaseAuth {
  Future<String> signIn({@required String email, @required String password});

  Future<String> signUp({@required String email, @required String password});

  Future<User> getCurrentUser();

  Future<void> sendVerification();

  Future<bool> isEmailVerified();

  Future<void> signOut();
}

class FireAuth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FireProfile _firebaseProfile = new FireProfile();

  @override
  Future<User> getCurrentUser() async {
    User user = _firebaseAuth.currentUser;
    return user;
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  @override
  Future<String> signUp({
    @required String email,
    @required String password,
  }) async {
    UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User user = result.user;
    return user.uid;
  }

  @override
  Future<String> signIn({
    @required String email,
    @required String password,
    @required String phone,
  }) async {
    String ret;
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = result.user;
      //add user details to db
      _firebaseProfile.createAccount(email: email, id: user.uid, phone: phone);
      print(user.uid);
      saveStringShare(key: "firebaseUserId", data: user.uid);
      return user.uid;
    } catch (e) {
      //create new account if log in successfully
      // print(error);
      signUp(email: email, password: password).then((value) {
        signIn(email: email, password: password, phone: phone);
        ret = "login";
      });
    }
    return ret;
  }

  @override
  Future<bool> isEmailVerified() async {
    User user = _firebaseAuth.currentUser;
    return user.emailVerified;
  }

  @override
  Future<void> sendVerification() async {
    User user = _firebaseAuth.currentUser;
    return user.sendEmailVerification();
  }

  // saveToken() async {
  //   String fcmToken = await FirebaseMessaging.instance.getToken();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (prefs.containsKey("firebaseUserId")) {
  //     firebaseUserId = prefs.getString("firebaseUserId");
  //     DatabaseReference databaseReference = new FirebaseDatabase().reference();
  //     databaseReference.child('AllDeviceToken/$firebaseUserId').set({
  //       "id": firebaseUserId,
  //       "token": fcmToken,
  //       "createdAt": ServerValue.timestamp,
  //       "platform": Platform.operatingSystem,
  //       "version": VERSIONNUMBER,
  //     });
  //   } else {
  //     print("Not log in yet");
  //   }
  // }
}
