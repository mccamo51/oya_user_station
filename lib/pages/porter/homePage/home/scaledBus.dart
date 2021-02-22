import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/bloc/scaledBusBloc.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/emptyBox.dart';
import 'package:oya_porter/config/offlineData.dart';
import 'package:oya_porter/models/scaledBusModel.dart';
import 'package:oya_porter/pages/porter/homePage/loadBus/loadBus.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/styles.dart';

class ScaledBusses extends StatefulWidget {
  final scheduleID;
  ScaledBusses({@required this.scheduleID});

  @override
  _ScaledBussesState createState() => _ScaledBussesState();
}

class _ScaledBussesState extends State<ScaledBusses> {
  @override
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
          : StreamBuilder(
              stream: scaledBloc.scaledBuses,
              // initialData: scaledBusMapOffline == null
              //     ? null
              //     : ScaledBusModel.fromJson(scaledBusMapOffline),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                                  company:
                                      x.bus.driver.station.busCompany.name),
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
}

_scaledCard({Function onTap, String number}) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      color: PRIMARYCOLOR,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Text(
            "GE-53452 2020[4272]",
            style: h3WHITE,
          ),
        ),
      ),
    ),
  );
}
