
import 'package:flutter/material.dart';
import 'package:oya_porter/pages/Users/config/repository.dart';
import 'package:oya_porter/pages/Users/model/pickupPointModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class PickupPointBloc {
  Repository _repository = Repository();

  final _pickupPointFetcher = PublishSubject<PickupPointModel>();

  Stream<PickupPointModel> get pickupPoint => _pickupPointFetcher.stream;

  fetchPickupPoint(String busId,BuildContext context) async {
    PickupPointModel timeResponse = await _repository.fetchPickupPoint(busId, context);
    _pickupPointFetcher.sink.add(timeResponse);
  }

  dispose() {
    _pickupPointFetcher.close();
  }
}

final pickupPointBloc = PickupPointBloc();
