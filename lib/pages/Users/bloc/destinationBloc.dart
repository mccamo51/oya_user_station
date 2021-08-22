import 'package:flutter/material.dart';
import 'package:oya_porter/pages/Users/config/repository.dart';
import 'package:oya_porter/pages/Users/model/sepcialDestinantionModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class DestinationBloc {
  Repository _repository = Repository();

  final _ticketFromFetcher = PublishSubject<SepcialDestinantionModel>();

  Stream<SepcialDestinantionModel> get destinations => _ticketFromFetcher.stream;

  fetchDestination(BuildContext context) async {
    SepcialDestinantionModel timeResponse = await _repository.fetchDestination(context);
    _ticketFromFetcher.sink.add(timeResponse);
  }

  dispose() {
    _ticketFromFetcher.close();
  }
}

final destinationBloc = DestinationBloc();
