import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/Users/model/ticketToModel.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
Map<String, dynamic> ticketToMapOffline;

class TicketToProvider {
  Client client = Client();

  Future<TicketToModel> fetchTicketTo(int id, BuildContext context) async {
    final url = Uri.parse("$TICKETTO_URL/$id/to");

    try {
      final response = await client.get(
        url,
        headers: {
          "Authorization": "Bearer $accessToken",
          'Content-Type': 'application/json'
        },
      );
      if (response.statusCode == 200) {
        ticketToMapOffline = json.decode(response.body);
        return TicketToModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 401) {
        sessionExpired(context);
      } else {
        toastContainer(text: "Error has occured");
      }
    } catch (e) {
      throw Exception('Failed to ticket to');
    }
  }
}
