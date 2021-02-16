import 'package:oya_porter/config/repository.dart';
import 'package:oya_porter/models/PorterModel.dart';
import 'package:oya_porter/models/conductorModel.dart';
import 'package:oya_porter/models/driverModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class PortersBloc {
  Repository _repository = Repository();

  final _porterFetcher = PublishSubject<PortersModel>();

  Stream<PortersModel> get porters => _porterFetcher.stream;

  fetchPorters(String id) async {
    PortersModel timeResponse = await _repository.fetchPorter(id);
    _porterFetcher.sink.add(timeResponse);
  }

  dispose() {
    _porterFetcher.close();
  }
}

final porterBloc = PortersBloc();
