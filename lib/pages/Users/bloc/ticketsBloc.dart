import 'package:flutter/material.dart';
import 'package:oya_porter/pages/Users/config/repository.dart';
import 'package:oya_porter/pages/Users/model/ticketModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class TicketsBloc {
  Repository _repository = Repository();

  final _ticketsFetcher = PublishSubject<TicketsModel>();

  Stream<TicketsModel> get allTickets => _ticketsFetcher.stream;

  fetchAllTickets(BuildContext context) async {
    TicketsModel timeResponse = await _repository.fetchAllTickets(context);
    _ticketsFetcher.sink.add(timeResponse);
  }

  dispose() {
    _ticketsFetcher.close();
  }
}

final ticketsBloc = TicketsBloc();
