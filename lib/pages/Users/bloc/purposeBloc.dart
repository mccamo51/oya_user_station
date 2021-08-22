import 'package:flutter/material.dart';
import 'package:oya_porter/pages/Users/config/repository.dart';
import 'package:oya_porter/pages/Users/model/purposeModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class PurposeBloc {
  Repository _repository = Repository();

  final _ratingFetcher = PublishSubject<PurposeModel>();

  Stream<PurposeModel> get purpose => _ratingFetcher.stream;

  fetchPurposes(BuildContext context) async {
    PurposeModel timeResponse = await _repository.fetchPurpose(context);
    _ratingFetcher.sink.add(timeResponse);
  }

  dispose() {
    _ratingFetcher.close();
  }
}

final purposeBloc = PurposeBloc();
