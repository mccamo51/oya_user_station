import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/spec/colors.dart';

class AddTicket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Sell Ticket"),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {},
              child: textFormField(
                  hintText: "Select Route",
                  controller: null,
                  focusNode: null,
                  icon: Icons.arrow_drop_down,
                  enable: false),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {},
              child: textFormField(
                  hintText: "Select Bus",
                  controller: null,
                  focusNode: null,
                  icon: Icons.arrow_drop_down,
                  enable: false),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            textFormField(
              hintText: "Enter Reciepient Phone",
              controller: null,
              inputType: TextInputType.phone,
              focusNode: null,
            ),
            SizedBox(
              height: 15,
            ),
            textFormField(
              hintText: "Minors",
              controller: null,
              inputType: TextInputType.number,
              focusNode: null,
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {},
              child: textFormField(
                  hintText: "Select Mode of payment",
                  controller: null,
                  focusNode: null,
                  icon: Icons.arrow_drop_down,
                  enable: false),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoButton(
            color: PRIMARYCOLOR,
            child: Text("Submit"),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
