import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/spec/colors.dart';

Widget editRouteWidget({
  @required BuildContext context,
  @required TextEditingController regionController,
  @required TextEditingController townController,
  @required TextEditingController destinationController,
  @required Function onSelectRegion,
  @required Function onSelectTown,
  @required Function onSelectDestination,
  @required Function onAddROute,
  @required Key formKey,
}) {
  return Scaffold(
    appBar: appBar(title: "Edit Route"),
    body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Visibility(
              child: GestureDetector(
                  child: textFormField(
                    hintText: "Select Source Town",
                    controller: townController,
                    // validate: true,
                    // validateMsg: "Select Destination Town",
                    focusNode: null,
                    icon: Icons.arrow_drop_down,
                    enable: false,
                  ),
                  onTap: onSelectTown),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: onSelectRegion,
              child: textFormField(
                hintText: "Select Region",
                controller: regionController,
                validate: true,
                validateMsg: "Select Region first",
                focusNode: null,
                icon: Icons.arrow_drop_down,
                enable: false,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Visibility(
                child: GestureDetector(
              onTap: onSelectDestination,
              child: textFormField(
                hintText: "Select Destination Town",
                // validate: true,
                // validateMsg: "Select Source Town",
                controller: destinationController,
                focusNode: null,
                icon: Icons.arrow_drop_down,
                enable: false,
              ),
            )),
          ],
        ),
      ),
    ),
    bottomNavigationBar: Container(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CupertinoButton(
          color: PRIMARYCOLOR,
          child: Text("Update Route"),
          onPressed: onAddROute,
        ),
      ),
    ),
  );
}
