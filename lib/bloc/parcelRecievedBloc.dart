import 'package:oya_porter/config/repository.dart';
import 'package:oya_porter/models/myRouteModel.dart';
import 'package:oya_porter/models/parcelByPorter.dart';
import 'package:oya_porter/models/parcerRecievedModel.dart';
import 'package:oya_porter/models/ratingModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class ParcelRecievedBloc {
  Repository _repository = Repository();

  final _parcelFetcher = PublishSubject<ParcelRecievedModel>();

  Stream<ParcelRecievedModel> get parcelsent => _parcelFetcher.stream;

  fetchAllParcelRecieved(String id) async {
    ParcelRecievedModel timeResponse =
        await _repository.fetchParcelsRecieved(id);
    _parcelFetcher.sink.add(timeResponse);
  }

  dispose() {
    _parcelFetcher.close();
  }
}

final parcelRecievedBloc = ParcelRecievedBloc();
