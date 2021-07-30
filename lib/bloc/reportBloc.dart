import 'package:flutter/material.dart';
import 'package:oya_porter/config/repository.dart';
import 'package:oya_porter/models/reportModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class ReportBloc {
  Repository _repository = Repository();

  final _ratingFetcher = PublishSubject<ReportModel>();

  Stream<ReportModel> get reports => _ratingFetcher.stream;

  fetchDrivers(String id, BuildContext context) async {
    ReportModel timeResponse = await _repository.fetchReport(id, context);
    _ratingFetcher.sink.add(timeResponse);
  }

  dispose() {
    _ratingFetcher.close();
  }
}

final reportBloc = ReportBloc();
