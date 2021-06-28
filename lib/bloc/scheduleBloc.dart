import 'package:oya_porter/config/repository.dart';
import 'package:oya_porter/models/ScheduleModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class ScheduleBloc {
  Repository _repository = Repository();

  final _ratingFetcher = PublishSubject<ScheduleModel>();

  Stream<ScheduleModel> get allRating => _ratingFetcher.stream;

  fetchAllStaffs({String id, String routeId}) async {
    ScheduleModel timeResponse =
        await _repository.fetchSchedule(routId: routeId, staffId: id);
    _ratingFetcher.sink.add(timeResponse);
  }

  dispose() {
    _ratingFetcher.close();
  }
}

final scheduleBloc = ScheduleBloc();
