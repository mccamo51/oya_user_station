import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/bloc/priorityBloc.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/emptyBox.dart';
import 'package:oya_porter/config/offlineData.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/models/priorityBusModel.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/pages/porter/homePage/loadBus/loadBus.dart';
import 'package:http/http.dart' as http;
import 'package:oya_porter/spec/colors.dart';

int priorityLength = 0, scaledLength = 0;

class PriorityBuses extends StatefulWidget {
  final scheduleID;
  PriorityBuses({@required this.scheduleID});
  @override
  _PriorityBusesState createState() => _PriorityBusesState();
}

class _PriorityBusesState extends State<PriorityBuses> {
  @override
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 3));
    priorityBusBloc.fetchPriorityBuses(widget.scheduleID);

    return null;
  }

  void initState() {
    priorityBusBloc.fetchPriorityBuses(widget.scheduleID);
    loadPriorityBusOffline();
    super.initState();
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Priority Buses"),
      body: SingleChildScrollView(
        child: _isLoading
            ? Center(
                child: CupertinoActivityIndicator(),
              )
            : RefreshIndicator(
                onRefresh: refreshList,
                key: refreshKey,
                child: StreamBuilder(
                  stream: priorityBusBloc.prioritybus,
                  initialData: priorityBusMapOffline == null
                      ? null
                      : PriorityBusModel.fromJson(priorityBusMapOffline),
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
      ),
    );
  }

  Widget _mainContent(PriorityBusModel bussModel) {
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
                      child: ListTile(
                        title: Text(
                            "Bus No: ${x.bus.regNumber} [${x.code.toString()}]"),
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
                          print(scaledLength);
                          if (scaledLength > 0)
                            exceptionAlert(
                              context: context,
                              title: "Confimation",
                              message:
                                  "Do you want to maigrate passengers to a different bus?",
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
                          // _checkMigration(
                          //     id: x.id.toString(),
                          //     busCompany: x.bus.driver.station.busCompany.name,
                          //     regNumber: x.bus.regNumber,
                          //     passengersCount: x.passengersCount.toString(),
                          //     minors: x.minors.toString(),
                          //     from: x.route.from.name,
                          //     to: x.route.to.name,
                          //     busId: x.bus.id.toString());
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
    print(responseData);
    if (responseData['status'] == 200) {
      print("Done");
    }
  }
}

Future<void> exceptionAlert(
    {BuildContext context,
    String title,
    String message,
    Function onMigrate}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
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
              child: Text('Migrate'),
              onPressed: onMigrate),
        ],
      );
    },
  );
}
