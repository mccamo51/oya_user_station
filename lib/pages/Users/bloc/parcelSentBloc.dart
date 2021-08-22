import 'package:flutter/widgets.dart';
import 'package:oya_porter/pages/Users/config/repository.dart';
import 'package:oya_porter/pages/Users/model/parcelSentModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class ParcelSentBloc {
  Repository _repository = Repository();

  final _parcelFetcher = PublishSubject<ParcelSentUserModel>();

  Stream<ParcelSentUserModel> get parcelsent => _parcelFetcher.stream;

  fetchAllParcelSent(BuildContext context) async {
    ParcelSentUserModel timeResponse = await _repository.fetchParcelsSent(context);
    _parcelFetcher.sink.add(timeResponse);
  }

  dispose() {
    _parcelFetcher.close();
  }
}

final parcelSentBloc = ParcelSentBloc();
