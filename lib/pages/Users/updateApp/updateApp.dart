import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oya_porter/pages/Users/config/navigation.dart';
import 'package:oya_porter/spec/colors.dart';

import 'widget/updateAppWidget.dart';

bool forceUser = false;

class UpdateApp extends StatelessWidget {
  final bool force, allowNotNow;
  final String message, title;

  UpdateApp({
    @required this.force,
    @required this.message,
    @required this.title,
    @required this.allowNotNow,
  });

  @override
  Widget build(BuildContext context) {
    forceUser = force;
    return WillPopScope(
      onWillPop: () {
        return;
      },
      child: Scaffold(
        backgroundColor: WHITE,
        body: updateAppWidget(
          context: context,
          title: title,
          message: message,
          allowNotNow: allowNotNow,
          onNotNow: () => _onNotNow(context),
          onUpdate: () => _onUpdate(),
          // toastContainer(text: "Open store to download new release"),
        ),
      ),
    );
  }

  void _onNotNow(BuildContext context) =>
      navigation(context: context, pageName: "home");

  // check(BuildContext context) async {
  //   final newVersion = NewVersion(
  //     iOSId: 'com.oyaghana.oyaapp_porter',
  //     androidId: 'com.oyaghana.oyaapp_porter',
  //   );
  //   final status = await newVersion.getVersionStatus();
  //   newVersion.showUpdateDialog(context: context, versionStatus: status);
  // }

  Future<void> _onUpdate() async {
    // OpenAppstore.launch(
    //     androidAppId: "com.gitplus.u247doc.patient",
    //     iOSAppId: "1530900052",
    //   );
    const platform = const MethodChannel("oya.flutter.dev/token");
    final String result = await platform.invokeMethod("getPlayStore");
    print("result: $result");
  }
}
