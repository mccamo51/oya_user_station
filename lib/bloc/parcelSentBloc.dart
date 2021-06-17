import 'package:flutter/material.dart';
import 'package:oya_porter/config/repository.dart';
import 'package:oya_porter/models/parcelByPorter.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class ParcelSentBloc {
  Repository _repository = Repository();

  final _parcelFetcher = PublishSubject<ParcelSentUserModel>();

  Stream<ParcelSentUserModel> get parcelsent => _parcelFetcher.stream;

  fetchAllParcelSent(String id,BuildContext context) async {
    ParcelSentUserModel timeResponse = await _repository.fetchParcelsSent(id, context);
    _parcelFetcher.sink.add(timeResponse);
  }

  dispose() {
    _parcelFetcher.close();
  }
}

final parcelSentBloc = ParcelSentBloc();
