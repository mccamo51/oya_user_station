import 'package:oya_porter/models/BusByStationModel.dart';
import 'package:oya_porter/models/PorterModel.dart';
import 'package:oya_porter/models/ScheduleModel.dart';
import 'package:oya_porter/models/allRouteModel.dart';
import 'package:oya_porter/models/busModel.dart';
import 'package:oya_porter/models/busTypeModel.dart';
import 'package:oya_porter/models/conductorModel.dart';
import 'package:oya_porter/models/driverModel.dart';
import 'package:oya_porter/models/myRouteModel.dart';
import 'package:oya_porter/models/ratingModel.dart';
import 'package:oya_porter/models/regionModel.dart';
import 'package:oya_porter/models/reportModel.dart';
import 'package:oya_porter/models/stuffModel.dart';
import 'package:oya_porter/models/ticketModel.dart';
import 'package:oya_porter/models/townModle.dart';
import 'package:oya_porter/provider/provider.dart';

class Repository {
  OyaProvider _myProvider = OyaProvider();

  Future<BussModel> fetchBusses(String busId) => _myProvider.fetchBusses(busId);

  Future<StaffModel> fetchAllStaff(String staffId) =>
      _myProvider.fetchAllStaffs(staffId);

  Future<RatingModel> fetchAllRating(String staffId) =>
      _myProvider.fetchRating(staffId);

  Future<ScheduleModel> fetchSchedule(String staffId, String routId) =>
      _myProvider.fetchSchedule(staffId, routId);

  Future<TicketsModel> fetchTicket(String staffId) =>
      _myProvider.fetchTicket(staffId);

  Future<MyRouteModel> fetchMyRoute(String staffId) =>
      _myProvider.fetchMyRoute(staffId);

  Future<DriversModel> fetchDrivers(String staffId) =>
      _myProvider.fetchDrivers(staffId);

  Future<BusTypeModel> fetchBusType() => _myProvider.fetchBusType();

  Future<RegionModel> fetchRegion() => _myProvider.fetchRegion();

  Future<TownModel> fetchTown() => _myProvider.fetchTown();

  Future<ReportModel> fetchReport(String staffId) =>
      _myProvider.fetchReports(staffId);

  Future<ConductorModel> fetchConductor(String staffId) =>
      _myProvider.fetchConductors(staffId);

  Future<PortersModel> fetchPorter(String staffId) =>
      _myProvider.fetchPorters(staffId);
}
