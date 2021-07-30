import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/spec/colors.dart';

Widget addBusWidget({
  @required BuildContext context,
  @required TextEditingController regNoController,
  @required TextEditingController busModelController,
  @required TextEditingController roadWorthyExpController,
  @required TextEditingController insExpController,
  @required TextEditingController busTypeController,
  @required TextEditingController busTypeController2,
  @required Function onSave,
  @required Function onSelectBus,
  @required Function onSelectDriver,
  @required Function onInsurance,
  @required Function onRoadWorthy,
}) {
  return Scaffold(
    appBar: appBar(title: "Add New Bus"),
    body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            textFormField(
              hintText: "Bus Reg No.",
              controller: regNoController,
              focusNode: null,
              labelText: "Reg No",
            ),
            SizedBox(
              height: 10,
            ),
            textFormField(
              hintText: "Bus Model",
              controller: busModelController,
              focusNode: null,
              labelText: "Bus Model",
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: onSelectBus,
              child: textFormField(
                  hintText: "Select Bus Type",
                  controller: busTypeController,
                  focusNode: null,
                  enable: false,
                  labelText: "Select Bus Type",
                  icon: Icons.arrow_drop_down),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: onSelectDriver,
              child: textFormField(
                  hintText: "Select Bus Driver",
                  controller: busTypeController2,
                  focusNode: null,
                  enable: false,
                  labelText: "Select Bus Driver",
                  icon: Icons.arrow_drop_down),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: onRoadWorthy,
              child: textFormField(
                hintText: "Select Road Worthy Expiration",
                controller: roadWorthyExpController,
                focusNode: null,
                enable: false,
                labelText: "Select Road Worthy Expiration",
                icon: Icons.calendar_today,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: onInsurance,
              child: textFormField(
                hintText: "Select Insurance Expiration",
                controller: insExpController,
                focusNode: null,
                enable: false,
                labelText: "Select Insurance Expiration",
                icon: Icons.calendar_today,
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
          child: Text("Add Bus"),
          onPressed: onSave,
        ),
      ),
    ),
  );
}
