import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/buttons.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/styles.dart';
import 'package:http/http.dart' as http;

class OffloadBus extends StatefulWidget {
  final String name,
      phone,
      uid,
      iceNumber,
      dateLoaded,
      minor,
      manifestCode,
      schedID;
  OffloadBus(
      {this.dateLoaded,
      this.iceNumber,
      this.minor,
      this.name,
      this.phone,
      this.schedID,
      this.manifestCode,
      this.uid});

  @override
  _OffloadBusState createState() => _OffloadBusState();
}

class _OffloadBusState extends State<OffloadBus> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Ofload Bus"),
      body: isLoading
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : Card(
              child: Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name: ${widget.name}",
                    style: h3Black,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Phone: ${widget.phone}",
                    style: h3Black,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "ICE Primary: ${widget.iceNumber}",
                    style: h3Black,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Loaded on: ${widget.dateLoaded}",
                    style: h3Black,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Minor: ${widget.minor}",
                    style: h3Black,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: primaryButton(
                      onFunction: () => _offloadBus(),
                      title: "Offload Passenger",
                    ),
                  )
                ],
              ),
            )),
    );
  }

  _offloadBus() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.delete(
      "$BASE_URL/schedules/${widget.schedID}/manifest/${widget.manifestCode}",
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
        toastContainer(text: responseData['message']);
        Navigator.pop(context);
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
