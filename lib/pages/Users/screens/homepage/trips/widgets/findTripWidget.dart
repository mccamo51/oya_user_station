import 'package:flutter/material.dart';
import 'package:oya_porter/components/buttons.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/config/button.dart';

Widget findTripWidgt({
  @required BuildContext context,
  @required Function onFindTrip,
  @required TextEditingController tripCodeController,
  @required TextEditingController minorController,
  @required FocusNode tripFocus,
  @required FocusNode minorFocus,
}) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          customBack(context, "Find Trip"),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Column(
              children: [
                textFormField(
                  hintText: "Enter Trip code",
                  controller: tripCodeController,
                  focusNode: tripFocus,
                  labelText: "Ticket Code",
                ),
                SizedBox(height: 20),
                textFormField(
                  hintText: "Enter number of minors",
                  controller: minorController,
                  inputType: TextInputType.number,
                  focusNode: minorFocus,
                  labelText: "Minors",
                ),
                SizedBox(height: 20),
                SizedBox(
                    width: double.infinity,
                    child: primaryButton(
                      title: "Add to Trip",
                      onFunction: onFindTrip,
                    ))
              ],
            ),
          )
        ],
      ),
    ),
  );
}
