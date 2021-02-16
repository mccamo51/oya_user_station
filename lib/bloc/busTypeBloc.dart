import 'package:oya_porter/config/repository.dart';
import 'package:oya_porter/models/busTypeModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class BusTypeBloc {
  Repository _repository = Repository();

  final _ratingFetcher = PublishSubject<BusTypeModel>();

  Stream<BusTypeModel> get busesType => _ratingFetcher.stream;

  fetchDrivers() async {
    BusTypeModel timeResponse = await _repository.fetchBusType();
    _ratingFetcher.sink.add(timeResponse);
  }

  dispose() {
    _ratingFetcher.close();
  }
}

final busTypeBloc = BusTypeBloc();
