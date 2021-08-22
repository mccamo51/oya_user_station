import 'package:flutter/material.dart';
import 'package:oya_porter/pages/Users/screens/homepage/homeMap/newHome.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/styles.dart';

Widget seatSelectionWidget({
  @required BuildContext context,
  @required Widget mainContent,
}) {
  return SingleChildScrollView(
    child: Column(children: [
      SizedBox(height: 10),
      Text(
        "Please select your pefered seat below:",
        style: h3Black,
      ),
      SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _labels(color: LIGHTGREEN, text: "Available"),
          _labels(color: LIGHTRED, text: "Unvailable"),
          _labels(color: PRIMARYCOLOR, text: "Your Selection"),
        ],
      ),
      SizedBox(height: 15),
      mainContent,
    ]),
  );
}

Widget seatSelectionButtonWidget({
  @required void Function() onPressed,
  @required void Function() onAddOther,
  @required String details,
  @required String totalNumber,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("$details"),
        if (buyTicketForOthers) ...[
          SizedBox(height: 10),
          ButtonTheme(
            minWidth: 500,
            height: 40,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: PRIMARYCOLOR),
            ),
            child: FlatButton(
              onPressed: onAddOther,
              child: Text("Add Passenger ($totalNumber)", style: h4Button),
              textColor: PRIMARYCOLOR,
            ),
          ),
        ],
        SizedBox(height: 10),
        ButtonTheme(
          minWidth: 500,
          height: 40,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: PRIMARYCOLOR),
          ),
          child: FlatButton(
            onPressed: onPressed,
            color: PRIMARYCOLOR,
            child: Text("Continue", style: h4Button),
            textColor: WHITE,
          ),
        ),
      ],
    ),
  );
}

Widget seatSelectionBusWidget({
  @required String text,
  @required Color color,
  @required BuildContext context,
  @required void Function() onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width * .15,
      // height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        // color: color,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: color),
      ),
      child: Column(
        children: [
          Icon(
            Icons.event_seat,
            color: color,
            size: 40,
          ),
          Text(
            "$text",
            style: TextStyle(
              color: color,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _labels({
  @required String text,
  @required Color color,
}) {
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Container(
      width: 20,
      height: 20,
      color: color,
    ),
    SizedBox(height: 10),
    Text("$text", style: h5Black),
  ]);
}
