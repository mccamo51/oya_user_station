import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oya_porter/bloc/busTypeBloc.dart';
import 'package:oya_porter/bloc/driverBloc.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/navigation.dart';
import 'package:oya_porter/config/offlineData.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/models/busTypeModel.dart';
import 'package:oya_porter/models/driverModel.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/colors.dart';
import 'widgets/addbusWidget.dart';
import 'package:http/http.dart' as http;

class AddBus extends StatefulWidget {
  @override
  _AddBusState createState() => _AddBusState();
}

class _AddBusState extends State<AddBus> {
  TextEditingController busTypeController = TextEditingController();
  TextEditingController busModelController = TextEditingController();
  TextEditingController busDriverController2 = TextEditingController();
  TextEditingController insExpController = TextEditingController();
  TextEditingController regNoController = TextEditingController();
  TextEditingController roadWorthyExpController = TextEditingController();

  String busId, driverId;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : addBusWidget(
              onRoadWorthy: () => _pickDate(roadWorthyExpController),
              onInsurance: () => _pickDate(insExpController),
              context: context,
              busModelController: busModelController,
              busTypeController: busTypeController,
              busTypeController2: busDriverController2,
              insExpController: insExpController,
              onSave: () => _onSave(
                  busId: busId,
                  driverId: driverId,
                  regNo: regNoController.text,
                  model: busModelController.text,
                  road_exp_date: roadWorthyExpController.text,
                  ins_exp_date: insExpController.text,
                  staId: stationId),
              regNoController: regNoController,
              roadWorthyExpController: roadWorthyExpController,
              onSelectBus: () => androidSelectCity(
                    context: context,
                    title: "Select Bus Type",
                  ),
              onSelectDriver: () => androidSelectDriver(
                    context: context,
                    title: "Select Bus Driver",
                  )),
    );
  }

  _pickDate(TextEditingController controller) async {
    DateTime now = DateTime.now();
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: now,
    );
    if (date != null)
      setState(() {
        controller.text = DateFormat.yMMMMEEEEd().format(date);
      });
  }

  void _showDatePicker(ctx, TextEditingController controller) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 200,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (val) {
                          setState(() {
                            controller.text =
                                DateFormat.yMMMMEEEEd().format(val);
                          });
                        }),
                  ),
                ],
              ),
            ));
  }

  _onSave(
      {String staId,
      String busId,
      String regNo,
      String ins_exp_date,
      String road_exp_date,
      String model,
      String driverId}) async {
    if (regNo.isEmpty || road_exp_date.isEmpty || ins_exp_date.isEmpty) {
      toastContainer(text: "All this fields are required");
    } else {
      setState(() {
        isLoading = true;
      });
      try {
        print("$driverId");
        Map<String, dynamic> body = {
          'station_id': staId,
          'bus_type_id': busId,
          'reg_number': regNo,
          'model': model,
          'driver_id': driverId,
          'rw_exp_date': '$road_exp_date',
          'insurance_exp_date': '$ins_exp_date',
          'image': ''
        };
      final url = Uri.parse( "$BASE_URL/buses");

        final response = await http.post(
         url,
          body: json.encode(body),
          headers: {
            "Authorization": "Bearer $accessToken",
            "Content-Type": "application/json",
          },
        ).timeout(
          Duration(seconds: 50),
        );
        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          setState(() {
            isLoading = false;
          });
          if (responseData['status'] == 200) {
            toastContainer(text: responseData['message']);
            Navigator.pop(context);
          } else {
            toastContainer(text: responseData['message']);
          }
        } else if (response.statusCode == 401) {
          sessionExpired(context);
        } else {
          toastContainer(text: "Error has occured");
        }
      } on TimeoutException catch (e) {
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        print(e);
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Widget _mBusT(BusTypeModel model, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var data in model.data) ...[
          Platform.isIOS
              ? CupertinoActionSheetAction(
                  child: Text('${data.name}', style: TextStyle(color: BLACK)),
                  onPressed: () {
                    setState(() {
                      // _toCode = data.id;
                      busId = (data.id).toString();
                      busTypeController.text = data.name;
                    });

                    Navigator.pop(context);
                  },
                )
              : SimpleDialogOption(
                  onPressed: () {
                    busId = (data.id).toString();
                    busTypeController.text = data.name;
                    Navigator.pop(context);
                  },
                  child: Text("${data.name}", style: TextStyle(fontSize: 20)),
                ),
          Divider(),
        ]
      ],
    );
  }

  Widget allBusType() {
    // loadBusTypeModelOffline();
    busTypeBloc.fetchDrivers(context);
    return StreamBuilder<Object>(
      stream: busTypeBloc.busesType,
      // initialData: busTypeModelMapOffline == null
      //     ? null
      //     : BusTypeModel.fromJson(busTypeModelMapOffline),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return _mBusT(snapshot.data, context);
        } else if (snapshot.hasError) {
          return Text("Error");
        }
        return Center(child: CupertinoActivityIndicator(radius: 15));
      },
    );
  }

  Future<void> androidSelectCity({String title, BuildContext context}) async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('$title'),
            children: <Widget>[allBusType()],
          );
        })) {
    }
  }

  Widget _mDriver(DriversModel model, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var data in model.data) ...[
          Platform.isIOS
              ? CupertinoActionSheetAction(
                  child:
                      Text('${data.user.name}', style: TextStyle(color: BLACK)),
                  onPressed: () {
                    setState(() {
                      // _toCode = data.id;
                      driverId = (data.id).toString();
                      busDriverController2.text = data.user.name;
                    });

                    Navigator.pop(context);
                  },
                )
              : SimpleDialogOption(
                  onPressed: () {
                    driverId = (data.id).toString();
                    busDriverController2.text = data.user.name;
                    Navigator.pop(context);
                  },
                  child:
                      Text("${data.user.name}", style: TextStyle(fontSize: 20)),
                ),
          Divider(),
        ]
      ],
    );
  }

  Widget allDrivers() {
    // loadDriverOffline();
    driverBloc.fetchDrivers(stationId, context);
    return StreamBuilder<Object>(
      stream: driverBloc.drivers,
      // initialData: driversMapOffline == null
      //     ? null
      //     : DriversModel.fromJson(driversMapOffline),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return _mDriver(snapshot.data, context);
        } else if (snapshot.hasError) {
          return Text("Error");
        }
        return Center(child: CupertinoActivityIndicator(radius: 15));
      },
    );
  }

  Future<void> androidSelectDriver({String title, BuildContext context}) async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('$title'),
            children: <Widget>[allDrivers()],
          );
        })) {
    }
  }
}
