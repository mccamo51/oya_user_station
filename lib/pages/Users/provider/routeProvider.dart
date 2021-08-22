import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/pages/Users/config/functions.dart';
import 'package:oya_porter/pages/Users/config/routes.dart';
import 'package:oya_porter/pages/Users/model/myRouteModel.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/sharePreference.dart';
class RouteProvider {
  Client client = Client();

  Future<MyRouteModel> fetchMyRoute(
    String id,
    BuildContext context
  ) async {
    final url = Uri.parse("$BASE_URL/stations/$id/routes");

    try {
      final response = await client.get(
        url,
        headers: {
          "Authorization": "Bearer $accessToken",
          'Content-Type': 'application/json'
        },
      ).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        saveStringShare(
            key: "myroute", data: json.encode(json.decode(response.body)));
        return MyRouteModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 401) {
        sessionExpired(context);
      } else {
        toastContainer(text: "Error has occured");
      }
    } on TimeoutException catch (_) {
      // print("Exception occured: $error stackTrace: $stackTrace");
      throw Exception("Timeout");
    } on SocketException catch (_) {
      throw Exception("No internet");
    } catch (e) {
      throw Exception(e);
    }
  }
}
