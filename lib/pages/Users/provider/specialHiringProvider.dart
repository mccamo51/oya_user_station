import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/Users/model/specialHiringModel.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/sharePreference.dart';

class SpecialHiringProvider {
  Client client = Client();

  Future<SpecialHiringModel> fetchFeature(BuildContext context) async {
    final url = Uri.parse("$BASE_URL/account/special_hirings");

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
            key: "special_hirings",
            data: json.encode(json.decode(response.body)));
        return SpecialHiringModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 401) {
        sessionExpired(context);
      } else {
        toastContainer(text: "Error has occured");
      }
    } catch (e) {
      throw Exception('Failed to special_hirings ');
    }
  }
}
