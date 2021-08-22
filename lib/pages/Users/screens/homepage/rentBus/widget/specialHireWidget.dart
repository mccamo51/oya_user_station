import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/spec/colors.dart';

Widget specialHireBusWidget({
  @required BuildContext context,
  @required Function rentBus,
  @required Function onSelectDate,
  @required Function onSelectTIme,
  @required Function onSelectFeature,
  @required Function onSelectCongregation,
  @required Function onSelectDestination,
  @required Function onSelectReturnTime,
  @required TextEditingController timePickController,
  @required TextEditingController datePickController,
  @required TextEditingController secondaryPhoneController,
  @required TextEditingController secondaryNameController,
  @required TextEditingController destinationController,
  @required TextEditingController congregationController,
  @required TextEditingController returnTimeController,
  @required TextEditingController numberOfDaysController,
  @required TextEditingController passengersController,
  @required TextEditingController featuresController,
  @required TextEditingController purposeController,
}) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: PRIMARYCOLOR,
      elevation: 0,
      iconTheme: IconThemeData(color: WHITE),
      centerTitle: true,
      title: Text(
        "Special Hire",
        style: TextStyle(color: Colors.white),
      ),
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: onSelectCongregation,
              child: textFormField(
                  hintText: "Select Congregation",
                  controller: congregationController,
                  focusNode: null,
                  enable: false,
                  labelText: "Select Congregation",
                  icon: Icons.arrow_drop_down),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: onSelectDestination,
              child: textFormField(
                  hintText: "Select Destination",
                  controller: destinationController,
                  focusNode: null,
                  enable: false,
                  labelText: "Select Destination",
                  icon: Icons.arrow_drop_down),
            ),
            SizedBox(
              height: 10,
            ),
            textFormField(
              hintText: "Secondary Name",
              controller: secondaryNameController,
              focusNode: null,
              labelText: "Secondary Name",
            ),
            SizedBox(
              height: 10,
            ),
            textFormField(
              hintText: "Secondary Phone",
              controller: secondaryPhoneController,
              focusNode: null,
              inputType: TextInputType.number,
              labelText: "Secondary Phone",
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: onSelectDate,
              child: textFormField(
                  hintText: "Pick Date",
                  controller: datePickController,
                  focusNode: null,
                  enable: false,
                  labelText: "Pick Date",
                  icon: Icons.calendar_today_rounded),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: onSelectTIme,
              child: textFormField(
                  hintText: "Pick Time",
                  controller: timePickController,
                  focusNode: null,
                  enable: false,
                  labelText: "Pick Time",
                  icon: Icons.timelapse),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: onSelectReturnTime,
              child: textFormField(
                hintText: "Return Time",
                controller: returnTimeController,
                focusNode: null,
                enable: false,
                labelText: "Return Time",
                icon: Icons.timelapse_outlined,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            textFormField(
              hintText: "Number of Passengers",
              controller: passengersController,
              focusNode: null,
              inputType: TextInputType.number,
              labelText: "Number of Passengers",
            ),
            SizedBox(
              height: 10,
            ),
            textFormField(
              hintText: "Purpose",
              controller: purposeController,
              focusNode: null,
              labelText: "Purpose",
            ),
            SizedBox(
              height: 10,
            ),
            textFormField(
              hintText: "Number of Days",
              controller: numberOfDaysController,
              focusNode: null,
              inputType: TextInputType.number,
              labelText: "Number of Days",
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: onSelectFeature,
              child: textFormField(
                hintText: "Select Features",
                controller: featuresController,
                focusNode: null,
                enable: false,
                labelText: "Select Festures",
                icon: Icons.arrow_drop_down,
              ),
            )
          ],
        ),
      ),
    ),
    bottomNavigationBar: Container(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CupertinoButton(
          color: PRIMARYCOLOR,
          child: Text("Hire Bus"),
          onPressed: rentBus,
        ),
      ),
    ),
  );
}
