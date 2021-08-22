import 'package:flutter/material.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/styles.dart';

Widget manuelEnrolmentWidget({
  @required TextEditingController fromController,
  @required TextEditingController toController,
  @required TextEditingController dateController,
  @required TextEditingController busNumberController,
  @required FocusNode fromFocusNode,
  @required FocusNode toFocusNode,
  @required void Function() onDate,
  @required void Function() onBusNumber,
}) {
  return Container(
    padding: EdgeInsets.all(10),
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Journey Details", style: h5Black),
          SizedBox(height: 10),
          textFormField(
            controller: fromController,
            focusNode: fromFocusNode,
            hintText: "Where are you travelling from?",
            labelText: "Where are you travelling from?",
          ),
          SizedBox(height: 10),
          textFormField(
            controller: toController,
            focusNode: toFocusNode,
            hintText: "Where are you travelling to?",
            labelText: "Where are you travelling to?",
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {},
            child: textFormField(
              controller: dateController,
              focusNode: null,
              hintText: "Date",
              labelText: "Date",
              icon: Icons.calendar_today,
              iconColor: PRIMARYCOLOR,
              enable: false,
              removeBorder: true,
            ),
          ),
          SizedBox(height: 10),
          textFormField(
            controller: busNumberController,
            focusNode: null,
            hintText: "Bus Number",
            labelText: "Bus Number",
            icon: Icons.calendar_today,
            iconColor: PRIMARYCOLOR,
            enable: false,
            removeBorder: true,
          ),
        ],
      ),
    ),
  );
}

Widget manuelEnrolmentBottomWidget({
  @required void Function() onAddTrip,
  @required void Function() onCancel,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ButtonTheme(
          minWidth: 500,
          height: 40,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: PRIMARYCOLOR),
          ),
          child: FlatButton(
            onPressed: onAddTrip,
            child: Text("Add to My Trips", style: h4Button),
            textColor: PRIMARYCOLOR,
          ),
        ),
        SizedBox(height: 10),
        ButtonTheme(
          minWidth: 500,
          height: 40,
          child: FlatButton(
            onPressed: onCancel,
            child: Text("Cancel", style: h4Button),
            textColor: PRIMARYCOLOR,
          ),
        ),
      ],
    ),
  );
}
