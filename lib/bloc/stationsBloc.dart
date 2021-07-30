import 'package:flutter/material.dart';
import 'package:oya_porter/config/repository.dart';
import 'package:oya_porter/models/busModel.dart';
import 'package:oya_porter/models/stationsModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class StationsBloc {
  Repository _repository = Repository();

  final _busesFetcher = PublishSubject<StationsModel>();

  Stream<StationsModel> get stations => _busesFetcher.stream;

  fetchAllStations(BuildContext context) async {
    StationsModel timeResponse = await _repository.fetchStations(context);
    _busesFetcher.sink.add(timeResponse);
  }

  dispose() {
    _busesFetcher.close();
  }
}

final stationsBloc = StationsBloc();
