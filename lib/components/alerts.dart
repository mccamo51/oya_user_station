import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/sharePreference.dart';

Future<void> iceAlert(BuildContext context, msg) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        // title: Text('Rewind and remember'),
        content: SingleChildScrollView(
          child: Text(
            // 'Your ICE contact is needed for a variety of reasons.',
            '$msg',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        // actions: <Widget>[
        //   FlatButton(
        //     child: Text('Ok'),
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //   ),
        // ],
      );
    },
  );
}

wrongPasswordToast(
    {BuildContext context, @required String msg, @required String title}) {
  BotToast.showAttachedWidget(
      attachedBuilder: (_) => Container(
            height: 66,
            width: MediaQuery.of(context).size.width,
            child: Card(
              borderOnForeground: true,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 4,
                      ),
                      Image.asset("assets/icons/error.png"),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            "$title",
                            style: TextStyle(
                                color: PRIMARYCOLOR,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text("$msg"),
                        ],
                      )
                    ],
                  )),
            ),
          ),
      duration: Duration(seconds: 3),
      target: Offset(520, 520));
}

Future<void> logoutDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Sign Out Confirmation'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Are you sure you want to sign out from the app?'),
            ],
          ),
        ),
        actions: <Widget>[
          OutlineButton(
            borderSide: BorderSide(color: PRIMARYCOLOR),
            // highlightColor: PRIMARYCOLOR,
            highlightedBorderColor: PRIMARYCOLOR,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: PRIMARYCOLOR),
            ),
          ),
          FlatButton(
            color: PRIMARYCOLOR,
            child: Text(
              'Sign Out',
            ),
            onPressed: () {
              clearUser(context);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> iosDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text('Sign Out Confirmation'),
        content: Text('Are you sure you want to sign out from the app?'),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            child: Text('Sign Out'),
            onPressed: () {
              Navigator.of(context).pop();
              // deleteCache(context);
            },
          ),
        ],
      );
    },
  );
}

Future<void> exceptionAlert(
    {BuildContext context, String title, String message}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('$title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('$message'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            color: PRIMARYCOLOR,
            child: Text('Try again'),
            onPressed: () {
              clearUser(context);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

Future<void> iosexceptionAlert(
    {BuildContext context, String title, String message}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text('$title'),
        content: Text('$message'),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            child: Text('Try again'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
