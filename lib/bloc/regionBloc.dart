import 'package:oya_porter/config/repository.dart';
import 'package:oya_porter/models/busTypeModel.dart';
import 'package:oya_porter/models/regionModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class RegionBloc {
  Repository _repository = Repository();

  final _ratingFetcher = PublishSubject<RegionModel>();

  Stream<RegionModel> get regions => _ratingFetcher.stream;

  fetchRegion() async {
    RegionModel timeResponse = await _repository.fetchRegion();
    _ratingFetcher.sink.add(timeResponse);
  }

  dispose() {
    _ratingFetcher.close();
  }
}

final regionBloc = RegionBloc();
