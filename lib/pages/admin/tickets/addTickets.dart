import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/bloc/myRouteBloc.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/offlineData.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/models/allRouteModel.dart';
import 'package:oya_porter/models/myRouteModel.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/styles.dart';
import 'package:http/http.dart'as http;

class AddTicket extends StatefulWidget {
  @override
  _AddTicketState createState() => _AddTicketState();
}

class _AddTicketState extends State<AddTicket> {
  final _routeController = TextEditingController();

  TextEditingController paymentModeController = TextEditingController();
  TextEditingController paymentTypeController = TextEditingController();

  TextEditingController priceController = TextEditingController();
  TextEditingController reciepeintNameController = TextEditingController();
  TextEditingController reciepeintPhoneController = TextEditingController();
  String network, payType;
  bool showMomo = true;
  String schedleId;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Sell Ticket"),
      body: Padding(
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
                onTap: () {},
                child: textFormField(
                    hintText: "Select Bus",
                    controller: null,
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
                hintText: "Enter Reciepient Phone",
                controller: null,
                inputType: TextInputType.phone,
                focusNode: null,
              ),
              SizedBox(
                height: 15,
              ),
              textFormField(
                hintText: "Minors",
                controller: null,
                inputType: TextInputType.number,
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
                hintText: "Recipient Name",
                controller: reciepeintNameController,
                focusNode: null,
                labelText: "Recipient Name",
              ),
              SizedBox(
                height: 10,
              ),
              textFormField(
                hintText: "Recipient Phone",
                controller: reciepeintPhoneController,
                focusNode: null,
                labelText: "Recipient Phone",
                inputType: TextInputType.number,
              ),
              SizedBox(
                height: 10,
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
            onPressed: () {},
          ),
        ),
      ),
    );
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
        final response = await http.post(
          "$BASE_URL/$stationId/tickets",
          body: {
            'bus_schedule_id': staId,
            'phone': busId,
            'minor': regNo,
            'payment_type': model,
            'momo_phone': driverId,
            'momo_name': '$road_exp_date',
            'price': '$ins_exp_date',
          },
          headers: {
            "Authorization": "Bearer $accessToken",
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

  _onPaymentType(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Select Payment Type'),
        children: [
          ListTile(
            title: Text('Cash', style: h3Black),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).pop();
              setState(() {
                paymentTypeController.text = 'Cash';
                payType = "cash";
                showMomo = false;
              });
            },
          ),
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
                      // schedleId = data.busSchedule.id.toString();
                      schedleId = data.id.toString();

                      _routeController.text =
                          "${data.from.name} - ${data.to.name}";
                    });

                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                )
              : SimpleDialogOption(
                  onPressed: () {
                    schedleId = data.id.toString();
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
            children: [allPorter()],
          );
        })) {
    }
  }

  Widget allPorter() {
    loadMyRouteOffline();
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
}
