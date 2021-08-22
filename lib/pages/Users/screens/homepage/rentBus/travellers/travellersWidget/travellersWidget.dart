import 'package:flutter/material.dart';
import 'package:oya_porter/components/buttons.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/config/button.dart';
import 'package:oya_porter/spec/styles.dart';

Widget travellersWidget(
    {@required BuildContext context, @required Function onContinue}) {
  return Scaffold(
    body: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            customBack(context, "Rent a Bus"),
            SizedBox(height: 20),
            Text(
              "Travellers",
              style: h3Black,
            ),
            textFormField(
                controller: null,
                focusNode: null,
                hintText: "Number of Passengers",
                labelText: "Number of Passengers"),
            SizedBox(height: 15),
            textFormField(
              controller: null,
              focusNode: null,
              hintText: "Purpose",
              labelText: "Purpose",
            ),
            SizedBox(height: 15),
            textFormField(
              controller: null,
              focusNode: null,
              hintText: "Name of Secondary Contact",
              labelText: "Name of Secondary Contact",
            ),
            SizedBox(height: 15),
            textFormField(
              controller: null,
              focusNode: null,
              inputType: TextInputType.number,
              hintText: "Secondary Contact Phone",
              labelText: "Secondary Contact Phone",
            ),
            SizedBox(height: 20),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: primaryButton(
                        onFunction: onContinue, title: "Continue"),
                  ))),
        ),
      ],
    ),
  );
}
