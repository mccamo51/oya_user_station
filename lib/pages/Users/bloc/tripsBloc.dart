
import 'package:flutter/material.dart';
import 'package:oya_porter/pages/Users/config/repository.dart';
import 'package:oya_porter/pages/Users/model/tripModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class TripsBloc {
  Repository _repository = Repository();

  final _myTripsFetcher = PublishSubject<TripsModel>();

  Stream<TripsModel> get alltrips => _myTripsFetcher.stream;

  fetchAllTrips(BuildContext context) async {
    TripsModel timeResponse = await _repository.fetchAllTrips(context);
    _myTripsFetcher.sink.add(timeResponse);
  }

  dispose() {
    _myTripsFetcher.close();
  }
}

final tripsBloc = TripsBloc();
