import 'package:oya_porter/config/repository.dart';
import 'package:oya_porter/models/conductorModel.dart';
import 'package:oya_porter/models/driverModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class ConductorBloc {
  Repository _repository = Repository();

  final _conductorFetcher = PublishSubject<ConductorModel>();

  Stream<ConductorModel> get conductors => _conductorFetcher.stream;

  fetchConductors(String id) async {
    ConductorModel timeResponse = await _repository.fetchConductor(id);
    _conductorFetcher.sink.add(timeResponse);
  }

  dispose() {
    _conductorFetcher.close();
  }
}

final conductorBloc = ConductorBloc();
