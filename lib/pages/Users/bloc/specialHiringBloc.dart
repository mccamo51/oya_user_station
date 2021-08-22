import 'package:flutter/material.dart';
import 'package:oya_porter/pages/Users/config/repository.dart';
import 'package:oya_porter/pages/Users/model/specialHiringModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class SpecialHiringBloc {
  Repository _repository = Repository();

  final _ticketFromFetcher = PublishSubject<SpecialHiringModel>();

  Stream<SpecialHiringModel> get specialHiring => _ticketFromFetcher.stream;

  fetchCongregation(BuildContext context) async {
    SpecialHiringModel timeResponse = await _repository.fetchSpecialHiring(context);
    _ticketFromFetcher.sink.add(timeResponse);
  }

  dispose() {
    _ticketFromFetcher.close();
  }
}

final specialHiringBloc = SpecialHiringBloc();
