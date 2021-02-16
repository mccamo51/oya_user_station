import 'package:oya_porter/config/repository.dart';
import 'package:oya_porter/models/busTypeModel.dart';
import 'package:oya_porter/models/regionModel.dart';
import 'package:oya_porter/models/townModle.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class TownBloc {
  Repository _repository = Repository();

  final _ratingFetcher = PublishSubject<TownModel>();

  Stream<TownModel> get towns => _ratingFetcher.stream;

  fetchTown() async {
    TownModel timeResponse = await _repository.fetchTown();
    _ratingFetcher.sink.add(timeResponse);
  }

  dispose() {
    _ratingFetcher.close();
  }
}

final townBloc = TownBloc();
