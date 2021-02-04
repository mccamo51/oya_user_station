import 'package:flutter/material.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/textField.dart';

class AddStaff extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Add New Staff"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: textFormField(
                hintText: "Enter phone number to search",
                controller: null,
                focusNode: null,
                inputType: TextInputType.phone,
                labelText: "Search"),
          )
        ],
      ),
      
    );
  }
}
