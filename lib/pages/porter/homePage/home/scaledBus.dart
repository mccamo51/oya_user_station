import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/bloc/scaledBusBloc.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/emptyBox.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/models/scaledBusModel.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/pages/porter/homePage/home/homePagePorter.dart';
import 'package:oya_porter/pages/porter/homePage/home/priorityBus.dart';
import 'package:oya_porter/pages/porter/homePage/loadBus/loadBus.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/styles.dart';
import 'package:http/http.dart' as http;

class ScaledBusses extends StatefulWidget {
  final scheduleID, busID, busNo;
  ScaledBusses(
      {@required this.scheduleID, @required this.busID, @required this.busNo});

  @override
  _ScaledBussesState createState() => _ScaledBussesState();
}

class _ScaledBussesState extends State<ScaledBusses> {
  @override
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 3));
    scaledBloc.fetchScaledBuses(widget.scheduleID, context);

    return null;
  }

  void initState() {
    // TODO: implement initState
    scaledBloc.fetchScaledBuses(widget.scheduleID, context);
    // loadScaledBusOffline();
    super.initState();
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Scaled Buses"),
      body: _isLoading
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : RefreshIndicator(
              onRefresh: refreshList,
              key: refreshKey,
              child: StreamBuilder(
                stream: scaledBloc.scaledBuses,
                // initialData: scaledBusMapOffline == null
                //     ? null
                //     : ScaledBusModel.fromJson(scaledBusMapOffline),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  print("snapshot: ${snapshot.data}");
                  if (snapshot.hasData) {
                    return _mainContent(snapshot.data);
                  } else if (snapshot.hasError) {
                    return Scaffold(body: emptyBox(context));
                  }
                  return Center(
                    child: CupertinoActivityIndicator(),
                  );
                },
              ),
            ),
    );
  }

  Widget _mainContent(ScaledBusModel bussModel) {
    // print(bussModel.data);
    print("==============${bussModel.data[0].loading}");

    if (bussModel.data != null && bussModel.data.length > 0)
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  for (int x = 0; x < bussModel.data.length; x++)
                    Card(
                      // color: PRIMARYCOLOR,
                      child: ListTile(
                          title: Text(
                              "Bus No: ${bussModel.data[x].bus.regNumber} [${bussModel.data[x].code.toString()}]"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${bussModel.data[x].bus.driver.station.name}",
                                    style: h3Black,
                                  ),
                                  Text(
                                    "${bussModel.data[x].bus.regNumber}",
                                    style: h3Black,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                  "Driver: ${bussModel.data[x].staffs[1].name}"),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                  "Phone: ${bussModel.data[x].staffs[1].phone}"),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                FeatherIcons.truck,
                                color: PRIMARYCOLOR,
                              ),
                              SizedBox(height: 10),
                              bussModel.data[x].passengersCount > 0
                                  ? Text("Loading",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: PRIMARYCOLOR))
                                  : Text("Scaled",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: RED))
                            ],
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                          ),
                          onTap: () {
                            if (priorityLength > 0) {
                              exceptionAlert(
                                context: context,
                                title: "Confimation",
                                message:
                                    "You are already loading bus# $carNumber, Will you like to migrate to bus# ${bussModel.data[x].bus.regNumber}?",
                                onMigrate: () {
                                  _migratePassenger(
                                      busId:
                                          bussModel.data[x].bus.id.toString(),
                                      context: context,
                                      scheduleID:
                                          bussModel.data[x].id.toString());
                                  Navigator.pop(context);
                                },
                              );
                            } else if (widget.busID ==
                                bussModel.data[x].bus.id.toString()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoadBuses(
                                    scheduleId: bussModel.data[x].id.toString(),
                                    minorCount:
                                        bussModel.data[x].minors.toString(),
                                    passengerCount: bussModel
                                        .data[x].passengersCount
                                        .toString(),
                                    from: bussModel.data[x].route.from.name,
                                    to: bussModel.data[x].route.to.name,
                                    carNo: bussModel.data[x].bus.regNumber,
                                    company: bussModel
                                        .data[x].station.busCompany.name,
                                  ),
                                ),
                              );
                            } else {
                              exceptionAlert(
                                context: context,
                                title: "Confimation",
                                message:
                                    "You are already loading bus# ${widget.busNo} Will you like to migrate to bus# ${bussModel.data[x].bus.regNumber}?",
                                onMigrate: () {
                                  _migratePassenger(
                                      busId:
                                          bussModel.data[x].bus.id.toString(),
                                      context: context,
                                      scheduleID:
                                          bussModel.data[x].id.toString());
                                  Navigator.pop(context);
                                },
                              );
                            }
                          }
                          // else {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => LoadBuses(
                          //         scheduleId: bussModel.data[x].id.toString(),
                          //         minorCount:
                          //             bussModel.data[x].minors.toString(),
                          //         passengerCount: bussModel
                          //             .data[x].passengersCount
                          //             .toString(),
                          //         from: bussModel.data[x].route.from.name,
                          //         to: bussModel.data[x].route.to.name,
                          //         carNo: bussModel.data[x].bus.regNumber,
                          //         company:
                          //             bussModel.data[x].station.busCompany.name,
                          //       ),
                          //     ),
                          //   );
                          // }
                          // },
                          ),
                    )
                ],
              ),
            ),
          ],
        ),
      );
    else
      return emptyBox(context);
  }

  _checkMigration(
      {String id,
      busId,
      minors,
      passengersCount,
      from,
      to,
      regNumber,
      busCompany}) async {
    setState(() {
      _isLoading = true;
    });
    final url = Uri.parse("$BASE_URL/stations/$stationId/priority_buses");

    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $accessToken",
        'Content-Type': 'application/json'
      },
    ).timeout(Duration(seconds: 30));
    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      final responseData = json.decode(response.body);
      if (responseData['status'] == 200) {
        print(responseData);
        if (responseData['data'][0]['passengers_count'] > 0) {
          exceptionAlert(
            context: context,
            title: "Confimation",
            message: "Do you want to maigrate passengers to a different bus?",
            onMigrate: () {
              _migratePassenger(busId: busId, scheduleID: id, context: context);
              Navigator.pop(context);
            },
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoadBuses(
                scheduleId: id,
                minorCount: minors,
                passengerCount: passengersCount,
                from: from,
                to: to,
                carNo: regNumber,
                company: busCompany,
              ),
            ),
          );
        }
      }
      print(_isLoading);
    } else if (response.statusCode == 401) {
      sessionExpired(context);
    } else {
      setState(() {
        _isLoading = false;
      });
      toastContainer(text: "Error has occured");
    }
  }

  _migratePassenger(
      {@required String scheduleID,
      @required String busId,
      BuildContext context}) async {
    // setState(() {
    //   _isLoading = true;
    // });
    Map<String, dynamic> body = {
      'to': '$busId',
    };
    final url = Uri.parse("$BASE_URL/schedules/$scheduleID/migrate_manifest");

    try {
      final response = await http.post(url, body: json.encode(body), headers: {
        "Authorization": "Bearer $accessToken",
        'Content-Type': 'application/json'
      }).timeout(
        Duration(seconds: 50),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("======================$responseData");
        if (responseData['status'] == 200) {
          // setState(() {
          //   _isLoading = false;
          // });
          print(responseData['data']);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoadBuses(
                scheduleId: responseData['data']['id'].toString(),
                minorCount: responseData['data']['minors'].toString(),
                passengerCount:
                    responseData['data']['passengers_count'].toString(),
                from: responseData['data']['route']['from']['name'],
                to: responseData['data']['route']['to']['name'],
                carNo: responseData['data']['bus']['reg_number'],
                company: responseData['data']['station']['bus_company']['name'],
              ),
            ),
          );
        }
      } else if (response.statusCode == 401) {
        sessionExpired(context);
      } else {
        setState(() {
          _isLoading = false;
        });
        toastContainer(text: "Error has occured");
      }
    } on TimeoutException catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    } on SocketException catch (f) {
      print(f);
      setState(() {
        _isLoading = false;
      });
    } catch (g) {
      print(g);
      setState(() {
        _isLoading = false;
      });
    }
  }
}
