import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oya_porter/components/alerts.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/pages/porter/homePage/homePageWithNav.dart';
import 'package:oya_porter/spec/sharePreference.dart';
import 'package:oya_porter/spec/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'admin/adminPage.dart';
import 'porter/homePage/home/homePagePorter.dart';

class MainHomePage extends StatefulWidget {
  var data;
  MainHomePage({@required this.data});

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  var data;
  @override
  void initState() {
    _getUserDetails();
    // TODO: implement initState
    super.initState();
  }

  _getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("userDetails")) {
      String encodedData = prefs.getString("userDetails");
      var decodeData = json.decode(encodedData);
      print(decodeData['data']['staffs'].length);
      accessToken = decodeData['data']['access_token'];
      stationId = prefs.getString("stationId");
      setState(() {
        data = decodeData['data']['staffs'];
      });
    } else {
      print("please log in now");
    }
  }

  @override
  Widget build(BuildContext context) {
    // _getUserDetails();
    return Scaffold(
      appBar: appBar(title: "Home", actions: [
        PopupMenuButton<String>(
          onSelected: ((val) {
            logoutDialog(context);
          }),
          itemBuilder: (BuildContext context) {
            return Constants.choices.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        )
      ]),
      body: Column(
        children: [
          if (data != null)
            for (var x in data)
              Card(
                child: ListTile(
                  onTap: () {
                    if (x['account_type']['id'] == 1) {
                    } else if (x['account_type']['id'] == 2) {
                    } else if (x['account_type']['id'] == 3) {
                      setState(() {
                        userId = x['id'].toString();
                        saveStringShare(
                            key: "stationId",
                            data: (x['station']['id'].toString()));
                        stationId = (x['station']['id'].toString());
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StationMasterPage(
                            stationID: stationId,
                          ),
                        ),
                      );
                    } else if (x['account_type']['id'] == 4) {
                    } else if (x['account_type']['id'] == 5) {
                    } else if (x['account_type']['id'] == 6) {
                    } else if (x['account_type']['id'] == 7) {
                      setState(() {
                        userId = x['id'].toString();
                        saveStringShare(
                            key: "stationId",
                            data: (x['station']['id'].toString()));
                        stationId = (x['station']['id'].toString());
                      });
                      // _getLoading(stationId);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PorterHomePage(
                              // id: x['account_type']['id'],
                              ),
                        ),
                      );
                    }
                  },
                  title: Text(x['account_type']['name']),
                  subtitle: Text(x['station']['name']),
                  leading: Icon(Icons.bus_alert),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                ),
              )
        ],
      ),
    );
  }

  _getLoading(stid) async {
    final response = await http.get(
      "$BASE_URL/stations/$stid/loading_bus",
      headers: {
        "Authorization": "Bearer $accessToken",
      },
    ).timeout(
      Duration(seconds: 50),
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['status'] == 200) {
        print(responseData['data']);
        carNumber = responseData['data']['bus']['reg_number'];
        // scheduleID = responseData['data'];
      }
    }
  }
}
