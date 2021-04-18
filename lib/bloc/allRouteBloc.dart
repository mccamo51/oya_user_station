// import 'package:oya_porter/config/repository.dart';
// import 'package:oya_porter/models/allRouteModel.dart';
// import 'package:oya_porter/models/myRouteModel.dart';
// import 'package:oya_porter/models/ratingModel.dart';
// import 'package:rxdart/subjects.dart';
// import 'package:rxdart/rxdart.dart';

// class MyRouteBloc {
//   Repository _repository = Repository();

//   final _ratingFetcher = PublishSubject<AllRouteModel>();

//   Stream<AllRouteModel> get myroutes => _ratingFetcher.stream;

//   fetchAllStaffs(String id) async {
//     AllRouteModel timeResponse = await _repository.fetchRo(id);
//     _ratingFetcher.sink.add(timeResponse);
//   }

//   dispose() {
//     _ratingFetcher.close();
//   }
// }

// final myRouteBloc = MyRouteBloc();
