import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:oya_porter/components/alerts.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/main.dart';
import 'package:oya_porter/models/checkInModel.dart';
import 'package:oya_porter/pages/Conductor/conductorHome.dart';
import 'package:oya_porter/pages/Driver/driverHome.dart';
import 'package:oya_porter/pages/Users/screens/homepage/homeMap/newHome.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/pages/generalManager/generalPage.dart';
import 'package:oya_porter/pages/porter/homePage/homePageWithNav.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/sharePreference.dart';
import 'package:oya_porter/spec/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'Users/screens/homepage/homeMap/bookingHome.dart';
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
    // _getTicketing();

    _getUserDetails();

    // TODO: implement initState
    super.initState();
  }

  // void _getTicketing() {
  // DatabaseReference reference =
  //     FirebaseDatabase.instance.reference().child("Ticket").child(userphone);
  // reference.onValue.listen((event) {
  //   // print(event.snapshot.value);
  //   setState(() {
  //     checkInModel = CheckInModel.fromJson(event.snapshot.value);
  //     // print(checkInModel.data);
  //     // for (int) {
  //     if (checkInModel.data[0].porterId == "001" &&
  //         checkInModel.data[0].read == false) {
  //       checkin(context,
  //           "Bismark Amo, with 0541544404 has bought a ticket, Please check him in");
  //       print(checkInModel.data[0].phone);
  //     }
  //     //removing live marker and updating its location
  //     // markers.removeWhere(
  //     //   (m) => m.markerId.value == "${data.userId}",
  //     // );

  //     // }
  //   });
  // });
  // }

  _getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("userDetails")) {
      String encodedData = prefs.getString("userDetails");
      var decodeData = json.decode(encodedData);
      // print(decodeData['data']['staffs'].length);
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
                          builder: (context) => GeneralManagerPage(
                            stationID: stationId,
                            title: "Admin",
                          ),
                        ),
                      );
                    } else if (x['account_type']['id'] == 2) {
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
                          builder: (context) => GeneralManagerPage(
                            stationID: stationId,
                            title: "General Manager",
                          ),
                        ),
                      );
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
                          builder: (context) => DriverHomePage(
                            id: stationId,
                          ),
                        ),
                      );
                    } else if (x['account_type']['id'] == 5) {
                    } else if (x['account_type']['id'] == 6) {
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
                          builder: (context) => ConductorHomePage(
                            id: stationId,
                          ),
                        ),
                      );
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
              ),
          SizedBox(
            height: 8,
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListTile(
                title: Text("User App"),
                // subtitle: Text(x['station']['name']),
                leading: Icon(Icons.person),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemMenu1(
                        isStaff: isStaff,
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  _getLoading(stid) async {
    final url = Uri.parse("$BASE_URL/stations/$stid/loading_bus");
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $accessToken",
      },
    ).timeout(
      Duration(seconds: 50),
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['status'] == 200) {
        // print(responseData['data']);
        carNumber = responseData['data']['bus']['reg_number'];
      } else if (response.statusCode == 401) {
        sessionExpired(context);
      }
    }
  }
}
