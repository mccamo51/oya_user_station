import 'package:flutter/material.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/textField.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Account", actions: [
        IconButton(icon: Icon(Icons.more_vert_sharp), onPressed: () {})
      ]),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textFormField(
                hintText: "Name",
                controller: null,
                focusNode: null,
                enable: false,
                labelText: "Name"),
            SizedBox(
              height: 10,
            ),
            textFormField(
              hintText: "Phone Number",
              controller: null,
              focusNode: null,
              enable: false,
            ),
            SizedBox(
              height: 10,
            ),
            textFormField(
                hintText: "Primary ICE Phone number",
                controller: null,
                focusNode: null,
                enable: false),
            SizedBox(
              height: 10,
            ),
            textFormField(
              hintText: "Secondary ICE Phone number",
              controller: null,
              focusNode: null,
            ),
            SizedBox(
              height: 20,
            ),
            Text("Account Pin"),
            Divider(),
            textFormField(
                hintText: "****",
                controller: null,
                focusNode: null,
                enable: false),
          ],
        ),
      ),
    );
  }
}
