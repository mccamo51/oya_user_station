import 'package:flutter/material.dart';
import 'package:oya_porter/config/repository.dart';
import 'package:oya_porter/models/driverModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class DriverBloc {
  Repository _repository = Repository();

  final _ratingFetcher = PublishSubject<DriversModel>();

  Stream<DriversModel> get drivers => _ratingFetcher.stream;

  fetchDrivers(String id,BuildContext context) async {
    DriversModel timeResponse = await _repository.fetchDrivers(id, context);
    _ratingFetcher.sink.add(timeResponse);
  }

  dispose() {
    _ratingFetcher.close();
  }
}

final driverBloc = DriverBloc();
