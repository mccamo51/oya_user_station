import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/components/alerts.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/Users/screens/homepage/trips/trips.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'widgets/findTripWidget.dart';
import 'package:http/http.dart' as http;

class FindTrip extends StatefulWidget {
  final String busScheduleId;
  FindTrip({@required this.busScheduleId});
  @override
  _FindTripState createState() => _FindTripState();
}

class _FindTripState extends State<FindTrip> {
  bool _isLoading = false;
  final tripController = TextEditingController();

  final minorController = TextEditingController();
  FocusNode tripFocus, minorFocus;

  @override
  void initState() {
    minorFocus = FocusNode();
    tripFocus = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? Center(child: CupertinoActivityIndicator(radius: 15))
            : findTripWidgt(
                context: context,
                onFindTrip: () {
                  _onAddToTrip(
                    busId: widget.busScheduleId,
                    minor: minorController.text,
                    tripCode: tripController.text,
                    context: context,
                  );
                },
                minorController: minorController,
                tripCodeController: tripController,
                minorFocus: minorFocus,
                tripFocus: tripFocus,
              ));
  }

  _onAddToTrip(
      {String tripCode,
      String minor,
      String busId,
      BuildContext context}) async {
    setState(() {
      _isLoading = true;
    });
    final url = Uri.parse("$ENROLL_SELF_URL");

    try {
      final response = await http.post(url,
          headers: {
            "Authorization": "Bearer $accessToken",
            'Content-Type': 'application/json'
          },
          body: json.encode({
            'bus_schedule_id': '$busId',
            'ticket_no': '$tripCode',
            'minors': '$minor'
          }));
      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
        final responseData = json.decode(response.body);
        if (responseData['status'] == 200) {
          print(responseData);
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => Trips()));
        } else {
          wrongPasswordToast(
              msg: responseData['message'], title: "Error", context: context);
          print(responseData);
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
