import 'package:flutter/material.dart';
import 'package:oya_porter/config/repository.dart';
import 'package:oya_porter/models/ratingModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class RatingBloc {
  Repository _repository = Repository();

  final _ratingFetcher = PublishSubject<RatingModel>();

  Stream<RatingModel> get allRating => _ratingFetcher.stream;

  fetchAllStaffs(String id,BuildContext context) async {
    RatingModel timeResponse = await _repository.fetchAllRating(id, context);
    _ratingFetcher.sink.add(timeResponse);
  }

  dispose() {
    _ratingFetcher.close();
  }
}

final ratingBloc = RatingBloc();
