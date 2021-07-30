import 'package:flutter/material.dart';
import 'package:oya_porter/config/repository.dart';
import 'package:oya_porter/models/ticketModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class TicketBloc {
  Repository _repository = Repository();

  final _ratingFetcher = PublishSubject<TicketsModel>();

  Stream<TicketsModel> get allTickets => _ratingFetcher.stream;

  fetchAllTicket(String id, BuildContext context) async {
    TicketsModel timeResponse = await _repository.fetchTicket(id, context);
    _ratingFetcher.sink.add(timeResponse);
  }

  dispose() {
    _ratingFetcher.close();
  }
}

final ticketBloc = TicketBloc();
