import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/styles.dart';


Widget passengerSelectionWidget({
  @required BuildContext context,
  @required bool slide,
  @required bool slide2,
  @required TextEditingController fullNameController,
  @required TextEditingController phoneController,
  @required TextEditingController seatAssignController,
  @required TextEditingController fullNameController2,
  @required TextEditingController phoneController2,
  @required TextEditingController seatAssignController2,
  @required FocusNode fullNamefocusNode,
  @required FocusNode phonefocusNode,
  @required FocusNode seatAssignfocusNode,
  @required FocusNode fullNamefocusNode2,
  @required FocusNode phonefocusNode2,
  @required FocusNode seatAssignfocusNode2,
  @required void Function(bool value) onSlideChanges,
  @required void Function() onSlidedTap,
  @required void Function(bool value) onSlideChanges2,
  @required void Function() onSlidedTap2,
  @required void Function() onContinue,
}) {
  return Container(
    padding: EdgeInsets.all(10),
    child: SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Passenger 1", style: h5Black),
        SizedBox(height: 10),
        textFormField(
          controller: fullNameController,
          focusNode: fullNamefocusNode,
          hintText: "FullName",
          labelText: "FullName",
        ),
        SizedBox(height: 10),
        textFormField(
          controller: phoneController,
          focusNode: phonefocusNode,
          hintText: "Phone Number",
          labelText: "Phone Number",
          inputType: TextInputType.phone,
        ),
        SizedBox(height: 10),
        textFormField(
          controller: seatAssignController,
          focusNode: seatAssignfocusNode,
          hintText: "Seat Assignment",
          labelText: "Seat Assignment",
        ),
        MergeSemantics(
          child: ListTile(
            title: Text('Is the passenger a minor?'),
            leading: CupertinoSwitch(
              activeColor: LIGHTRED,
              value: slide,
              onChanged: (bool value) => onSlideChanges(value),
            ),
            onTap: onSlidedTap,
          ),
        ),
        SizedBox(height: 10),
        Text("Passenger 2", style: h5Black),
        SizedBox(height: 10),
        textFormField(
          controller: fullNameController2,
          focusNode: fullNamefocusNode2,
          hintText: "FullName",
          labelText: "FullName",
        ),
        SizedBox(height: 10),
        textFormField(
          controller: phoneController2,
          focusNode: phonefocusNode2,
          hintText: "Phone Number",
          labelText: "Phone Number",
        ),
        SizedBox(height: 10),
        textFormField(
          controller: seatAssignController2,
          focusNode: seatAssignfocusNode2,
          hintText: "Seat Assignment",
          labelText: "Seat Assignment",
        ),
        MergeSemantics(
          child: ListTile(
            title: Text('Is the passenger a minor?'),
            leading: CupertinoSwitch(
              activeColor: LIGHTRED,
              value: slide2,
              onChanged: (bool value) => onSlideChanges2(value),
            ),
            onTap: onSlidedTap2,
          ),
        ),
        SizedBox(height: 10),
        ButtonTheme(
          minWidth: 500,
          height: 40,
          child: FlatButton(
            color: PRIMARYCOLOR,
            onPressed: onContinue,
            child: Text("Continue", style: h4Button),
            textColor: WHITE,
          ),
        ),
      ],
    )),
  );
}
