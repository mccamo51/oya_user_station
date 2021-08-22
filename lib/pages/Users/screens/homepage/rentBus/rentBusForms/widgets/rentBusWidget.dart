import 'package:flutter/material.dart';
import 'package:oya_porter/components/buttons.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/config/button.dart';
import 'package:oya_porter/spec/styles.dart';

enum TripType { onewayTrip, returnTrip }
rentBusFormWidget({
  @required BuildContext context,
  @required TextEditingController firstNameController,
  @required TextEditingController lastNameController,
  @required TextEditingController phoneNumberController,
  @required Function onContinue,
}) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          customBack(context, "Rent a Bus"),
          SizedBox(
            height: 15,
          ),
          SizedBox(height: 40),
          Column(children: [
            textFormField(
                controller: null,
                focusNode: null,
                hintText: "Origin",
                labelText: "Origin"),
            SizedBox(height: 15),
            textFormField(
              controller: null,
              focusNode: null,
              hintText: "Destination",
              labelText: "Destination",
            ),
            SizedBox(height: 15),
            textFormField(
                controller: null,
                focusNode: null,
                hintText: "Date",
                labelText: "Date",
                icon: Icons.calendar_today),
            SizedBox(height: 15),
            textFormField(
                controller: null,
                focusNode: null,
                hintText: "Time",
                labelText: "Time",
                icon: Icons.timelapse_outlined),
            SizedBox(height: 15),
            Text(
              "What type of trip are you renting for?",
              style: h4Black,
            ),
            _tripTypeRadio(),
            SizedBox(height: 20),
            SizedBox(
                width: double.infinity,
                height: 45,
                child: primaryButton(onFunction: onContinue, title: "Continue"))
          ])
        ]),
      ),
    ),
  );
}

_tripTypeRadio() {
  TripType _character = TripType.onewayTrip;
  return Center(
    child: Column(
      children: <Widget>[
        ListTile(
          title: const Text('One Way Trip'),
          leading: Radio(
            value: TripType.onewayTrip,
            groupValue: _character,
            onChanged: (TripType value) {
              print(value);
              // setState(() { _character = value; });
            },
          ),
        ),
        ListTile(
          title: const Text('Return Trip'),
          leading: Radio(
            value: TripType.returnTrip,
            groupValue: _character,
            onChanged: (TripType value) {
              print(value);
              // setState(() { _character = value; });
            },
          ),
        ),
      ],
    ),
  );
}
