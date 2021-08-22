import 'package:flutter/material.dart';
import 'package:oya_porter/pages/Users/config/repository.dart';
import 'package:oya_porter/pages/Users/model/congrgationModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class CongregationBloc {
  Repository _repository = Repository();

  final _ticketFromFetcher = PublishSubject<CongrgationModel>();

  Stream<CongrgationModel> get congregation => _ticketFromFetcher.stream;

  fetchCongregation(BuildContext context) async {
    CongrgationModel timeResponse = await _repository.fetchCongregations(context);
    _ticketFromFetcher.sink.add(timeResponse);
  }

  dispose() {
    _ticketFromFetcher.close();
  }
}

final congregationBloc = CongregationBloc();
