import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:oya_porter/components/alerts.dart';
import 'package:oya_porter/components/buttons.dart';
import 'package:oya_porter/components/phoneNumberText.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/navigation.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/pages/porter/homePage/loadBus/offloadBus.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/styles.dart';
import 'package:http/http.dart' as http;

enum BusType { Genral, NoPhone, WithPhone }
enum TravelWithMinor { Yes, No }

BusType _character = BusType.Genral;
TravelWithMinor _characterT = TravelWithMinor.No;

class LoadBuses extends StatefulWidget {
  final String scheduleId;
  String minorCount, passengerCount, from, to, carNo, company;
  LoadBuses(
      {@required this.scheduleId,
      this.passengerCount,
      this.minorCount,
      this.from,
      this.to,
      this.carNo,
      this.company});
  @override
  _LoadBusesState createState() => _LoadBusesState();
}

class _LoadBusesState extends State<LoadBuses> {
  TextEditingController ticketController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController primaryICEphoneController = TextEditingController();
  TextEditingController primaryICEAddressController = TextEditingController();
  TextEditingController primaryICENameController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController minorController = TextEditingController();
  int minor = 0;
  int passengerCount = 0;
  bool isSearch = false;
  bool isLoading = false;
  bool showPhone = false;
  FocusNode ticktFocus,
      fullNameFocus,
      phoneFocus,
      iceNameFocus,
      icePhoneFocus,
      iceAddressFocus,
      searchFocus,
      minorFocus,
      pinFocus;
  @override
  void initState() {
    ticktFocus = FocusNode();
    fullNameFocus = FocusNode();
    phoneFocus = FocusNode();
    iceNameFocus = FocusNode();
    icePhoneFocus = FocusNode();
    iceAddressFocus = FocusNode();
    searchFocus = FocusNode();
    pinFocus = FocusNode();
    minorFocus = FocusNode();
    minorController.text = "0";
    passengerCount = int.parse(widget.passengerCount);

    // TODO: implement initState
    super.initState();
  }

  static const platform = const MethodChannel("samples.flutter.dev/print");

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(
              'Are you sure?',
            ),
            content: new Text(
              'This action will take you home.',
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(
                  'No',
                  style: TextStyle(color: PRIMARYCOLOR),
                ),
              ),
              TextButton(
                onPressed: () => navigation(context: context, pageName: "home"),
                child: new Text('Yes', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: isSearch
              ? textFormField2(
                  hintText: "Search",
                  controller: searchController,
                  focusNode: searchFocus,
                  inputType: TextInputType.phone,
                  onEditingComplete: () =>
                      onSearch(phoneNo: searchController.text),
                )
              : Text("Load Bus"),
          elevation: 0.3,
          centerTitle: true,
          actions: [
            IconButton(
                icon: isSearch
                    ? Icon(
                        Icons.search,
                        color: PRIMARYCOLOR,
                      )
                    : Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    isSearch = !isSearch;
                    !isSearch
                        ? onSearch(
                            phoneNo: searchController.text,
                            scheduleId: widget.scheduleId,
                          )
                        : null;
                  });
                })
          ],
        ),
        body: isLoading
            ? Center(
                child: CupertinoActivityIndicator(),
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Text(
                          "Bus Details",
                          style: h2Black,
                        ),
                        Text(
                          "${widget.company} (${widget.carNo})",
                          style: h3Black,
                        ),
                        Text(
                          "From: ${widget.from} - ${widget.to}",
                          style: h4Black,
                        ),
                        Text(
                          "${widget.company}",
                          style: h3Black,
                        ),
                        widget.passengerCount == null
                            ? Text(
                                "0 Passengers onboard",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: ASHDEEP,
                                ),
                              )
                            : Text(
                                "$passengerCount Passengers onboard",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: ASHDEEP,
                                ),
                              ),
                        Text(
                          "${widget.minorCount} Minors",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: ASHDEEP,
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    activeColor: Colors.blue,
                                    value: BusType.Genral,
                                    groupValue: _character,
                                    onChanged: (BusType value) {
                                      setState(() {
                                        _character = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    "General",
                                    style: TextStyle(color: BLACK),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    activeColor: Colors.blue,
                                    value: BusType.NoPhone,
                                    groupValue: _character,
                                    onChanged: (BusType value) {
                                      setState(() {
                                        _character = value;
                                        showPhone = false;
                                      });
                                    },
                                  ),
                                  Text(
                                    "No Phone",
                                    style: TextStyle(color: BLACK),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    activeColor: Colors.blue,
                                    value: BusType.WithPhone,
                                    groupValue: _character,
                                    onChanged: (BusType value) {
                                      setState(() {
                                        _character = value;
                                        showPhone = false;
                                      });
                                    },
                                  ),
                                  Text(
                                    "No Phone, No ICE Phone",
                                    style: TextStyle(color: BLACK),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Visibility(
                            visible: showPhone,
                            child: Column(
                              children: [
                                textFormField(
                                  hintText: "Enter Full Name",
                                  controller: fullNameController,
                                  focusNode: fullNameFocus,
                                  labelText: "Full name",
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                newCountrySelect(
                                  controller: primaryICEphoneController,
                                  hintText: "Enter ICE Phone number",
                                ),
                                // textFormField(
                                //   focusNode: icePhoneFocus,
                                //   inputType: TextInputType.phone,
                                //   textLength: 10,
                                //   labelText: "ICE Phone number",
                                // ),
                              ],
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: _character == BusType.Genral ? true : false,
                          child: Column(
                            children: [
                              newCountrySelect(
                                controller: phoneNumberController,
                                hintText: "Enter Phone Number",
                              ),
                              // textFormField(
                              //     hintText: "Enter ICE Phone number",
                              //   labelText: "Phone Number",
                              //   controller: phoneNumberController,
                              //   focusNode: phoneFocus,
                              //   inputType: TextInputType.phone,
                              //   textLength: 10,
                              // ),
                              SizedBox(
                                height: 8,
                              ),
                              textFormField(
                                hintText: "Enter Ticket Number",
                                controller: ticketController,
                                focusNode: ticktFocus,
                                labelText: "Ticket Number",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Are you travelling with minor?"),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                      activeColor: Colors.blue,
                                      value: TravelWithMinor.Yes,
                                      groupValue: _characterT,
                                      onChanged: (TravelWithMinor value) {
                                        setState(() {
                                          _characterT = value;
                                          // show = true;

                                          minor = 1;
                                        });
                                      },
                                    ),
                                    Text(
                                      "Yes",
                                      style: TextStyle(color: BLACK),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      activeColor: Colors.blue,
                                      value: TravelWithMinor.No,
                                      groupValue: _characterT,
                                      onChanged: (TravelWithMinor value) {
                                        setState(() {
                                          _characterT = value;
                                          // show = true;

                                          minor = 0;
                                        });
                                      },
                                    ),
                                    Text("No")
                                  ],
                                )
                              ],
                            ),
                            Visibility(
                              visible: _character == BusType.Genral
                                  ? false
                                  : _character == BusType.NoPhone
                                      ? false
                                      : true,
                              child: Column(
                                children: [
                                  textFormField(
                                    hintText: "Enter Full Name",
                                    controller: fullNameController,
                                    focusNode: fullNameFocus,
                                    labelText: "Full name",
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  textFormField(
                                    hintText: "Enter ICE name",
                                    controller: primaryICENameController,
                                    focusNode: iceNameFocus,
                                    labelText: "ICE name",
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  textFormField(
                                    hintText: "Enter ICE address",
                                    controller: primaryICEAddressController,
                                    focusNode: iceAddressFocus,
                                    labelText: "ICE address",
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: _character == BusType.Genral
                                  ? false
                                  : _character == BusType.NoPhone
                                      ? true
                                      : false,
                              child: Column(
                                children: [
                                  textFormField(
                                    hintText: "Enter Full Name",
                                    controller: fullNameController,
                                    focusNode: fullNameFocus,
                                    labelText: "Full name",
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  newCountrySelect(
                                    controller: primaryICEphoneController,
                                    hintText:
                                        "Enter Primary Emergency phone (ICE)",
                                  ),
                                  // textFormField(
                                  //   hintText:
                                  //       "Enter Primary Emergency phone (ICE)",
                                  //   controller: primaryICEphoneController,
                                  //   focusNode: icePhoneFocus,
                                  //   inputType: TextInputType.phone,
                                  //   textLength: 10,
                                  //   labelText: "Primary Emergency phone (ICE)",
                                  // ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Visibility(
                              visible: _characterT == TravelWithMinor.Yes
                                  ? true
                                  : false,
                              child: textFormField(
                                hintText: "Enter Minor",
                                controller: minorController,
                                focusNode: minorFocus,
                                textLength: 3,
                                inputType: TextInputType.number,
                                labelText: "Minor",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: primaryButton(
                              onFunction: () => _enroll(
                                  iceName: primaryICENameController.text,
                                  scheduleId: widget.scheduleId,
                                  icePhone: primaryICEphoneController.text,
                                  iceAddress: primaryICEAddressController.text,
                                  minor: minor == 1
                                      ? minorController.text
                                      : minor.toString(),
                                  phone: phoneNumberController.text,
                                  name: fullNameController.text,
                                  pin: pinController.text),
                              title: "Enroll Passenger"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: primaryButton(
                              onFunction: () => awayBusDialog(context),
                              title: "Away Bus (Done Loading)",
                              color: Colors.red),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> awayBusDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text('Sign Out Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                textFormField(
                  hintText: '*PIN',
                  controller: pinController,
                  inputType: TextInputType.number,
                  focusNode: pinFocus,
                ),
                SizedBox(
                  height: 20,
                ),
                primaryButton(
                    title: "Away Bus (Start Trip)",
                    color: PRIMARYCOLOR,
                    onFunction: () {
                      if (pinController.text.isEmpty) {
                        wrongPasswordToast(
                            msg: "Please enter pin to continue ",
                            title: "Required");
                      } else {
                        _awayBus(
                            scheduleId: widget.scheduleId,
                            pin: pinController.text);
                      }

                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        );
      },
    );
  }

  _awayBus({String scheduleId, String pin}) async {
    if (pinController.text.isEmpty) {
      toastContainer(text: "Pin field required");
    } else {
      setState(() {
        isLoading = true;
      });
      final url = Uri.parse("$BASE_URL/schedules/$scheduleId/start");

      final response = await http.post(
        url,
        body: json.encode({'pin': '$pin'}),
        headers: {
          "Authorization": "Bearer $accessToken",
          'Content-Type': 'application/json'
        },
      ).timeout(
        Duration(seconds: 50),
      );
      print(response.body);

      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        final responseData = json.decode(response.body);
        print(responseData);
        if (responseData['status'] == 200) {
          toastContainer(text: responseData['message']);
          navigation(context: context, pageName: "home");
        } else {
          toastContainer(text: responseData['message']);
        }
      } else if (response.statusCode == 401) {
        sessionExpired(context);
      } else {
        toastContainer(text: "Error has occured");
      }
    }
  }

  clearTextField() {
    fullNameController.clear();
    pinController.clear();
    primaryICEAddressController.clear();
    primaryICENameController.clear();
    primaryICEphoneController.clear();
    minorController.clear();
    phoneNumberController.clear();
  }

  _enroll({
    @required String scheduleId,
    @required String icePhone,
    @required String iceAddress,
    @required String minor,
    @required String phone,
    @required String name,
    @required String iceName,
    @required String pin,
  }) async {
    setState(() {
      isLoading = true;
    });
    Map general = {
      'pin': '$pin',
      'phone': '+${countryCode + phone}',
      'minor_count': '$minor',
      'type': 'a'
    };
    Map general2 = {
      'pin': '$pin',
      'phone': '+${countryCode + phone}',
      'minor_count': '$minor',
      'name': '$name',
      'ice1_phone': '+${countryCode + icePhone}',
      'type': 'a'
    };
    Map noPhone = {
      'pin': '$pin',
      'minor_count': '$minor',
      'ice1_phone': '+${countryCode + icePhone}',
      'name': '$name',
      'type': 'b'
    };
    Map noPhoneNoICE = {
      'pin': '$pin',
      'minor_count': '$minor',
      'ice1_name': '$iceName',
      'name': '$name',
      'ice1_address': '$iceAddress',
      'type': 'c'
    };

    final url = Uri.parse("$BASE_URL/schedules/$scheduleId/manifest");

    final response = await http.post(
      url,
      body: showPhone && _character == BusType.Genral
          ? json.encode(general2)
          : _character == BusType.Genral
              ? json.encode(general)
              : _character == BusType.NoPhone
                  ? json.encode(noPhone)
                  : json.encode(noPhoneNoICE),
      headers: {
        "Authorization": "Bearer $accessToken",
        'Content-Type': 'application/json'
      },
    ).timeout(
      Duration(seconds: 50),
    );
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      final responseData = json.decode(response.body);

      if (responseData['status'] == 200) {
        if (responseData['data']['passengers_count'] == null) {
          setState(() {
            passengerCount++;
          });
        } else {
          setState(() {
            passengerCount = responseData['data']['passengers_count'];
          });
        }

        clearTextField();
        toastContainer(text: 'Passenger has been enrolled successfully');
        printWork(responseData);
      } else if (responseData['status'] == 203) {
        toastContainer(text: 'Please Name and ICE phone is required');
        setState(() {
          showPhone = true;
        });
      } else {
        toastContainer(text: responseData['message']);
      }
    } else if (response.statusCode == 401) {
      sessionExpired(context);
    } else {
      toastContainer(text: "Error has occured");
    }
  }

  void printWork(Map data) async {
    // print(data['data']['conductor']);
    // var formatter = new DateFormat('dd-MM-yyyy');
    //
    // DateTime dateTime = formatter.parse(data['data']['departure_date']);
    // var month = dateTime.month.toString().padLeft(2, '0');
    // var day = dateTime.day.toString().padLeft(2, '0');
    var depDate = data['data'][
        'departure_date']; //'${dateTime.year}-$month-$day ${dateTime.hour}:${dateTime.minute}';

    String phoneNumber = (data['data']['user']['phone']);
    String iceNo = ("${data['data']['user']['ice1_phone']}");

    DateTime _date = DateTime.tryParse(depDate);
    var newD = DateFormat.yMMMMEEEEd().format(_date);
   

    try {
      await platform.invokeMethod("printTest", {
        "ticketNo": "${data['data']['manifest']['ticket_no']}",
        "from": "${data['data']['route']['from']['name']}",
        "to": "${data['data']['route']['to']['name']}",
        "vehicleNo": "${data['data']['bus']['reg_number']}",
        "user": "${data['data']['user']['name']}",
        "iceNo": getPayCardStr(iceNo),
        "phoneNumber": getPayCardStr(phoneNumber),
        "depDate": newD,
        "stationCode": "${data['data']['station']['code']}",
        "stationName": "${data['data']['station']['name']}",
        "phone": "${data['data']['station']['phone']}",
        "driver": "${data['data']['bus']['driver']['user']['name']}",
        "conductor": "${data['data']['bus']['conductor']['user']['name']}",
        "price": "${data['data']['price']}"
      });
    } catch (e) {
      print(e);
    }
  }

  onSearch({String phoneNo, scheduleId}) async {
    setState(() {
      isLoading = true;
    });
    try {
      final url = Uri.parse("$BASE_URL/schedules/$scheduleId/search_manifest");

      final response = await http.post(
        url,
        body: json.encode({'needle': phoneNo}),
        headers: {
          "Authorization": "Bearer $accessToken",
          'Content-Type': 'application/json'
        },
      ).timeout(
        Duration(seconds: 50),
      );
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        final responseData = json.decode(response.body);
        print(responseData);
        if (responseData['status'] == 200) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OffloadBus(
                        name: responseData['data']['user']['name'],
                        phone: responseData['data']['user']["phone"].toString(),
                        uid: responseData['data']['user']['id'].toString(),
                        iceNumber: responseData['data']['user']
                            ['ice_primary_phone'],
                        minor: responseData['data']['minor_count'].toString(),
                        dateLoaded: responseData['data']['created_at'],
                        manifestCode: responseData['data']['id'].toString(),
                        schedID: widget.scheduleId,
                      )));
        } else {
          toastContainer(text: responseData['message']);
        }
      } else if (response.statusCode == 401) {
        sessionExpired(context);
      } else {
        toastContainer(text: "Error has occured");
      }
    } on TimeoutException catch (e) {
      toastContainer(text: "Connetction timeout");
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      toastContainer(text: "$e");
      setState(() {
        isLoading = false;
      });
    }
  }
}
