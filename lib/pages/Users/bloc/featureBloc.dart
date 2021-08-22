import 'package:flutter/material.dart';
import 'package:oya_porter/pages/Users/config/repository.dart';
import 'package:oya_porter/pages/Users/model/featuresModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class FeaturesBloc {
  Repository _repository = Repository();

  final _ticketFromFetcher = PublishSubject<FeaturesModel>();

  Stream<FeaturesModel> get features => _ticketFromFetcher.stream;

  fetchDestination(BuildContext context) async {
    FeaturesModel timeResponse = await _repository.fetchFeature(context);
    _ticketFromFetcher.sink.add(timeResponse);
  }

  dispose() {
    _ticketFromFetcher.close();
  }
}

final featuresBloc = FeaturesBloc();
