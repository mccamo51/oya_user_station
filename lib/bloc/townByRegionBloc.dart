import 'package:oya_porter/config/repository.dart';
import 'package:oya_porter/models/townRegionModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class MyRouteBloc {
  Repository _repository = Repository();

  final _ratingFetcher = PublishSubject<TonwFromRegionModel>();

  Stream<TonwFromRegionModel> get townFromregion => _ratingFetcher.stream;

  fetchTownByReg(String id) async {
    TonwFromRegionModel timeResponse = await _repository.frechTownByRegion(id);
    _ratingFetcher.sink.add(timeResponse);
  }

  dispose() {
    _ratingFetcher.close();
  }
}

final townsByRegBloc = MyRouteBloc();
