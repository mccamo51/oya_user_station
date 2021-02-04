import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/spec/colors.dart';

class AddBus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Add New Bus"),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            textFormField(
              hintText: "Bus Reg No.",
              controller: null,
              focusNode: null,
              labelText: "Reg No",
            ),
            SizedBox(
              height: 10,
            ),
            textFormField(
              hintText: "Bus Reg No.",
              controller: null,
              focusNode: null,
              labelText: "Reg No",
            ),
            SizedBox(
              height: 10,
            ),
            textFormField(
              hintText: "Bus Reg No.",
              controller: null,
              focusNode: null,
              labelText: "Reg No",
            ),
            SizedBox(
              height: 10,
            ),
            textFormField(
              hintText: "Bus Reg No.",
              controller: null,
              focusNode: null,
              labelText: "Reg No",
            ),
            SizedBox(
              height: 10,
            ),
            textFormField(
                hintText: "Select Bus Type",
                controller: null,
                focusNode: null,
                enable: false,
                labelText: "Select Bus Type",
                icon: Icons.arrow_drop_down),
            SizedBox(
              height: 10,
            ),
            textFormField(
                hintText: "Select Bus Type",
                controller: null,
                focusNode: null,
                enable: false,
                labelText: "Select Bus Type",
                icon: Icons.arrow_drop_down),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoButton(
            color: PRIMARYCOLOR,
            child: Text("Add Bus"),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
