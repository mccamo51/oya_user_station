import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/bloc/busesBloc.dart';
import 'package:oya_porter/bloc/loadedBusBloc.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/emptyBox.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/offlineData.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:http/http.dart' as http;
import 'package:oya_porter/models/loadedBusModel.dart';
import 'package:oya_porter/pages/auth/login/login.dart';

class LoadedBuses extends StatefulWidget {
  final stationId;
  LoadedBuses({@required this.stationId});
  @override
  _LoadedBusesState createState() => _LoadedBusesState();
}

class _LoadedBusesState extends State<LoadedBuses> {
  bool isLoading = false;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 3));
    loadedBusBloc.fetchLoadedBuses(widget.stationId, context);

    return null;
  }

  @override
  void initState() {
    loadedBusBloc.fetchLoadedBuses(widget.stationId, context);
    // loadLoadedBusOffline();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : RefreshIndicator(
              onRefresh: refreshList,
              key: refreshKey,
              child: StreamBuilder(
                stream: loadedBusBloc.loadedbuses,
                // initialData: loadedbusesMapOffline == null
                //     ? null
                //     : LoadedBusModel.fromJson(loadedbusesMapOffline),
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

  Widget _mainContent(LoadedBusModel bussModel) {
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text("Bus No: ${x.bus.regNumber}"),
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
                              x.arrivalTime == null
                                  ? Text("Arrival: ${x.arrivalDate}")
                                  : Text(
                                      "Arrival: ${x.arrivalDate} @ ${x.arrivalTime}"),
                            ],
                          ),
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(FeatherIcons.truck),
                            ],
                          ),
                          // trailing: IconButton(
                          //   icon: Icon(Icons.delete_forever),
                          //   onPressed: () {},
                          // ),
                        ),
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

  // deleteBus({String busId}) async {
  //   print(busId);
  //   setState(() {
  //     isLoading = true;
  //   });
  //   try {
  //     final response = await http.delete(
  //       "$BASE_URL/buses/$busId",
  //       headers: {
  //         "Authorization": "Bearer $accessToken",
  //       },
  //     ).timeout(
  //       Duration(seconds: 50),
  //     );
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         isLoading = false;
  //       });
  //       final responseData = json.decode(response.body);
  //       if (responseData['status'] == 200) {
  //         toastContainer(text: responseData['message']);
  //         Navigator.pop(context);
  //       } else {
  //         toastContainer(text: responseData['message']);
  //       }
  //     }
  //   } on TimeoutException catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  // _editBus(
  //     {String staId,
  //     String busId,
  //     String regNo,
  //     String model,
  //     String driverId}) async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   try {
  //     print("$driverId");
  //     final response = await http.post(
  //       "$BASE_URL/buses",
  //       body: {
  //         'station_id': staId,
  //         'bus_type_id': busId,
  //         'reg_number': regNo,
  //         'model': model,
  //         'driver_id': driverId,
  //         'image': ''
  //       },
  //       headers: {
  //         "Authorization": "Bearer $accessToken",
  //       },
  //     ).timeout(
  //       Duration(seconds: 50),
  //     );
  //     if (response.statusCode == 200) {
  //       final responseData = json.decode(response.body);
  //       setState(() {
  //         isLoading = false;
  //       });
  //       if (responseData['status'] == 200) {
  //         toastContainer(text: responseData['message']);
  //         Navigator.pop(context);
  //       } else {
  //         toastContainer(text: responseData['message']);
  //       }
  //     }
  //   } on TimeoutException catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     print(e);
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }
}
