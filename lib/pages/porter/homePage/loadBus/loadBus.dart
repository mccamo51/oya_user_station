import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/components/buttons.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/components/toast.dart';
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
  int minor = 0;
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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearch
            ? textFormField2(
                hintText: "Search",
                controller: searchController,
                focusNode: searchFocus,
                inputType: TextInputType.phone,
              )
            : Text("Load Bus"),
        elevation: 0.3,
        centerTitle: true,
        actions: [
          IconButton(
              icon: isSearch ? Icon(Icons.close) : Icon(Icons.search),
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
                      Text(
                        "${widget.passengerCount} Passengers onboard",
                        style: h5ASH,
                      ),
                      Text(
                        "${widget.minorCount} Minors",
                        style: h5ASH,
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
                      textFormField(
                        hintText: "Enter Phone Number",
                        controller: phoneNumberController,
                        focusNode: phoneFocus,
                        inputType: TextInputType.phone,
                        labelText: "Phone Number",
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
                              textFormField(
                                hintText: "Enter ICE Phone number",
                                controller: primaryICEphoneController,
                                focusNode: icePhoneFocus,
                                labelText: "ICE Phone number",
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: _character == BusType.Genral ? true : false,
                        child: Column(
                          children: [
                            // textFormField(
                            //   hintText: "Enter Full Name",
                            //   controller: fullNameController,
                            //   focusNode: fullNameFocus,
                            //   labelText: "Full name",
                            // ),
                            // SizedBox(
                            //   height: 8,
                            // ),
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
                                textFormField(
                                  hintText:
                                      "Enter Primary Emergency phone (ICE)",
                                  controller: primaryICEphoneController,
                                  focusNode: icePhoneFocus,
                                  inputType: TextInputType.phone,
                                  labelText: "Primary Emergency phone (ICE)",
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: _characterT == TravelWithMinor.Yes
                                ? true
                                : false,
                            child: textFormField(
                              hintText: "Enter Minor",
                              controller: ticketController,
                              focusNode: ticktFocus,
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
                            onFunction: () => enrollBusDialog(context),
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
    );
  }

  Future<void> enrollBusDialog(BuildContext context) async {
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
                    title: "Enroll Passenger",
                    color: PRIMARYCOLOR,
                    onFunction: () {
                      _enroll(
                          scheduleId: widget.scheduleId,
                          icePhone: primaryICEphoneController.text,
                          iceAddress: primaryICEAddressController.text,
                          minor: minor.toString(),
                          phone: phoneNumberController.text,
                          name: fullNameController.text,
                          pin: pinController.text);
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        );
      },
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
                      _awayBus(
                          scheduleId: widget.scheduleId,
                          pin: pinController.text);
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
      final response = await http.post(
        "$BASE_URL/schedules/$scheduleId/start",
        body: {'pin': '$pin'},
        headers: {
          "Authorization": "Bearer $accessToken",
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
      }
    }
  }

  _enroll({
    @required String scheduleId,
    @required String icePhone,
    @required String iceAddress,
    @required String minor,
    @required String phone,
    @required String name,
    @required String pin,
  }) async {
    if (pinController.text.isEmpty) {
      toastContainer(text: "Pin field required!");
    } else {
      setState(() {
        isLoading = true;
      });
      Map general = {
        'pin': '$pin',
        'phone': '$phone',
        'minor_count': '$minor',
        'name': '$name',
        'type': 'a'
      };
      Map noPhone = {
        'pin': '$pin',
        'minor_count': '$minor',
        'ice1_phone': '$icePhone',
        'name': '$name',
        'type': 'b'
      };
      Map noPhoneNoICE = {
        'pin': '$pin',
        'minor_count': '$minor',
        'ice1_name': '$name',
        'ice1_address': '$iceAddress',
        'type': 'c'
      };
      print(_character);
      // print(noPhone);
      final response = await http.post(
        "$BASE_URL/schedules/$scheduleId/manifest",
        body: _character == BusType.Genral
            ? general
            : _character == BusType.NoPhone
                ? noPhone
                : noPhoneNoICE,
        headers: {
          "Authorization": "Bearer $accessToken",
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
          setState(() {
            widget.passengerCount =
                responseData['data']['passengers_count'].toString();
          });
          navigation(context: context, pageName: "home");
        } else if (responseData['status'] == 203) {
          toastContainer(text: 'Please Name and ICE phone is required');
          setState(() {
            showPhone = true;
          });
        } else {
          toastContainer(text: responseData['message']);
        }
      }
    }
  }

  onSearch({String phoneNo, scheduleId}) async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.post(
        "$BASE_URL/schedules/$scheduleId/search_manifest",
        body: {'needle': phoneNo},
        headers: {
          "Authorization": "Bearer $accessToken",
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
