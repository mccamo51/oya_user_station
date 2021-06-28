import 'package:oya_porter/config/repository.dart';
import 'package:oya_porter/models/ticketModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class PickupBloc {
  Repository _repository = Repository();

  final _pickupsFetcher = PublishSubject<PickupModel>();

  Stream<PickupModel> get pickups => _pickupsFetcher.stream;

  fetchAllBusSchedulePickups(String id) async {
    PickupModel timeResponse =
        await _repository.fetchBusSchedulePickups(scheduleId: id);
    _pickupsFetcher.sink.add(timeResponse);
  }

  dispose() {
    _pickupsFetcher.close();
  }
}

final pickupBloc = PickupBloc();
