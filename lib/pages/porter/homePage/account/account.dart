import 'package:flutter/material.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/pages/auth/login/login.dart';

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
            Text("Name"),
            textFormField(
                hintText: "$userName",
                controller: null,
                focusNode: null,
                enable: false,
                labelText: "$userName"),
            SizedBox(
              height: 10,
            ),
            Text("Phone"),
            textFormField(
              hintText: "$userphone",
              controller: null,
              focusNode: null,
              enable: false,
            ),
            SizedBox(
              height: 10,
            ),
            Text("Primary ICE Phone Number"),
            textFormField(
                hintText: "$userICE1",
                controller: null,
                focusNode: null,
                enable: false),
            SizedBox(
              height: 10,
            ),
            Text("Secondary ICE Phone Number"),
            textFormField(
                hintText: "$userICE2",
                controller: null,
                focusNode: null,
                enable: false),
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
