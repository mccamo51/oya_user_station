import 'package:flutter/material.dart';
import 'package:oya_porter/models/PorterModel.dart';
import 'package:oya_porter/models/ScheduleModel.dart';
import 'package:oya_porter/models/ticketModel.dart' as ticket;
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
import 'package:oya_porter/models/scheduledBusesModel.dart';
import 'package:oya_porter/models/stationsModel.dart';
import 'package:oya_porter/models/stuffModel.dart';
import 'package:oya_porter/models/ticketModel.dart';
import 'package:oya_porter/models/townModle.dart';
import 'package:oya_porter/models/townRegionModel.dart';
import 'package:oya_porter/provider/provider.dart';

class Repository {
  OyaProvider _myProvider = OyaProvider();

  Future<BussModel> fetchBusses(String busId, BuildContext context) =>
      _myProvider.fetchBusses(busId, context);

  Future<StaffModel> fetchAllStaff(String staffId, BuildContext context) =>
      _myProvider.fetchAllStaffs(staffId, context);

  Future<RatingModel> fetchAllRating(String staffId, BuildContext context) =>
      _myProvider.fetchRating(staffId, context);

  Future<ScheduleModel> fetchSchedule(
          {String staffId, String routId, BuildContext context}) =>
      _myProvider.fetchSchedule(id: staffId, routeID: routId, context: context);

  Future<TicketsModel> fetchTicket(String staffId, BuildContext context) =>
      _myProvider.fetchTicket(staffId, context);

  Future<MyRouteModel> fetchMyRoute(String staffId, BuildContext context) =>
      _myProvider.fetchMyRoute(staffId, context);

  Future<DriversModel> fetchDrivers(String staffId, BuildContext context) =>
      _myProvider.fetchDrivers(staffId, context);

  Future<BusTypeModel> fetchBusType(BuildContext context) =>
      _myProvider.fetchBusType(context);

  Future<RegionModel> fetchRegion(BuildContext context) =>
      _myProvider.fetchRegion(context);

  Future<TownModel> fetchTown(BuildContext context) =>
      _myProvider.fetchTown(context);

  Future<ReportModel> fetchReport(String staffId, BuildContext context) =>
      _myProvider.fetchReports(staffId, context);

  Future<ConductorModel> fetchConductor(String staffId, BuildContext context) =>
      _myProvider.fetchConductors(staffId, context);

  Future<PortersModel> fetchPorter(String staffId, BuildContext context) =>
      _myProvider.fetchPorters(staffId, context);

  Future<LoadedBusModel> fetchLoadedBus(String staffId, BuildContext context) =>
      _myProvider.fetchLoadedBuses(staffId, context);

  Future<ScaledBusModel> fetchScaledBus(String staffId, BuildContext context) =>
      _myProvider.fetchScaledBuses(staffId, context);

  Future<PriorityBusModel> fetchPriorityBus(
          String staffId, BuildContext context) =>
      _myProvider.fetchPriorityBus(staffId, context);

  Future<StationsModel> fetchStations(BuildContext context) =>
      _myProvider.fetchStations(context);

  Future<ParcelSentUserModel> fetchParcelsSent(
          String staffId, BuildContext context) =>
      _myProvider.fetchParcelSentByPorter(id: staffId, context: context);

  Future<ParcelRecievedModel> fetchParcelsRecieved(
          String staffId, BuildContext context) =>
      _myProvider.fetchParcelRecieved(id: staffId, context: context);

  Future<TonwFromRegionModel> frechTownByRegion(
          String id, BuildContext context) =>
      _myProvider.fetchTownByRegion(id: id, context: context);

  Future<ScheduledBusesModel> fetchAllScheduledBus(
          String stationId, String routeId, BuildContext context) =>
      _myProvider.fetchScheduledBuses(
          routeID: routeId, stationId: stationId, context: context);

  Future<ticket.PickupModel> fetchBusSchedulePickups(
          {String scheduleId, BuildContext context}) =>
      _myProvider.fetchBusSchedulePickups(
          scheduleId: scheduleId, context: context);
}
