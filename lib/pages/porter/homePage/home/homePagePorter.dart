import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/components/alerts.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/pages/porter/homePage/home/priorityBus.dart';
import 'package:oya_porter/pages/porter/homePage/home/scaledBus.dart';
import 'package:oya_porter/pages/porter/homePage/schedule/porterSchedules.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:http/http.dart' as http;
import 'package:oya_porter/spec/strings.dart';
import 'package:oya_porter/spec/styles.dart';

String carNumber = "";

class HomePagePorter extends StatefulWidget {
  @override
  _HomePagePorterState createState() => _HomePagePorterState();
}

class _HomePagePorterState extends State<HomePagePorter> {
  List firstName = userName.split(" ");

  String scheduleID;
  int pri, sca;

  bool isLoading = false;
  @override
  void initState() {
    _getLoading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: isLoading
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome ${firstName[0]}",
                        style: h2Black,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Role: Porter",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: PRIMARYCOLOR,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: carNumber == "" || carNumber == null
                        ? Text(
                            "No Loading Bus",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: RED,
                            ),
                          )
                        : Text(
                            "$carNumber (Scaled)",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: RED,
                            ),
                          )),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _cardItem(context, onContinue: () {
                        _checkPrio().whenComplete(() => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScaledBusses(
                                    scheduleID: stationId,
                                  ),
                                ),
                              )
                            });
                      }, name: "Scaled", image: "assets/images/admin/bus.png"),
                      _cardItem(context, onContinue: () {
                        _checkMigrationScal().whenComplete(() => {
                              print(priorityLength),
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PriorityBuses(
                                    scheduleID: stationId,
                                  ),
                                ),
                              )
                            });
                      },
                          name: "Priority",
                          image: "assets/images/admin/bus.png"),
                    ],
                  ),
                )
              ],
            ),
    );
  }

  Future<void> _checkMigrationScal() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(
      "$BASE_URL/stations/$stationId/scaled_buses",
      headers: {
        "Authorization": "Bearer $accessToken",
        'Content-Type': 'application/json'
      },
    ).timeout(Duration(seconds: 30));
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      final responseData = json.decode(response.body);
      if (responseData['status'] == 200) {
        print("Data: $responseData");

        setState(() {
          scaledLength = (responseData['data'][0]['passengers_count']);
        });
        print("------------------$scaledLength");
      }
    }else if (response.statusCode == 401) {
      sessionExpired(context);
    } else {
      toastContainer(text: "Error has occured");
    }
  }

  Future<void> _checkPrio() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(
      "$BASE_URL/stations/$stationId/priority_buses",
      headers: {
        "Authorization": "Bearer $accessToken",
        'Content-Type': 'application/json'
      },
    ).timeout(Duration(seconds: 30));
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      final responseData = json.decode(response.body);
      if (responseData['status'] == 200) {
        setState(() {
          priorityLength = (responseData['data'][0]['passengers_count']);
        });
        print("-------------------$priorityLength");
      }
    }else if (response.statusCode == 401) {
      sessionExpired(context);
    } else {
      toastContainer(text: "Error has occured");
    }
  }

  _getLoading() async {
    final response = await http.get(
      "$BASE_URL/stations/$stationId/loading_bus",
      headers: {
        "Authorization": "Bearer $accessToken",
        'Content-Type': 'application/json'
      },
    ).timeout(
      Duration(seconds: 50),
    );
    if (response.statusCode == 200) {
      setState(() => isLoading = false);
      final responseData = json.decode(response.body);
      if (responseData['status'] == 200 || responseData['data'] != null) {
        print(responseData['data']);
        carNumber = responseData['data']['bus']['reg_number'];
        pri = responseData['data']['priority'];
        sca = responseData['data']['scaled'];
        setState(() {});
      }
    }else if (response.statusCode == 401) {
      sessionExpired(context);
    } else {
      toastContainer(text: "Error has occured");
    }
  }
}

_cardItem(BuildContext context,
    {String image, String name, Function onContinue}) {
  return Card(
    child: GestureDetector(
      onTap: onContinue,
      child: Container(
          width: MediaQuery.of(context).size.width / 2.3,
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              ClipOval(
                child: Container(
                  height: 90,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "$name",
                style: TextStyle(
                  color: PRIMARYCOLOR,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          )),
    ),
  );
}
