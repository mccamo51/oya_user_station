import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/Users/model/ticketFromModel.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/sharePreference.dart';

class TicketFromProvider {
  Client client = Client();

  Future<TicketFromModel> fetchTicketFrom(BuildContext context) async {
    final url = Uri.parse("$TICKETFROM_URL");

    try {
      final response = await client.get(
        url,
        headers: {
          "Authorization": "Bearer $accessToken",
          'Content-Type': 'application/json'
        },
      );
      if (response.statusCode == 200) {
        saveStringShare(
            key: "ticketFrom", data: json.encode(json.decode(response.body)));
        return TicketFromModel.fromJson(json.decode(response.body));
      }else if (response.statusCode == 401) {
        sessionExpired(context);
      } else {
        toastContainer(text: "Error has occured");
      }
    } catch (e) {
      throw Exception('Failed to ticket from');
    }
  }
}
