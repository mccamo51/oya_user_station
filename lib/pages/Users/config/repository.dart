import 'package:flutter/material.dart';
import 'package:oya_porter/pages/Users/model/congrgationModel.dart';
import 'package:oya_porter/pages/Users/model/featuresModel.dart';
import 'package:oya_porter/pages/Users/model/parcelSentModel.dart';
import 'package:oya_porter/pages/Users/model/parcerRecievedModel.dart';
import 'package:oya_porter/pages/Users/model/passengerRangeModel.dart';
import 'package:oya_porter/pages/Users/model/pickupPointModel.dart';
import 'package:oya_porter/pages/Users/model/purposeModel.dart';
import 'package:oya_porter/pages/Users/model/sepcialDestinantionModel.dart';
import 'package:oya_porter/pages/Users/model/specialHiringModel.dart';
import 'package:oya_porter/pages/Users/model/ticketFromModel.dart';
import 'package:oya_porter/pages/Users/model/ticketModel.dart';
import 'package:oya_porter/pages/Users/model/ticketToModel.dart';
import 'package:oya_porter/pages/Users/model/tripModel.dart';
import 'package:oya_porter/pages/Users/provider/congregationProvider.dart';
import 'package:oya_porter/pages/Users/provider/destinationProvider.dart';
import 'package:oya_porter/pages/Users/provider/featureProvider.dart';
import 'package:oya_porter/pages/Users/provider/pickupPointPovider.dart';
import 'package:oya_porter/pages/Users/provider/provider.dart';
import 'package:oya_porter/pages/Users/provider/specialHiringProvider.dart';
import 'package:oya_porter/pages/Users/provider/ticketFromProvider.dart';
import 'package:oya_porter/pages/Users/provider/ticketToProvider.dart';
import 'package:oya_porter/pages/Users/provider/ticketsProvider.dart';

class Repository {
  OyaProvider _myProvider = OyaProvider();
  Future<TripsModel> fetchAllTrips(BuildContext context) =>
      _myProvider.getAllTrips(context);

  TicketFromProvider _ticketFromProvider = TicketFromProvider();
  Future<TicketFromModel> fetchTicketFrom(BuildContext context) =>
      _ticketFromProvider.fetchTicketFrom(context);

  TicketToProvider _ticketToProvider = TicketToProvider();
  Future<TicketToModel> fetchTicketTo(int id, BuildContext context) =>
      _ticketToProvider.fetchTicketTo(id, context);

  PickupPointProvider _pickupPointProvider = PickupPointProvider();
  Future<PickupPointModel> fetchPickupPoint(
          String busId, BuildContext context) =>
      _pickupPointProvider.fetchPickupPoint(busId, context);

  TicketsProvider _ticketsProvider = TicketsProvider();
  Future<TicketsModel> fetchAllTickets(BuildContext context) =>
      _ticketsProvider.fetchAllTickets(context);

  CongregationProvider _congregationProvider = CongregationProvider();
  Future<CongrgationModel> fetchCongregations(BuildContext context) =>
      _congregationProvider.fetchCongretaion(context);

  DestinationProvider _destinationProvider = DestinationProvider();
  Future<SepcialDestinantionModel> fetchDestination(BuildContext context) =>
      _destinationProvider.fetchDestinantion(context);

  FeatureProvider _featureProvider = FeatureProvider();
  Future<FeaturesModel> fetchFeature(BuildContext context) =>
      _featureProvider.fetchFeature(context);

  SpecialHiringProvider _specialHiringProvider = SpecialHiringProvider();
  Future<SpecialHiringModel> fetchSpecialHiring(BuildContext context) =>
      _specialHiringProvider.fetchFeature(context);

  Future<ParcelSentUserModel> fetchParcelsSent(BuildContext context) =>
      _myProvider.fetchParcelSentByPorter(context);

  Future<ParcelRecievedModel> fetchParcelsRecieved(BuildContext context) =>
      _myProvider.fetchParcelRecieved(context);

  Future<PurposeModel> fetchPurpose(BuildContext context) =>
      _myProvider.fetchPurpose(context);
  Future<PassengerRangeModel> fetchPassenger(BuildContext context) =>
      _myProvider.fetchPassengerRange(context);
}
