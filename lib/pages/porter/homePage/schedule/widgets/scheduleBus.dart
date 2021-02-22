import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/bloc/scaledBusBloc.dart';
import 'package:oya_porter/components/emptyBox.dart';
import 'package:oya_porter/config/offlineData.dart';
import 'package:http/http.dart' as http;
import 'package:oya_porter/models/scaledBusModel.dart';

class ScheduledBus extends StatefulWidget {
  final stationId;
  ScheduledBus({@required this.stationId});
  @override
  _ScheduledBusState createState() => _ScheduledBusState();
}

class _ScheduledBusState extends State<ScheduledBus> {
  bool isLoading = false;
  @override
  void initState() {
    scaledBloc.fetchScaledBuses(widget.stationId);
    loadScaledBusOffline();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("==========${widget.stationId}");
    return Scaffold(
      body: isLoading
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : StreamBuilder(
              stream: scaledBloc.scaledBuses,
              initialData: scaledBusMapOffline == null
                  ? null
                  : ScaledBusModel.fromJson(scaledBusMapOffline),
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
                    ListTile(
                      title: Text("Bus: ${x.bus.busType.name}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text("Driver: ${x.staffs[1].name}"),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                              "Departure: ${x.departureDate} @ ${x.departureTime}"),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Arrival: ${x.arrivalDate} @ ${x.arrivalTime}"),
                        ],
                      ),
                      leading: Icon(FeatherIcons.truck),
                      // trailing: Column(
                      //   children: [
                      //     Text("${x.bus.driver.station.name}"),
                      //     Text("${x.bus.regNumber}"),
                      //   ],
                      // ),
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
