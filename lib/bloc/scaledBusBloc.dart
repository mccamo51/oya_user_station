import 'package:oya_porter/config/repository.dart';
import 'package:oya_porter/models/scaledBusModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class ScaledBloc {
  Repository _repository = Repository();

  final _busesFetcher = PublishSubject<ScaledBusModel>();

  Stream<ScaledBusModel> get scaledBuses => _busesFetcher.stream;

  fetchScaledBuses(String id) async {
    ScaledBusModel timeResponse = await _repository.fetchScaledBus(id);
    _busesFetcher.sink.add(timeResponse);
  }

  dispose() {
    _busesFetcher.close();
  }
}

final scaledBloc = ScaledBloc();
