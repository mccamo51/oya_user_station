import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/Users/model/ticketModel.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/sharePreference.dart';

class TicketsProvider {
  Client client = Client();

  Future<TicketsModel> fetchAllTickets(BuildContext context) async {
    final url = Uri.parse("$GETTICKETS");

    // try {
    final response = await client.get(
      url,
      headers: {
        "Authorization": "Bearer $accessToken",
        'Content-Type': 'application/json'
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      saveStringShare(
        key: "alltickets",
        data: json.encode(
          json.decode(response.body),
        ),
      );
      return TicketsModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      sessionExpired(context);
    } else {
      toastContainer(text: "Error has occured");
    }
    // } catch (e) {
    //   print(e);
    //   throw Exception('Failed to load tickets');
    // }
  }
}
