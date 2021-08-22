import 'package:flutter/material.dart';
import 'package:oya_porter/pages/Users/config/repository.dart';
import 'package:oya_porter/pages/Users/model/parcerRecievedModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class ParcelRecievedBloc {
  Repository _repository = Repository();

  final _parcelFetcher = PublishSubject<ParcelRecievedModel>();

  Stream<ParcelRecievedModel> get parcelsent => _parcelFetcher.stream;

  fetchAllParcelRecieved(BuildContext context) async {
    ParcelRecievedModel timeResponse = await _repository.fetchParcelsRecieved(context);
    _parcelFetcher.sink.add(timeResponse);
  }

  dispose() {
    _parcelFetcher.close();
  }
}

final parcelRecievedBloc = ParcelRecievedBloc();
