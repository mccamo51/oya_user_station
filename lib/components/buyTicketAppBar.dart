import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oya_porter/spec/colors.dart';

class BuyTicketAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Buy a Ticket",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.info_outline_rounded,
            color: Colors.red,
          ),
          onPressed: () {}
          //  iceAlert(
          //   context,
          //   "You may buy a ticket by completing this form, or enrol on a bus on the trips page with an existing ticket.",
          // ),
        ),
      ],
      backgroundColor: PRIMARYCOLOR,
    );
  }
}
