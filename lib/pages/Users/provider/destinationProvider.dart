import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/Users/model/sepcialDestinantionModel.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/sharePreference.dart';

class DestinationProvider {
  Client client = Client();

  Future<SepcialDestinantionModel> fetchDestinantion(
      BuildContext context) async {
    final url = Uri.parse("$BASE_URL/special_destinations");

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
            key: "special_destinations",
            data: json.encode(json.decode(response.body)));
        return SepcialDestinantionModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 401) {
        sessionExpired(context);
      } else {
        toastContainer(text: "Error has occured");
      }
    } catch (e) {
      throw Exception('Failed to destination ');
    }
  }
}
