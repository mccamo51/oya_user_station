import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/config/navigation.dart';
import 'package:oya_porter/pages/Users/screens/homepage/ticket/ticketWidget.dart';
class Tickets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ticketWidget(
      context: context,
      onBuyTicket: () => navigation(context: context, pageName: "home"),
    );
  }
}
