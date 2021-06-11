import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' show Client;
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/models/BusByStationModel.dart';
import 'package:oya_porter/models/PorterModel.dart';
import 'package:oya_porter/models/ScheduleModel.dart';
import 'package:oya_porter/models/busModel.dart';
import 'package:oya_porter/models/busTypeModel.dart';
import 'package:oya_porter/models/conductorModel.dart';
import 'package:oya_porter/models/driverModel.dart';
import 'package:oya_porter/models/loadedBusModel.dart';
import 'package:oya_porter/models/myRouteModel.dart';
import 'package:oya_porter/models/parcelByPorter.dart';
import 'package:oya_porter/models/parcerRecievedModel.dart';
import 'package:oya_porter/models/priorityBusModel.dart';
import 'package:oya_porter/models/ratingModel.dart';
import 'package:oya_porter/models/regionModel.dart';
import 'package:oya_porter/models/reportModel.dart';
import 'package:oya_porter/models/scaledBusModel.dart';
import 'package:oya_porter/models/stationsModel.dart';
import 'package:oya_porter/models/stuffModel.dart';
import 'package:oya_porter/models/ticketModel.dart';
import 'package:oya_porter/models/townModle.dart';
import 'package:oya_porter/models/townRegionModel.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/sharePreference.dart';

class OyaProvider {
  Client client = Client();

  Future<StaffModel> fetchAllStaffs(String id) async {
    try {
      final response = await client.get(
        "$BASE_URL/staffs/$id",
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        print(response.body);
        saveStringShare(
            key: "allStaff", data: json.encode(json.decode(response.body)));
        return StaffModel.fromJson(json.decode(response.body));
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

  Future<BussModel> fetchBusses(String id) async {
    try {
      final response = await client.get(
        "$BASE_URL/stations/$id/buses",
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

  Future<RatingModel> fetchRating(String id) async {
    try {
      final response = await client.get(
        "$BASE_URL/stations/$id/ratings",
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        print(response.body);
        saveStringShare(
            key: "allrating", data: json.encode(json.decode(response.body)));
        return RatingModel.fromJson(json.decode(response.body));
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

  Future<ScheduleModel> fetchSchedule(String id, String routeID) async {
    try {
      final response = await client.get(
        "$BASE_URL/routes/$routeID/schedules/$id",
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        // print(response.body);
        saveStringShare(
            key: "allschedule", data: json.encode(json.decode(response.body)));
        return ScheduleModel.fromJson(json.decode(response.body));
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

  Future<TicketsModel> fetchTicket(
    String id,
  ) async {
    try {
      final response = await client.get(
        "$BASE_URL/stations/$id/tickets",
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        print(response.body);
        saveStringShare(
            key: "allticket", data: json.encode(json.decode(response.body)));
        return TicketsModel.fromJson(json.decode(response.body));
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

  Future<MyRouteModel> fetchMyRoute(
    String id,
  ) async {
    try {
      final response = await client.get(
        "$BASE_URL/stations/$id/routes",
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        print(response.body);
        saveStringShare(
            key: "myroute", data: json.encode(json.decode(response.body)));
        return MyRouteModel.fromJson(json.decode(response.body));
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

  Future<DriversModel> fetchDrivers(
    String id,
  ) async {
    try {
      final response = await client.get(
        "$BASE_URL/stations/$id/drivers",
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        print(response.body);
        saveStringShare(
            key: "drivers", data: json.encode(json.decode(response.body)));
        return DriversModel.fromJson(json.decode(response.body));
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

  Future<BusTypeModel> fetchBusType() async {
    try {
      final response = await client.get(
        "$BASE_URL/bus_types",
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        print(response.body);
        saveStringShare(
            key: "bustype", data: json.encode(json.decode(response.body)));
        return BusTypeModel.fromJson(json.decode(response.body));
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

  Future<RegionModel> fetchRegion() async {
    try {
      final response = await client.get(
        "$BASE_URL/regions",
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        print(response.body);
        saveStringShare(
            key: "regions", data: json.encode(json.decode(response.body)));
        return RegionModel.fromJson(json.decode(response.body));
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

  Future<TownModel> fetchTown() async {
    try {
      final response = await client.get(
        "$BASE_URL/towns",
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        print(response.body);
        saveStringShare(
            key: "towns", data: json.encode(json.decode(response.body)));
        return TownModel.fromJson(json.decode(response.body));
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

  Future<ReportModel> fetchReports(
    String id,
  ) async {
    try {
      final response = await client.get(
        "$BASE_URL/stations/$id/speed_reports",
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        print(response.body);
        saveStringShare(
            key: "speed_reports",
            data: json.encode(json.decode(response.body)));
        return ReportModel.fromJson(json.decode(response.body));
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

  Future<ConductorModel> fetchConductors(
    String id,
  ) async {
    try {
      final response = await client.get(
        "$BASE_URL/stations/$id/conductors",
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        print(response.body);
        saveStringShare(
            key: "conductors", data: json.encode(json.decode(response.body)));
        return ConductorModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load conductors');
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

  Future<PortersModel> fetchPorters(
    String id,
  ) async {
    try {
      final response = await client.get(
        "$BASE_URL/stations/$id/porters",
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        print(response.body);
        saveStringShare(
            key: "porters", data: json.encode(json.decode(response.body)));
        return PortersModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load porters');
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

  Future<LoadedBusModel> fetchLoadedBuses(
    String id,
  ) async {
    try {
      final response = await client.get(
        "$BASE_URL/stations/$id/loaded_buses",
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        print(response.body);
        saveStringShare(
            key: "loaded_buses", data: json.encode(json.decode(response.body)));
        return LoadedBusModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load porters');
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

  Future<ScaledBusModel> fetchScaledBuses(
    String id,
  ) async {
    try {
      final response = await client.get(
        "$BASE_URL/stations/$stationId/scaled_buses",
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        print(response.body);
        saveStringShare(
            key: "scaled_buses", data: json.encode(json.decode(response.body)));
        return ScaledBusModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load porters');
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

  Future<PriorityBusModel> fetchPriorityBus(
    String id,
  ) async {
    try {
      final response = await client.get(
        "$BASE_URL/stations/$id/priority_buses",
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        print(response.body);
        saveStringShare(
            key: "priority_buses",
            data: json.encode(json.decode(response.body)));
        return PriorityBusModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load porters');
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

  Future<StationsModel> fetchStations() async {
    try {
      final response = await client.get(
        "$BASE_URL/stations",
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ).timeout(Duration(seconds: 50));
      if (response.statusCode == 200) {
        print(response.body);
        saveStringShare(
            key: "stations", data: json.encode(json.decode(response.body)));
        return StationsModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load stations');
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

  Future<ParcelSentUserModel> fetchParcelSentByPorter({String id}) async {
    try {
      final response = await client.get(
        "$BASE_URL/stations/$id/parcels_sent_by_porter",
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ).timeout(Duration(seconds: 50));
      if (response.statusCode == 200) {
        print(response.body);
        saveStringShare(
            key: "parcelByPorter",
            data: json.encode(json.decode(response.body)));
        return ParcelSentUserModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load stations');
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

  Future<ParcelRecievedModel> fetchParcelRecieved({String id}) async {
    try {
      final response = await client.get(
        "$BASE_URL/stations/$id/parcels_received",
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ).timeout(Duration(seconds: 50));
      if (response.statusCode == 200) {
        print(response.body);
        saveStringShare(
            key: "parcelRecieved",
            data: json.encode(json.decode(response.body)));
        return ParcelRecievedModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load stations');
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

  Future<TonwFromRegionModel> fetchTownByRegion({String id}) async {
    try {
      final response = await client.get(
        "$BASE_URL/regions/$id/towns",
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ).timeout(Duration(seconds: 50));
      if (response.statusCode == 200) {
        print(response.body);
        saveStringShare(
            key: "townByRegion", data: json.encode(json.decode(response.body)));
        return TonwFromRegionModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load stations');
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
