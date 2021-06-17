import 'package:flutter/material.dart';
import 'package:oya_porter/config/repository.dart';
import 'package:oya_porter/models/stuffModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class StaffBloc {
  Repository _repository = Repository();

  final _staffFetcher = PublishSubject<StaffModel>();

  Stream<StaffModel> get allStaff => _staffFetcher.stream;

  fetchAllStaffs(String id, BuildContext context) async {
    StaffModel timeResponse = await _repository.fetchAllStaff(id, context);
    _staffFetcher.sink.add(timeResponse);
  }

  dispose() {
    _staffFetcher.close();
  }
}

final stafBloc = StaffBloc();
