import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oya_porter/components/customLoading.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/Users/screens/auth/register/secureAccount/secure.dart';
import 'package:oya_porter/pages/Users/screens/homepage/homeMap/newHome.dart';
import 'package:oya_porter/pages/Users/screens/homepage/ticket/busSelection.dart';
import 'package:oya_porter/pages/Users/screens/payment/paymentPage.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/strings.dart';

import 'widgets/summaryWidget.dart';

class Summary extends StatefulWidget {
  final String tripDate,
      tripTime,
      insurancePolicyId,
      selectedBusModel,
      selectedBusId,
      pickupPointName,
      pickupPointId,
      seatsSelected,
      price,
      route,
      minor;

  final List<int> seatId;
  final bool mySelf;
  final List<Map<String, dynamic>> otherPassanger;

  Summary({
    @required this.pickupPointId,
    @required this.pickupPointName,
    @required this.insurancePolicyId,
    @required this.price,
    @required this.seatsSelected,
    @required this.seatId,
    @required this.selectedBusId,
    @required this.selectedBusModel,
    @required this.tripDate,
    @required this.tripTime,
    @required this.route,
    @required this.minor,
    @required this.mySelf,
    @required this.otherPassanger,
  });

  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  bool _isLoading = false;
  List<Map<String, dynamic>> _seatsSelectedMap = [];
  List<int> _seatsSelected = [];

  void _checkSeatsSelected() {
    print(widget.otherPassanger);
    for (int x = 0; x < widget.seatId.length; ++x) {
      print(x);
      int number = widget.seatId[x];
      int main;
      for (var nx in widget.seatId) {
        if (number == nx) main = number;
      }
      _seatsSelected += [main];

      _seatsSelectedMap += [
        x == 0
            ? {
                "seat_id": main,
                "parent": 1,
              }
            : {
                "seat_id": main,
              }
      ];
      main = null;
    }
  }

  @override
  void initState() {
    super.initState();
    _checkSeatsSelected();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      appBar: AppBar(
        elevation: 0,
        title: Text("Ticket Summary"),
      ),
      body: Stack(
        children: [
          summaryWidget(
            dateTime: "${widget.tripDate}, ${widget.tripTime}",
            route: "${widget.route}",
            pickup: "${widget.pickupPointName}",
            price: "GHS ${double.parse(widget.price) * _seatsSelected.length}",
            seatsSelected: "$_seatsSelected",
            selectedBus: "${widget.selectedBusModel}",
            passengers: buyTicketForOthers
                ? widget.otherPassanger
                : [
                    {
                      "name": "$userName",
                      "phone": "$userPhone",
                      "seat_id": "$_seatsSelected",
                      "ice1_phone": "$icePrimaryPhone",
                    }
                  ],
          ),
          if (_isLoading) customLoadingPage()
        ],
      ),
      bottomNavigationBar: summaryButtonWidget(onPressed: () {
        print("${_seatsSelected[0]}");
        _onProceedToPay();
      }),
    );
  }

  Future<void> _onProceedToPay() async {
    print("pickup ${widget.pickupPointId}");
    setState(() => _isLoading = true);
    List<Map<String, dynamic>> m = [];
    for (int x = 1; x < _seatsSelectedMap.length; ++x) m += _seatsSelectedMap;
    print("======${widget.otherPassanger}========${_seatsSelected.length}");

    Map<String, dynamic> body = buyTicketForOthers
        ? {
            "extra_seats": 0,
            "minor_count": widget.minor,
            int.parse(widget.pickupPointId) == 0 ? "" : "pickup_id":
                int.parse(widget.pickupPointId),
            "bus_schedule_id": "${widget.selectedBusId}",
            // "insurance_policy_id": insurancePolicy,
            "seats": buyTicketForOthers ? (widget.otherPassanger) : (m),
          }
        : !buyTicketForOthers && _seatsSelected.length == 1
            ? {
                "extra_seats": 1,
                "minor_count": int.parse(widget.minor),
                "insurance_policy_id":
                    insurancePolicy == null ? "" : insurancePolicy,

                "seat_id": _seatsSelected[0],
                int.parse(widget.pickupPointId) == 0 ? "" : "pickup_id":
                    int.parse(widget.pickupPointId),

                // "pickup_id": "0",
                "bus_schedule_id": widget.selectedBusId,
              }
            : {
                "extra_seats": 1,
                "minor_count": int.parse(widget.minor),
                int.parse(widget.pickupPointId) == 0 ? "" : "pickup_id":
                    int.parse(widget.pickupPointId),

                // "pickup_id": "0",
                "bus_schedule_id": widget.selectedBusId,
                "seats": buyTicketForOthers ? (widget.otherPassanger) : (m),
              };
    print(body);
    final url = Uri.parse("$BOOKTICKET_URL");
    try {
      final response = await http
          .post(url,
              headers: {
                "Authorization": "Bearer $accessToken",
                "Content-Type": "application/json",
              },
              body: json.encode(body))
          .timeout(Duration(seconds: 50));
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> decodeBody = json.decode(response.body);
        setState(() => _isLoading = false);
        if (decodeBody['status'] == 200) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PaymentPage(
                amount: decodeBody["data"]["price"].toString(),
                slug: decodeBody["data"]["ticket_no"].toString(),
              ),
            ),
          );
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        toastContainer(text: "Buying ticket failed");
      }
    } on TimeoutException catch (_) {
      setState(() {
        _isLoading = false;
      });
      toastContainer(
        text: CONNECTIONTIMEOUT,
        backgroundColor: RED,
      );
    } on SocketException catch (s) {
      setState(() {
        _isLoading = false;
      });
      print(s);
      toastContainer(
        text: INTERNETCONNECTIONPROBLEM,
        backgroundColor: RED,
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
      toastContainer(
        text: "Error occured. Please try again...$e",
        backgroundColor: RED,
      );
    }
  }
}

//  : {
//                       "extra_seats": "1",
//                       // "pickup_id": "${widget.pickupPointId}",
//                       "seat_id": "${_seatsSelected[0]}",
//                       "bus_schedule_id": "${widget.selectedBusId}",
//                       "target_person": buyTicketForOthers ? "others" : "self",
//                       "seats": buyTicketForOthers
//                           ? json.encode(widget.otherPassanger)
//                           : json.encode(m),
//                     }
