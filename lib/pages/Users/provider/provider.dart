import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/pages/Users/config/functions.dart';
import 'package:oya_porter/pages/Users/config/routes.dart';
import 'package:oya_porter/pages/Users/model/parcelSentModel.dart';
import 'package:oya_porter/pages/Users/model/parcerRecievedModel.dart';
import 'package:oya_porter/pages/Users/model/passengerRangeModel.dart';
import 'package:oya_porter/pages/Users/model/purposeModel.dart';
import 'package:oya_porter/pages/Users/model/tripModel.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/sharePreference.dart';

class OyaProvider {
  Client client = Client();
  Future<TripsModel> getAllTrips(BuildContext context) async {
    final url = Uri.parse("$TRIPS_URL");

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
            key: "alltrips", data: json.encode(json.decode(response.body)));
        return TripsModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 401) {
        sessionExpired(context);
      } else {
        toastContainer(text: "Error has occured");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<ParcelSentUserModel> fetchParcelSentByPorter(
      BuildContext context) async {
    final url = Uri.parse("$BASE_URL/account/parcels_sent");

    try {
      final response = await client.get(
        url,
        headers: {
          "Authorization": "Bearer $accessToken",
          'Content-Type': 'application/json'
        },
      ).timeout(Duration(seconds: 50));
      if (response.statusCode == 200) {
        saveStringShare(
            key: "parcelByPorter",
            data: json.encode(json.decode(response.body)));
        return ParcelSentUserModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 401) {
        sessionExpired(context);
      } else {
        toastContainer(text: "Error has occured");
      }
    } on TimeoutException catch (_) {
      throw Exception("Timeout");
    } on SocketException catch (_) {
      throw Exception("No internet");
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<PurposeModel> fetchPurpose(BuildContext context) async {
    final url = Uri.parse("$BASE_URL/trip_purposes");

    try {
      final response = await client.get(
        url,
        headers: {
          "Authorization": "Bearer $accessToken",
          'Content-Type': 'application/json'
        },
      ).timeout(Duration(seconds: 50));
      if (response.statusCode == 200) {
        print(response.body);
        saveStringShare(
            key: "trip_purposes",
            data: json.encode(json.decode(response.body)));
        return PurposeModel.fromJson(json.decode(response.body));
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

  Future<ParcelRecievedModel> fetchParcelRecieved(BuildContext context) async {
    final url = Uri.parse("$BASE_URL/account/parcels_received");

    try {
      final response = await client.get(
        url,
        headers: {
          "Authorization": "Bearer $accessToken",
          'Content-Type': 'application/json'
        },
      ).timeout(Duration(seconds: 50));
      if (response.statusCode == 200) {
        print(response.body);
        saveStringShare(
            key: "parcelRecieved",
            data: json.encode(json.decode(response.body)));
        return ParcelRecievedModel.fromJson(json.decode(response.body));
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

  Future<PassengerRangeModel> fetchPassengerRange(BuildContext context) async {
    final url = Uri.parse("$BASE_URL/passenger_ranges");

    try {
      final response = await client.get(
        url,
        headers: {
          "Authorization": "Bearer $accessToken",
          'Content-Type': 'application/json'
        },
      ).timeout(Duration(seconds: 50));
      if (response.statusCode == 200) {
        print(response.body);
        saveStringShare(
            key: "passengerRange",
            data: json.encode(json.decode(response.body)));
        return PassengerRangeModel.fromJson(json.decode(response.body));
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
