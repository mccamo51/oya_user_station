import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/auth/login/login.dart';

Future<Map<String, dynamic>> fetchBusSeats(
    String id, BuildContext context) async {
  Map<String, dynamic> data;
  final url = Uri.parse("$BUSSEATS_URL/$id/bus_seats");
  final response = await http.get(
    url,
    headers: {
      "Authorization": "Bearer $accessToken",
      'Content-Type': 'application/json'
    },
  );
  if (response.statusCode == 200) {
    var responseData = json.decode(response.body);

    if (responseData != null) {
      data = responseData;
    }
  } else if (response.statusCode == 401) {
    sessionExpired(context);
  } else {
    toastContainer(text: "Error has occured");
  }
  return data;
}
