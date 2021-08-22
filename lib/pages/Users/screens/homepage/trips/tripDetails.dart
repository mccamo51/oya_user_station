import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oya_porter/components/alerts.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/Users/screens/auth/register/secureAccount/secure.dart';
import 'package:oya_porter/spec/colors.dart';
import 'widgets/tripDetailsWidget.dart';

class TripDetails extends StatefulWidget {
  final String fromTo;
  final String to;
  final String from;
  final String id;
  final String transportCompany;
  final String numberOfPass;
  final String price;
  final String tripDate;
  final String tripTime;
  final String fromlongitde;
  final String tolongitde;
  final String fromlatitud;
  final String tolatitud;
  final String manifestCode;

  TripDetails({
    @required this.fromTo,
    @required this.to,
    @required this.from,
    @required this.numberOfPass,
    @required this.price,
    @required this.id,
    @required this.transportCompany,
    @required this.tripDate,
    @required this.tripTime,
    @required this.fromlongitde,
    @required this.fromlatitud,
    @required this.tolongitde,
    @required this.tolatitud,
    this.manifestCode,
  });

  @override
  _TripDetailsState createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  TextEditingController commentController = TextEditingController();
  FocusNode commentFocus;
  bool _isLoading = false;

  @override
  void initState() {
    commentFocus = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LIGHTASH,
      body: SafeArea(
        child: _isLoading
            ? Center(child: CupertinoActivityIndicator(radius: 15))
            : tripDetailsWidget(
                context: context,
                fromTo: '${widget.fromTo}',
                id: widget.id,
                noPassenger: '${widget.numberOfPass}',
                price: '${widget.price}',
                transportCompany: '${widget.transportCompany}',
                tripDate: '${widget.tripDate}',
                tripTime: '${widget.tripTime}',
                onTrip: null,
                onRating: (rating) {
                  Navigator.pop(context);
                  // print(rating);
                  _onRate(context, rating);
                },
                commentController: commentController,
                commentfocus: commentFocus,
                // map: widget.fromlatitud != "null" &&
                //         widget.fromlongitde != "null" &&
                //         widget.tolatitud != "null" &&
                //         widget.tolongitde != "null"
                //     ? Container(
                //         height: 300,
                //         width: MediaQuery.of(context).size.width,
                //         child: GoogleMapPage(
                //           fromlatitud: widget.fromlatitud,
                //           fromlongitde: widget.fromlongitde,
                //           tolatitud: widget.tolatitud,
                //           tolongitde: widget.tolongitde,
                //         ),
                //       )
                //     : Container(
                //         height: 0,
                //         width: 0,
                //       ),
                // onShare: () => _share(),
                from: widget.from,
                to: widget.to,
              ),
      ),
    );
  }

  // _share() async {
  //   Share.share(
  //       'https://www.google.com/maps/search/?api=1&query=${widget.tolatitud},${widget.tolongitde}');
  // }

  _onRate(BuildContext context, double rate) async {
    setState(() {
      _isLoading = true;
    });
    final url = Uri.parse("$RateTRIP_URL/${widget.id}/rate_trip");

    try {
      final response = await http.post(url,
          body: json.encode(
              {'feedback': '${commentController.text}', 'rating': '$rate'}),
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
          wrongPasswordToast(
              msg: "Rating trip successful",
              title: "Success",
              context: context);
          // navigation(context: context, pageName: "home");
        } else {
          wrongPasswordToast(
              msg: responseData['message'], title: "Failed", context: context);
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

  // _onTripProgres(BuildContext context) async {
  //   Location location = new Location();
  //   PermissionStatus _permissionGranted;
  //   bool _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return;
  //     }
  //   }

  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   } else {
  //     toastContainer(
  //       text: "Loading location...",
  //       backgroundColor: PRIMARYCOLOR,
  //     );
  //     Location location = new Location();
  //     await location.getLocation().then((LocationData loc) {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (BuildContext context) => TripProgress(
  //             fromlatitud: widget.fromlatitud,
  //             fromlongitde: widget.fromlongitde,
  //             tolatitud: widget.tolatitud,
  //             tolongitde: widget.tolongitde,
  //             destination: widget.to,
  //             currentLog: loc.longitude,
  //             currentLat: loc.latitude,
  //           ),
  //         ),
  //       );
  //     });
  //   }
  // }
}
