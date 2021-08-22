import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/images.dart';

Widget ticketWidget({
  @required BuildContext context,
  @required Function onBuyTicket,
}) {
  return Scaffold(
    backgroundColor: WHITE,
    appBar: AppBar(
      elevation: 0,
      title: Text("My Tickets"),
    ),
    body: Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              TICKETIMAGE,
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            Container(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "You Haven’t Bought\n Any Tickets",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Once you do, we’ll show your \ntickets on this page.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 45,
                    width: 150,
                    child: FlatButton(
                      onPressed: onBuyTicket,
                      child: Text(
                        "Buy a Ticket",
                        style: TextStyle(
                          color: WHITE,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: PRIMARYCOLOR,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
