import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/Users/model/pickupPointModel.dart';
import 'package:oya_porter/pages/Users/screens/homepage/ticket/trip.dart';
import 'package:oya_porter/pages/auth/login/login.dart';

class PickupPointProvider {
  Client client = Client();

  Future<PickupPointModel> fetchPickupPoint(String busId, BuildContext context) async {
    final url = Uri.parse("$PICKUPPOINT_URL/$busId/pickups");

    try {
      final response = await client.get(
        url,
        headers: {
          "Authorization": "Bearer $accessToken",
           'Content-Type': 'application/json'
        },
      );
      if (response.statusCode == 200) {
        pickupMapOffline = json.decode(response.body);
        return PickupPointModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 401) {
        sessionExpired(context);
      } else {
        toastContainer(text: "Error has occured");
      }
    } catch (e) {
      throw Exception('Failed to pickup point');
    }
  }
}
