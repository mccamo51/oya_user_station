
import 'package:flutter/material.dart';
import 'package:oya_porter/pages/Users/config/repository.dart';
import 'package:oya_porter/pages/Users/model/passengerRangeModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class PassengerRangeBloc {
  Repository _repository = Repository();

  final _ratingFetcher = PublishSubject<PassengerRangeModel>();

  Stream<PassengerRangeModel> get passenger => _ratingFetcher.stream;

  fetchPurposes(BuildContext context) async {
    PassengerRangeModel timeResponse = await _repository.fetchPassenger(context);
    _ratingFetcher.sink.add(timeResponse);
  }

  dispose() {
    _ratingFetcher.close();
  }
}

final passengerBloc = PassengerRangeBloc();
