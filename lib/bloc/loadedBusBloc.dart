import 'package:oya_porter/config/repository.dart';
import 'package:oya_porter/models/loadedBusModel.dart';
import 'package:oya_porter/models/scaledBusModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class LoadedBusBloc {
  Repository _repository = Repository();

  final _busesFetcher = PublishSubject<LoadedBusModel>();

  Stream<LoadedBusModel> get loadedbuses => _busesFetcher.stream;

  fetchLoadedBuses(String id) async {
    LoadedBusModel timeResponse = await _repository.fetchLoadedBus(id);
    _busesFetcher.sink.add(timeResponse);
  }

  dispose() {
    _busesFetcher.close();
  }
}

final loadedBusBloc = LoadedBusBloc();
