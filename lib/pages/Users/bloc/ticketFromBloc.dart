
import 'package:flutter/material.dart';
import 'package:oya_porter/pages/Users/config/repository.dart';
import 'package:oya_porter/pages/Users/model/ticketFromModel.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class TicketFromBloc {
  Repository _repository = Repository();

  final _ticketFromFetcher = PublishSubject<TicketFromModel>();

  Stream<TicketFromModel> get ticketFrom => _ticketFromFetcher.stream;

  fetchTicketFrom(BuildContext context) async {
    TicketFromModel timeResponse = await _repository.fetchTicketFrom(context);
    _ticketFromFetcher.sink.add(timeResponse);
  }

  dispose() {
    _ticketFromFetcher.close();
  }
}

final ticketFromBloc = TicketFromBloc();
