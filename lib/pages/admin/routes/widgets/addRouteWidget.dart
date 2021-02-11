import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/spec/colors.dart';

  Widget addRouteWidget({@required BuildContext context}) {
    return Scaffold(
      appBar: appBar(title: "Add New Route"),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            textFormField(
              hintText: "Select Region",
              controller: null,
              focusNode: null,
              icon: Icons.arrow_drop_down,
              enable: false,
            ),
            SizedBox(
              height: 15,
            ),
            Visibility(
              child: textFormField(
                hintText: "Select Source Town",
                controller: null,
                focusNode: null,
                icon: Icons.arrow_drop_down,
                enable: false,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Visibility(
              child: textFormField(
                hintText: "Select Destination Town",
                controller: null,
                focusNode: null,
                icon: Icons.arrow_drop_down,
                enable: false,
              ),
            )
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
            onPressed: () {},
          ),
        ),
      ),
    );
  }
