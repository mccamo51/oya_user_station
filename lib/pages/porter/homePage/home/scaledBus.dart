import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/bloc/scaledBusBloc.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/emptyBox.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/offlineData.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/models/scaledBusModel.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/pages/porter/homePage/home/priorityBus.dart';
import 'package:oya_porter/pages/porter/homePage/loadBus/loadBus.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/styles.dart';
import 'package:http/http.dart' as http;

class ScaledBusses extends StatefulWidget {
  final scheduleID;
  ScaledBusses({@required this.scheduleID});

  @override
  _ScaledBussesState createState() => _ScaledBussesState();
}

class _ScaledBussesState extends State<ScaledBusses> {
  @override
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 3));
    scaledBloc.fetchScaledBuses(widget.scheduleID);

    return null;
  }

  void initState() {
    // TODO: implement initState
    scaledBloc.fetchScaledBuses(widget.scheduleID);
    loadScaledBusOffline();
    super.initState();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Scaled Buses"),
      body: isLoading
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : RefreshIndicator(
              onRefresh: refreshList,
              key: refreshKey,
              child: StreamBuilder(
                stream: scaledBloc.scaledBuses,
                initialData: scaledBusMapOffline == null
                    ? null
                    : ScaledBusModel.fromJson(scaledBusMapOffline),
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
                  for (var x in bussModel.data)
                    Card(
                      // color: PRIMARYCOLOR,
                      child: ListTile(
                        title: Text(
                            "Bus No: ${x.bus.regNumber}[${x.code.toString()}]"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Text("Driver: ${x.staffs[1].name}"),
                            SizedBox(
                              height: 8,
                            ),
                            Text("Phone: ${x.staffs[1].phone}"),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FeatherIcons.truck),
                          ],
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${x.bus.driver.station.name}"),
                            Text("${x.bus.regNumber}"),
                          ],
                        ),
                        onTap: () {
                          print(priorityLength.toString());
                          if (priorityLength > 0)
                            exceptionAlert(
                              context: context,
                              title: "Confimation",
                              message:
                                  "You are already loading bus# ${x.bus.regNumber}, Will you like to migrate to bus# ${x.bus.regNumber}",
                              onMigrate: () {
                                _migratePassenger(
                                    busId: x.bus.id.toString(),
                                    scheduleID: x.id.toString());
                              },
                            );
                          else
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoadBuses(
                                  scheduleId: x.id.toString(),
                                  minorCount: x.minors.toString(),
                                  passengerCount: x.passengersCount.toString(),
                                  from: x.route.from.name,
                                  to: x.route.to.name,
                                  carNo: x.bus.regNumber,
                                  company: x.station.busCompany.name,
                                ),
                              ),
                            );
                        },
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
      isLoading = true;
    });
    final response = await http.get(
      "$BASE_URL/stations/$stationId/priority_buses",
      headers: {
        "Authorization": "Bearer $accessToken",
      },
    ).timeout(Duration(seconds: 30));
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
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
              _migratePassenger(busId: busId, scheduleID: id);
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
      print(isLoading);
    }
    setState(() {
      isLoading = false;
    });
  }

  _migratePassenger({
    @required String scheduleID,
    @required String busId,
  }) async {
    final response = await http
        .post("$BASE_URL/schedules/$scheduleID/migrate_manifest", body: {
      'to': '$busId',
    }, headers: {
      "Authorization": "Bearer $accessToken",
    }).timeout(
      Duration(seconds: 50),
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['status'] == 200) {}
    }
  }
}
