import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oya_porter/bloc/busesBloc.dart';
import 'package:oya_porter/bloc/conductorBloc.dart';
import 'package:oya_porter/bloc/driverBloc.dart';
import 'package:oya_porter/bloc/myRouteBloc.dart';
import 'package:oya_porter/bloc/porterBloc.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/buttons.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/config/offlineData.dart';
import 'package:oya_porter/models/PorterModel.dart';
import 'package:oya_porter/models/busModel.dart';
import 'package:oya_porter/models/conductorModel.dart';
import 'package:oya_porter/models/driverModel.dart';
import 'package:oya_porter/models/myRouteModel.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/colors.dart';

import '../schedules.dart';

enum SelectPriority { PRIORITY, NOTPRI }

class Schedules extends StatefulWidget {
  @override
  _SchedulesState createState() => _SchedulesState();
}

class _SchedulesState extends State<Schedules> {
  var selectPrio = SelectPriority.PRIORITY;
  String busId, routId, driverId, conductorId, porterId;
  TextEditingController busController = TextEditingController();
  TextEditingController routeController = TextEditingController();
  TextEditingController driverController = TextEditingController();
  TextEditingController conductorController = TextEditingController();
  TextEditingController porterController = TextEditingController();
  TextEditingController arrivalDateTimeController = TextEditingController();
  TextEditingController deptimeDateController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  int priority = 0;

  var pickedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: ("Schedules"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () =>
                    androidSelectRoute(context: context, title: "Select Route"),
                child: textFormField(
                  hintText: "Select Route",
                  controller: routeController,
                  focusNode: null,
                  icon: Icons.arrow_drop_down,
                  enable: false,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () =>
                    androidSelectBus(context: context, title: "Select Bus"),
                child: textFormField(
                  hintText: "Select Bus",
                  controller: busController,
                  focusNode: null,
                  icon: Icons.arrow_drop_down,
                  enable: false,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () => androidSelectDriver(
                    context: context, title: "Select Driver"),
                child: textFormField(
                  hintText: "Select Driver",
                  controller: driverController,
                  focusNode: null,
                  icon: Icons.arrow_drop_down,
                  enable: false,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () => androidSelectConductor(
                    context: context, title: "Select Conductor"),
                child: textFormField(
                  hintText: "Select Conductor",
                  controller: conductorController,
                  focusNode: null,
                  icon: Icons.arrow_drop_down,
                  enable: false,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () => androidSelectPorter(
                    context: context, title: "Select Porter"),
                child: textFormField(
                  hintText: "Select Porter",
                  controller: porterController,
                  focusNode: null,
                  icon: Icons.arrow_drop_down,
                  enable: false,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () => _showDatePicker(context),
                child: textFormField(
                  hintText: "Departure Date/Time",
                  controller: deptimeDateController,
                  focusNode: null,
                  icon: Icons.arrow_drop_down,
                  enable: false,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () => _pickDate(),
                child: textFormField(
                  hintText: "Estimate Arrival Date/Time",
                  controller: arrivalDateTimeController,
                  focusNode: null,
                  icon: Icons.arrow_drop_down,
                  enable: false,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {},
                child: textFormField(
                  hintText: "Ticket Price",
                  controller: priceController,
                  focusNode: null,
                  labelText: "Ticket Price",
                  inputType: TextInputType.number,
                  // icon: Icons.arrow_drop_down,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Is this a Priority BUS?"),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [Text("Yes")],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: priority,
                            onChanged: (val) {},
                          ),
                          Text("No")
                        ],
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("A low ticket sales?"),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              value: true,
                              onChanged: ((val) {
                                print(val);
                              })),
                          Text("Yes")
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: false,
                              onChanged: ((val) {
                                print(val);
                              })),
                          Text("No")
                        ],
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("A low mid route boarding?"),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              value: true,
                              onChanged: ((val) {
                                print(val);
                              })),
                          Text("Yes")
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: false,
                              onChanged: ((val) {
                                print(val);
                              })),
                          Text("No")
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: primaryButton(title: "Save", onFunction: () {})),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _mBusT(BussModel model, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var data in model.data) ...[
          Platform.isIOS
              ? CupertinoActionSheetAction(
                  child: Text('${data.busType.name}',
                      style: TextStyle(color: BLACK)),
                  onPressed: () {
                    setState(() {
                      // _toCode = data.id;
                      busId = (data.id).toString();
                      busController.text = data.busType.name;
                    });

                    Navigator.pop(context);
                  },
                )
              : SimpleDialogOption(
                  onPressed: () {
                    busId = (data.id).toString();
                    busController.text = data.busType.name;
                    Navigator.pop(context);
                  },
                  child: Text("${data.busType.name}",
                      style: TextStyle(fontSize: 20)),
                ),
          Divider(),
        ]
      ],
    );
  }

  Widget allBus() {
    // loadAllCities();
    busesBloc.fetchAllStaffs(stationId);
    return StreamBuilder<Object>(
      stream: busesBloc.allBuses,
      initialData:
          busesMapOffline == null ? null : BussModel.fromJson(busesMapOffline),
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

  Future<void> androidSelectBus({String title, BuildContext context}) async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('$title'),
            children: <Widget>[allBus()],
          );
        })) {
    }
  }

  Widget _mRoute(MyRouteModel model, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var data in model.data) ...[
          Platform.isIOS
              ? CupertinoActionSheetAction(
                  child: Text('${data.from.name} - ${data.to.name}',
                      style: TextStyle(color: BLACK)),
                  onPressed: () {
                    setState(() {
                      routId = data.id.toString();
                      routeController.text =
                          "${data.from.name} - ${data.to.name}";
                    });

                    Navigator.pop(context);
                  },
                )
              : SimpleDialogOption(
                  onPressed: () {
                    routId = data.id.toString();
                    routeController.text =
                        "${data.from.name} - ${data.to.name}";
                    Navigator.pop(context);
                  },
                  child: Text("${data.from.name} - ${data.to.name}",
                      style: TextStyle(fontSize: 20)),
                ),
          Divider(),
        ]
      ],
    );
  }

  Widget allRoute() {
    // loadAllCities();
    myRouteBloc.fetchAllStaffs(stationId);
    return StreamBuilder<Object>(
      stream: myRouteBloc.myroutes,
      initialData: myRouteMapOffline == null
          ? null
          : MyRouteModel.fromJson(myRouteMapOffline),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return _mRoute(snapshot.data, context);
        } else if (snapshot.hasError) {
          return Text("Error");
        }
        return Center(child: CupertinoActivityIndicator(radius: 15));
      },
    );
  }

  Future<void> androidSelectRoute({String title, BuildContext context}) async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('$title'),
            children: <Widget>[allRoute()],
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
                      driverController.text = data.user.name;
                    });

                    Navigator.pop(context);
                  },
                )
              : SimpleDialogOption(
                  onPressed: () {
                    driverId = (data.id).toString();
                    driverController.text = data.user.name;
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

  Widget allDriver() {
    loadDriverOffline();
    driverBloc.fetchDrivers(stationId);
    return StreamBuilder<Object>(
      stream: driverBloc.drivers,
      initialData: driversMapOffline == null
          ? null
          : DriversModel.fromJson(driversMapOffline),
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
            children: <Widget>[allDriver()],
          );
        })) {
    }
  }

  Widget _mConductor(ConductorModel model, BuildContext context) {
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
                      conductorId = data.id.toString();
                      conductorController.text = "${data.user.name}";
                    });

                    Navigator.pop(context);
                  },
                )
              : SimpleDialogOption(
                  onPressed: () {
                    conductorId = data.id.toString();
                    conductorController.text = "${data.user.name}";
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

  Widget allConductor() {
    loadconductorsOffline();
    conductorBloc.fetchConductors(stationId);
    return StreamBuilder<Object>(
      stream: conductorBloc.conductors,
      initialData: conductorsMapOffline == null
          ? null
          : ConductorModel.fromJson(conductorsMapOffline),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return _mConductor(snapshot.data, context);
        } else if (snapshot.hasError) {
          return Text("Error");
        }
        return Center(child: CupertinoActivityIndicator(radius: 15));
      },
    );
  }

  Future<void> androidSelectConductor(
      {String title, BuildContext context}) async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('$title'),
            children: <Widget>[allConductor()],
          );
        })) {
    }
  }

  Widget _mPorter(PortersModel model, BuildContext context) {
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
                      porterId = data.id.toString();
                      porterController.text = "${data.user.name}";
                    });

                    Navigator.pop(context);
                  },
                )
              : SimpleDialogOption(
                  onPressed: () {
                    porterId = data.id.toString();
                    porterController.text = "${data.user.name}";
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

  Widget allPorter() {
    loadportersOffline();
    porterBloc.fetchPorters(stationId);
    return StreamBuilder<Object>(
      stream: porterBloc.porters,
      initialData: portersMapOffline == null
          ? null
          : PortersModel.fromJson(portersMapOffline),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return _mPorter(snapshot.data, context);
        } else if (snapshot.hasError) {
          return Text("Error");
        }
        return Center(child: CupertinoActivityIndicator(radius: 15));
      },
    );
  }

  Future<void> androidSelectPorter({String title, BuildContext context}) async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('$title'),
            children: <Widget>[allPorter()],
          );
        })) {
    }
  }

  void _showDatePicker(ctx) {
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
                            deptimeDateController.text =
                                DateFormat.yMMMMEEEEd().format(val);
                          });
                        }),
                  ),
                ],
              ),
            ));
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate,
    );
    if (date != null)
      setState(() {
        arrivalDateTimeController.text = DateFormat.yMMMMEEEEd().format(date);
      });
  }
}
