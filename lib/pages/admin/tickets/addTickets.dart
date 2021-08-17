import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/bloc/myRouteBloc.dart';
import 'package:oya_porter/bloc/scheduleBloc.dart';
import 'package:oya_porter/bloc/pickupBloc.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/emptyBox.dart';
import 'package:oya_porter/components/phoneNumberText.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/navigation.dart';
import 'package:oya_porter/config/offlineData.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/models/ScheduleModel.dart';
import 'package:oya_porter/models/myRouteModel.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/styles.dart';
import 'package:oya_porter/models/ticketModel.dart' as ticket;
import 'package:http/http.dart' as http;

enum PickUp { Yes, No }
PickUp _pickUp = PickUp.No;

class AddTicket extends StatefulWidget {
  @override
  _AddTicketState createState() => _AddTicketState();
}

class _AddTicketState extends State<AddTicket> {
  final _routeController = TextEditingController();
  final _busController = TextEditingController();
  final _pickupController = TextEditingController();

  TextEditingController paymentModeController = TextEditingController();
  TextEditingController paymentTypeController = TextEditingController();

  TextEditingController reciepeintNameController = TextEditingController();
  TextEditingController reciepeintPhoneController = TextEditingController();
  TextEditingController minorController = TextEditingController();
  String network, payType;
  bool showMomo = true;
  String schedleId, routeID, pickupId;
  bool isLoading = false, selectPickup = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    minorController.text = "0";
    super.initState();
    // loadMyRouteOffline();
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
                child: Form(
                  key: _formKey,
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
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Select Mid Route Pickup",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600))
                        ],
                      ),
                      Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Radio(
                                  activeColor: PRIMARYCOLOR,
                                  value: PickUp.No,
                                  groupValue: _pickUp,
                                  onChanged: (PickUp value) {
                                    setState(() {
                                      _pickUp = value;
                                      selectPickup = false;
                                    });
                                  },
                                ),
                                Text("No"),
                              ],
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Row(
                              children: [
                                Radio(
                                  activeColor: PRIMARYCOLOR,
                                  value: PickUp.Yes,
                                  groupValue: _pickUp,
                                  onChanged: (PickUp value) {
                                    setState(() {
                                      _pickUp = value;
                                      selectPickup = true;
                                    });
                                  },
                                ),
                                Text("Yes"),
                              ],
                            ),
                          ]),
                      Visibility(
                        visible: selectPickup,
                        child: GestureDetector(
                          onTap: () => androidSelectPickups(
                            context: context,
                            title: "Mid Route Pickup",
                          ),
                          child: textFormField(
                            hintText: "Mid Route Pickup",
                            controller: _pickupController,
                            focusNode: null,
                            icon: Icons.directions_bus,
                            validate: true,
                            validateMsg: "Select pickup route",
                            enable: false,
                          ),
                        ),
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
                        textLength: 1,
                        focusNode: null,
                        // initialValue: "0",
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
                      newCountrySelect(
                          controller: reciepeintPhoneController,
                          hintText: "Enter momo number"),
                      // textFormField(
                      //   hintText: "Enter momo number",
                      //   controller: reciepeintPhoneController,
                      //   inputType: TextInputType.phone,
                      //   focusNode: null,
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
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
              onPressed: isLoading
                  ? null
                  : () {
                      if (_formKey.currentState.validate()) {
                        _onSave(
                          busID: schedleId,
                          pickupId: pickupId,
                          phone: userphone,
                          momoPhone:
                              "+${(countryCode + reciepeintPhoneController.text)}",
                          momoName: reciepeintNameController.text,
                          minor: minorController.text,
                          mapymentMode: network,
                        );
                      }
                    }),
        ),
      ),
    );
  }

  _onSave(
      {String busID,
      String pickupId,
      String phone,
      String minor,
      String momoName,
      String mapymentMode,
      String momoPhone}) async {
    print(phone);
    setState(() {
      isLoading = true;
    });
    try {
      // Map<String, dynamic> body = {
      //   'bus_schedule_id': busID,
      //   'phone': phone,
      //   'pickup_id': pickupId,
      //   'minor_count': minor,
      //   'payment_type': payType,
      //   'payment_mode': mapymentMode,
      //   'momo_phone': momoPhone,
      //   'momo_name': '$momoName',
      // };
      Map<String, dynamic> body2 = {
        "type": "DEBIT",
        "method": "$payType ",
        "account_number": momoPhone,
        "network": "$mapymentMode",
        "description": "Payment for tickets",
        "services": [
          {"service_id": busID, "service_code": "TICKET"}
        ]
      };
      print(busID);
      final url = Uri.parse("$BASE_URL/v2/payments");
      // final url = Uri.parse("$BASE_URL/stations/$stationId/tickets");

      final response = await http.post(
        url,
        body: json.encode(body2),
        headers: {
          "Authorization": "Bearer $accessToken",
          'Content-Type': 'application/json'
        },
      ).timeout(
        Duration(seconds: 50),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData);
        setState(() {
          isLoading = false;
        });
        if (responseData['status'] == 200) {
          paymentDialog(context, responseData["data"]);
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

  Future<void> paymentDialog(
      BuildContext context, Map<String, dynamic> data) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: SingleChildScrollView(
              child: Column(
            children: [
              Text(
                data['payment']['account_name'],
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              Text(
                data['payment']['account_number'],
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              Text(
                data['payment']['status']['name'],
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              Row(
                children: [
                  Text(
                    data['payment']['currency'],
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    data['payment']['amount'],
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    data['payment']['wallet_provider'],
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    data['payment']['reference'],
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    data['payment']['created_at'],
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          )),
          actions: <Widget>[
            FlatButton(
              child:
                  Text('Check Status', style: TextStyle(color: PRIMARYCOLOR)),
              onPressed: () => checkStatus(schedleId),
            ),
          ],
        );
      },
    );
  }

  Future<void> checkStatus(String busID) async {
    try {
      final url = Uri.parse("$BASE_URL/v2/payments/$busID");
      // final url = Uri.parse("$BASE_URL/stations/$stationId/tickets");

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $accessToken",
          'Content-Type': 'application/json'
        },
      ).timeout(
        Duration(seconds: 50),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['data']['status']['id'] != 1) {
          Navigator.pop(context);
        } else {
          toastContainer(text: responseData['message']);
        }
      }
    } catch (e) {}
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
                payType = "MOMO";
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
                network = "AIRTEL";
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
                network = "MTN";
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
                network = "VODAFONE";
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _mRoute(MyRouteModel model, BuildContext context) {
    print(model.data[0]);
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
    myRouteBloc.fetchAllStaffs(stationId, context);
    return StreamBuilder<Object>(
      stream: myRouteBloc.myroutes,
      // initialData: myRouteMapOffline == null
      //     ? null
      //     : MyRouteModel.fromJson(myRouteMapOffline),
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

  Widget allPickups() {
    // loadallSchedulePickupsOffline();
    pickupBloc.fetchAllBusSchedulePickups(schedleId);
    return StreamBuilder<Object>(
      stream: pickupBloc.pickups,
      // initialData: pickupsMapOffline == null
      //     ? null
      //     : ticket.PickupModel.fromJson(pickupsMapOffline),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return _mPickups(snapshot.data, context);
        } else if (snapshot.hasError) {
          return Text("Error");
        }
        return Center(child: CupertinoActivityIndicator(radius: 15));
      },
    );
  }

  Widget allScheduled() {
    // loadallSchedulesOffline();
    scheduleBloc.fetchAllStaffs(id: stationId, routeId: routeID);
    return StreamBuilder<Object>(
      stream: scheduleBloc.allRating,
      // initialData: schedulesMapOffline == null
      //     ? null
      //     : ScheduleModel.fromJson(schedulesMapOffline),
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

  Future<void> androidSelectPickups(
      {String title, BuildContext context}) async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text("$title"),
            children: [allPickups()],
          );
        })) {
    }
  }

  Widget _mPickups(ticket.PickupModel model, BuildContext context) {
    if (model.data != null)
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var data in model.data) ...[
            Platform.isIOS
                ? CupertinoActionSheetAction(
                    child: Text(
                      '${data.name}',
                      style: TextStyle(color: BLACK),
                    ),
                    onPressed: () {
                      setState(() {
                        pickupId = data.id.toString();

                        _pickupController.text = "${data.name}";
                      });

                      Navigator.pop(context);
                    },
                  )
                : SimpleDialogOption(
                    onPressed: () {
                      pickupId = data.id.toString();
                      _pickupController.text = "${data.name}";
                      Navigator.pop(context);
                    },
                    child: Text(
                      "${data.name} ",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
            Divider(),
          ]
        ],
      );
    else
      return Container(
          height: 50,
          child: Center(
            child: Text("No Midroute",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red)),
          ));
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
