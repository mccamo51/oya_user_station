import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/bloc/myRouteBloc.dart';
import 'package:oya_porter/bloc/scheduleBloc.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/emptyBox.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/navigation.dart';
import 'package:oya_porter/config/offlineData.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/models/ScheduleModel.dart';
import 'package:oya_porter/models/myRouteModel.dart';
import 'package:oya_porter/pages/admin/schedules/widgets/seachWidgetBus.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/styles.dart';
import 'package:http/http.dart' as http;

class AddTicket extends StatefulWidget {
  @override
  _AddTicketState createState() => _AddTicketState();
}

class _AddTicketState extends State<AddTicket> {
  final _routeController = TextEditingController();
  final _busController = TextEditingController();

  TextEditingController paymentModeController = TextEditingController();
  TextEditingController paymentTypeController = TextEditingController();

  TextEditingController priceController = TextEditingController();
  TextEditingController reciepeintNameController = TextEditingController();
  TextEditingController reciepeintPhoneController = TextEditingController();
  TextEditingController minorController = TextEditingController();
  // TextEditingController minorController = TextEditingController();
  String network, payType;
  bool showMomo = true;
  String schedleId, routeID;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadMyRouteOffline();
    myRouteBloc.fetchAllStaffs(stationId, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Sell Ticket"),
      body: isLoading
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => androidSelectRoute(
                        context: context,
                        title: "Select Route",
                      ),
                      child: textFormField(
                          hintText: "Select Route",
                          controller: _routeController,
                          focusNode: null,
                          icon: Icons.arrow_drop_down,
                          enable: false),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () => androidSelectBusSchedule(
                          context: context, title: "Select Bus"),
                      child: textFormField(
                          hintText: "Select Bus",
                          controller: _busController,
                          focusNode: null,
                          icon: Icons.arrow_drop_down,
                          enable: false),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    textFormField(
                      hintText: "Recipient Name",
                      controller: reciepeintNameController,
                      focusNode: null,
                      labelText: "Recipient Name",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    textFormField(
                      hintText: "Minors",
                      controller: minorController,
                      inputType: TextInputType.number,
                      textLength: 3,
                      focusNode: null,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () => _onPaymentType(context),
                      child: textFormField(
                        hintText: "Select Payment Type",
                        controller: paymentTypeController,
                        focusNode: null,
                        enable: false,
                        labelText: "Select Payment Type",
                        icon: Icons.money,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: showMomo,
                      child: GestureDetector(
                        onTap: () => _onNetwork(context),
                        child: textFormField(
                          hintText: "Select Payment Mode",
                          controller: paymentModeController,
                          focusNode: null,
                          enable: false,
                          labelText: "Select Payment Mode",
                          // icon: Icons.calendar_today,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    textFormField(
                      hintText: "Enter momo number",
                      controller: reciepeintPhoneController,
                      inputType: TextInputType.phone,
                      focusNode: null,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    textFormField(
                      hintText: "Price",
                      controller: priceController,
                      focusNode: null,
                      labelText: "Price",
                      inputType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Container(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoButton(
              color: PRIMARYCOLOR,
              child: Text("Submit"),
              onPressed: () => _onSave(
                  busID: schedleId,
                  phone: userphone,
                  momoPhone: reciepeintPhoneController.text,
                  price: priceController.text,
                  momoName: reciepeintNameController.text,
                  minor: minorController.text,
                  mapymentMode: network)),
        ),
      ),
    );
  }

  _onSave(
      {String busID,
      String phone,
      String minor,
      String momoName,
      String price,
      String mapymentMode,
      String momoPhone}) async {
    print(phone);
    setState(() {
      isLoading = true;
    });
    try {
      Map<String, dynamic> body = {
        'bus_schedule_id': busID,
        'phone': phone,
        'minor_count': minor,
        'payment_type': mapymentMode,
        'momo_phone': momoPhone,
        'momo_name': '$momoName',
        'price': '$price',
      };
      print(busID);
      final response = await http.post(
        "$BASE_URL/stations/$stationId/tickets",
        body: json.encode(body),
        headers: {
          "Authorization": "Bearer $accessToken",
          'Content-Type': 'application/json'
        },
      ).timeout(
        Duration(seconds: 50),
      );
      print(response.body);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          isLoading = false;
        });
        if (responseData['status'] == 200) {
          paymentDialog(context, responseData["message"]);
        } else {
          toastContainer(text: responseData['message']);
        }
      } else if (response.statusCode == 401) {
        sessionExpired(context);
      } else {
        toastContainer(text: "Error has occured");
      }
    } on TimeoutException catch (e) {
      print(e);
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
  // }

  Future<void> paymentDialog(BuildContext context, msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: SingleChildScrollView(
            child: Text(
              // 'Your ICE contact is needed for a variety of reasons.',
              '$msg',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Go Home', style: TextStyle(color: PRIMARYCOLOR)),
              onPressed: () {
                navigation(context: context, pageName: "home");
              },
            ),
          ],
        );
      },
    );
  }

  _onPaymentType(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Select Payment Type'),
        children: [
          ListTile(
            title: Text('Momo', style: h3Black),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).pop();
              setState(() {
                paymentTypeController.text = 'Momo';
                payType = "momo";
                showMomo = true;
              });
            },
          ),
        ],
      ),
    );
  }

  void _onNetwork(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Select network'),
        children: [
          ListTile(
            title: Text('AirtelTigo Money', style: h3Black),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).pop();
              setState(() {
                paymentModeController.text = 'AirtelTigo Money';
                network = "at";
              });
            },
          ),
          ListTile(
            title: Text('MTN Mobile Money', style: h3Black),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).pop();
              setState(() {
                paymentModeController.text = 'MTN Mobile Money';
                network = "mtn";
              });
            },
          ),
          ListTile(
            title: Text('Vodafone Cash', style: h3Black),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).pop();
              setState(() {
                paymentModeController.text = 'Vodafone Cash';
                network = "vfc";
              });
            },
          ),
        ],
      ),
    );
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
                      routeID = data.id.toString();

                      _routeController.text =
                          "${data.from.name} - ${data.to.name}";
                    });

                    Navigator.pop(context);
                    // Navigator.pop(context);
                  },
                )
              : SimpleDialogOption(
                  onPressed: () {
                    routeID = data.id.toString();
                    _routeController.text =
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

  Future<void> androidSelectRoute({String title, BuildContext context}) async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text("$title"),
            children: [ticketFromFuture()],
          );
        })) {
    }
  }

  Widget ticketFromFuture() {
    return StreamBuilder<Object>(
      stream: myRouteBloc.myroutes,
      initialData: myRouteMapOffline == null
          ? null
          : MyRouteModel.fromJson(myRouteMapOffline),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) return _mRoute(snapshot.data, context);
        } else if (snapshot.hasError) {
          return emptyBox(context);
        }
        return Center(child: CupertinoActivityIndicator(radius: 15));
      },
    );
  }

  Widget allScheduled() {
    loadallSchedulesOffline();
    scheduleBloc.fetchAllStaffs(id: stationId, routeId: routeID);
    return StreamBuilder<Object>(
      stream: scheduleBloc.allRating,
      initialData: schedulesMapOffline == null
          ? null
          : ScheduleModel.fromJson(schedulesMapOffline),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return _scheduleM(snapshot.data, context);
        } else if (snapshot.hasError) {
          return Text("Error");
        }
        return Center(child: CupertinoActivityIndicator(radius: 15));
      },
    );
  }

  Future<void> androidSelectBusSchedule(
      {String title, BuildContext context}) async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text("$title"),
            children: [allScheduled()],
          );
        })) {
    }
  }

  Widget _scheduleM(ScheduleModel model, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var data in model.data) ...[
          Platform.isIOS
              ? CupertinoActionSheetAction(
                  child: Text('${data.bus.regNumber} - [${data.bus.model}]',
                      style: TextStyle(color: BLACK)),
                  onPressed: () {
                    setState(() {
                      schedleId = data.id.toString();

                      _busController.text =
                          "${data.bus.regNumber} - [${data.bus.model}]";
                    });

                    Navigator.pop(context);
                  },
                )
              : SimpleDialogOption(
                  onPressed: () {
                    schedleId = data.id.toString();

                    _busController.text =
                        "${data.bus.regNumber} - [${data.bus.model}]";
                    Navigator.pop(context);
                  },
                  child: Text("${data.bus.regNumber} - [${data.bus.model}]",
                      style: TextStyle(fontSize: 20)),
                ),
          Divider(),
        ]
      ],
    );
  }
}
