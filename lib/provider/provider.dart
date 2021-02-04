import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' show Client;
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/models/busModel.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/sharePreference.dart';

class OyaProvider {
  Client client = Client();

  // Future<BussModel> fetchBusses() async {
  //   try {
  //     final response =
  //         await client.post("$LOGIN_URL", body: {'get_categories': 'true'});
  //     if (response.statusCode == 200) {
  //       // saveStringShare(
  //       //     key: "allCategories",
  //       //     data: json.encode(json.decode(response.body)));
  //       return BussModel.fromJson(json.decode(response.body));
  //     } else {
  //       throw Exception('Failed to load categories');
  //     }
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  Future<BussModel> fetchBusses(String id) async {
    try {
      final response = await client.get(
        "$GETBUSURL",
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        // print(response.body);
        saveStringShare(
            key: "allBusses", data: json.encode(json.decode(response.body)));
        return BussModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load Busses');
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
