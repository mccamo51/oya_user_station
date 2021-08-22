import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/pages/Users/config/navigation.dart';
import 'package:oya_porter/spec/styles.dart';
import 'enrollTrip.dart';
import 'widgets/tripWidget.dart';

class Trips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return tripWidget(
      context: context,
      onBuyTicket: () => navigation(context: context, pageName: "ticketing"),
      onEnrollBus: () => _onEnrollBus(context),
    );
  }

  void _onEnrollBus(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Enrol on Bus'),
        children: [
          ListTile(
            title: Text('Ticket Enrolment', style: h3Black),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EnrollTrip(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
