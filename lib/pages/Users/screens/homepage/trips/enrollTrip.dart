import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:oya_porter/components/alerts.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/button.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/properties.dart';
import 'package:oya_porter/spec/styles.dart';
import 'findTrip.dart';

class EnrollTrip extends StatefulWidget {
  @override
  _EnrollTripState createState() => _EnrollTripState();
}

class _EnrollTripState extends State<EnrollTrip> {
  TextEditingController ticketController = TextEditingController();
  FocusNode tickeFocus;
  bool _isLoading = false;
  @override
  void initState() {
    tickeFocus = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CupertinoActivityIndicator(radius: 15))
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  customBack(context, "Enroll on Bus"),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "If you bought a ticket at the station you may enter the ticket code here to add to $TITLE!"),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: textFormField(
                      controller: ticketController,
                      focusNode: tickeFocus,
                      hintText: "Ticket Code",
                      inputType: TextInputType.number,
                      labelText: "Ticket Code",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ButtonTheme(
                          minWidth: 100,
                          height: 40,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: PRIMARYCOLOR),
                          ),
                          child: FlatButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("Cancel", style: h4Button),
                            textColor: PRIMARYCOLOR,
                          ),
                        ),
                        ButtonTheme(
                          minWidth: 100,
                          height: 40,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: PRIMARYCOLOR),
                          ),
                          child: FlatButton(
                            onPressed: () {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => FindTrip(
                              //       busScheduleId: "65",
                              //     ),
                              //   ),
                              // );
                              _findTrip(
                                code: ticketController.text,
                                context: context,
                              );
                            },
                            child: Text("Enrol", style: h4Button),
                            textColor: WHITE,
                            color: PRIMARYCOLOR,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  _findTrip({
    BuildContext context,
    String code,
  }) async {
    if (ticketController.text.isEmpty) {
      toastContainer(
        text: "Field is required",
      );
    } else {
      setState(() {
        _isLoading = true;
      });
      final url = Uri.parse("$FINDTRIP_URL");
      try {
        final response = await http.post(url,
            body: json.encode({'code': code}),
            headers: {
              "Authorization": "Bearer $accessToken",
              'Content-Type': 'application/json'
            }).timeout(Duration(seconds: 30));

        if (response.statusCode == 200) {
          setState(() {
            _isLoading = false;
          });
          final responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            print(responseData['data']);
            // Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FindTrip(
                  busScheduleId: responseData['data']['id'].toString(),
                ),
              ),
            );
          } else {
            // toastContainer(text: responseData['message']);
            wrongPasswordToast(
              msg: responseData['message'],
              title: "Error",
              context: context,
            );
          }
        } else if (response.statusCode == 401) {
          sessionExpired(context);
        } else {
          setState(() {
            _isLoading = false;
          });
          toastContainer(text: "Error has occured");
        }
      } on TimeoutException {
        setState(() {
          _isLoading = false;
        });
        Platform.isIOS
            ? iosexceptionAlert(
                context: context,
                title: "Connection TimeOut",
                message: "Please check your connection and try again")
            : exceptionAlert(
                context: context,
                title: "Connection TimeOut",
                message: "Please check your connection and try again");
      } on SocketException {
        setState(() {
          _isLoading = false;
        });
        Platform.isIOS
            ? iosexceptionAlert(
                context: context,
                title: "No Internet connection",
                message: "Please connection to internet and try again",
              )
            : exceptionAlert(
                context: context,
                title: "No Internet connection",
                message: "Please connection to internet and try again",
              );
      } catch (f) {}
    }
  }
}
