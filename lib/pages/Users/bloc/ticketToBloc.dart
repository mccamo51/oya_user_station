
import 'package:flutter/material.dart';
import 'package:oya_porter/pages/Users/config/repository.dart';
import 'package:oya_porter/pages/Users/model/ticketToModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class TicketToBloc {
  Repository _repository = Repository();

  final _ticketToFetcher = PublishSubject<TicketToModel>();

  Stream<TicketToModel> get ticketTo => _ticketToFetcher.stream;

  fetchTicketTo(int id,BuildContext context) async {
    TicketToModel timeResponse = await _repository.fetchTicketTo(id, context);
    _ticketToFetcher.sink.add(timeResponse);
  }

  dispose() {
    _ticketToFetcher.close();
  }
}

final ticketToBloc = TicketToBloc();
