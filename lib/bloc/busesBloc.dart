import 'package:oya_porter/config/repository.dart';
import 'package:oya_porter/models/busModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class BusesBloc {
  Repository _repository = Repository();

  final _busesFetcher = PublishSubject<BussModel>();

  Stream<BussModel> get allBuses => _busesFetcher.stream;

  fetchAllStaffs(String id) async {
    BussModel timeResponse = await _repository.fetchBusses(id);
    _busesFetcher.sink.add(timeResponse);
  }

  dispose() {
    _busesFetcher.close();
  }
}

final busesBloc = BusesBloc();
