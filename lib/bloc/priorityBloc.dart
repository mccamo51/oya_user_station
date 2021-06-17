import 'package:flutter/material.dart';
import 'package:oya_porter/config/repository.dart';
import 'package:oya_porter/models/priorityBusModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class PriorityBusBloc {
  Repository _repository = Repository();

  final _busesFetcher = PublishSubject<PriorityBusModel>();

  Stream<PriorityBusModel> get prioritybus => _busesFetcher.stream;

  fetchPriorityBuses(String id,BuildContext context) async {
    PriorityBusModel timeResponse = await _repository.fetchPriorityBus(id, context);
    _busesFetcher.sink.add(timeResponse);
  }

  dispose() {
    _busesFetcher.close();
  }
}

final priorityBusBloc = PriorityBusBloc();
