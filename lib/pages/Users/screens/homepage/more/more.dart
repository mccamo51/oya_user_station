import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oya_porter/components/alerts.dart';
import 'package:oya_porter/components/bottomSheet.dart';
import 'package:oya_porter/components/webBrowser.dart';
import 'package:oya_porter/pages/Users/screens/auth/register/secureAccount/secure.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/images.dart';
import 'package:oya_porter/spec/styles.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'accountSettings.dart';

class More extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getUserDetails();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: PRIMARYCOLOR,
          elevation: 0,
          iconTheme: IconThemeData(color: WHITE),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "More",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                height: 130,
                color: PRIMARYCOLOR,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Text(
                              "$userName",
                              style: h2WHITE,
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.verified, size: 16, color: WHITE),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "$userPhone",
                          style: h4White,
                        ),
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Things you can do?",
                style: h2Black,
              ),
            ),
            _listItem(
              title: "Account Settings",
              icon: "$USERIMAGE",
              onPress: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                var userDetails = pref.getString("userDetails");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AccountSettings(
                              userData: '$userDetails',
                            )));
              },
            ),
            _listItem(
                title: "Contact Us",
                icon: "$EMAILIMAGE",
                onPress: () => customBottomSheet(context)),
            _listItem(
                title: "Tell a Friend about Oya",
                icon: "$PEOPLEIMAGE",
                onPress: () => _share()),
            _listItem(
              title: "Licenses",
              icon: "$LICENSESIMAGE",
              onPress: () {
                showLicensePage(
                    context: context,
                    applicationIcon: Image.asset(
                      MAINLOGO,
                      width: 100,
                      height: 100,
                    ),
                    applicationName: "Oya!"
                    // Other parameters
                    );
              },
            ),
            _listItem(
                title: "Privacy Policy",
                icon: "$PRIVACYIMAGE",
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WebBroswer(
                                url: "https://oyaghana.com/privacy-policy/",
                                nowWaiting: null,
                              )));
                }),
            _listItem(
                title: "Sign Out",
                icon: "$LOGOUTIMAGE",
                isLogin: true,
                onPress: () {
                  Platform.isIOS ? iosDialog(context) : logoutDialog(context);
                }),
          ]),
        ));
  }
}

_share() async {
  Share.share(
      'https://play.google.com/store/apps/details?id=com.oyaghana.oyaapp_porter&hl=en&gl=US');
}

_listItem({String icon, String title, bool isLogin = false, Function onPress}) {
  return Column(
    children: [
      ListTile(
        leading: Image.asset(
          icon,
          width: 20,
          height: 20,
        ),
        onTap: onPress,
        title: Text(
          "$title",
          style: TextStyle(color: isLogin ? Colors.red : BLACK, fontSize: 16),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 15,
        ),
      ),
      Divider()
    ],
  );
}

getUserDetails() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString("userDetails");
}
