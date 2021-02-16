import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/spec/colors.dart';

Widget addRouteWidget({
  @required BuildContext context,
  @required TextEditingController regionController,
  @required TextEditingController townController,
  @required TextEditingController destinationController,
  @required Function onSelectRegion,
  @required Function onSelectTown,
  @required Function onSelectDestination,
  @required Function onAddROute,
}) {
  return Scaffold(
    appBar: appBar(title: "Add New Route"),
    body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: onSelectRegion,
            child: textFormField(
              hintText: "Select Region",
              controller: regionController,
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
                child: textFormField(
                  hintText: "Select Source Town",
                  controller: townController,
                  focusNode: null,
                  icon: Icons.arrow_drop_down,
                  enable: false,
                ),
                onTap: onSelectTown),
          ),
          SizedBox(
            height: 15,
          ),
          Visibility(
              child: GestureDetector(
            onTap: onSelectDestination,
            child: textFormField(
              hintText: "Select Destination Town",
              controller: destinationController,
              focusNode: null,
              icon: Icons.arrow_drop_down,
              enable: false,
            ),
          ))
        ],
      ),
    ),
    bottomNavigationBar: Container(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CupertinoButton(
          color: PRIMARYCOLOR,
          child: Text("Add Route"),
          onPressed: onAddROute,
        ),
      ),
    ),
  );
}
