import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oya_porter/components/buttons.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/Users/model/busSeatsModel.dart';
import 'package:oya_porter/pages/Users/screens/homepage/ticket/seatSelection.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/styles.dart';

class OtherPassenger extends StatefulWidget {
  @override
  _OtherPassengerState createState() => _OtherPassengerState();
}

class _OtherPassengerState extends State<OtherPassenger> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final TextEditingController primaryIceNumberController =
      TextEditingController();
  final TextEditingController minorController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode minorFocusNode = FocusNode();
  final FocusNode primaryIceNumberFocusNode = FocusNode();
  bool isExist = false;

  Future<void> _checkIfPassesngerExist(String number) async {
    print(number);
    var url = Uri.parse("$BASE_URL/search/users?needle=$number");
    final response = await http.get(url, headers: {
      "Authorization": "Bearer $accessToken",
      'Content-Type': 'application/json'
    });
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['status'] == 200) {
        print(number);

        setState(() {
          isExist = false;
        });
      } else {
        setState(() {
          isExist = true;
        });
      }
    } else {
      setState(() {
        isExist = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: isExist ? 350 : 220,
        width: double.infinity,
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Enter person's name and phone number to continue",
                  style: h3Black,
                ),
                textFormField(
                  controller: phoneController,
                  focusNode: phoneFocusNode,
                  hintText: "Enter phone",
                  labelText: "Phone",
                  validateMsg: "Enter phone",
                  inputType: TextInputType.phone,
                ),
                SizedBox(height: 10),
                textFormField(
                  controller: minorController,
                  focusNode: minorFocusNode,
                  hintText: "Enter Minor",
                  labelText: "Minor",
                  inputType: TextInputType.phone,
                  validate: false,
                ),
                SizedBox(height: 10),
                Visibility(
                  visible: isExist,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      textFormField(
                          controller: nameController,
                          focusNode: nameFocusNode,
                          hintText: "Enter name",
                          labelText: "Name",
                          validateMsg: "Enter name"),
                      SizedBox(height: 10),
                      textFormField(
                        controller: primaryIceNumberController,
                        focusNode: primaryIceNumberFocusNode,
                        hintText: "Enter primary ice number",
                        labelText: "Primary ice number",
                        validate: false,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: primaryButton(
                      onFunction: () {
                        // setState(() {
                        //   isExist = !isExist;
                        // });
                        toastContainer(text: "Please wait.....");
                        nameFocusNode.unfocus();
                        phoneFocusNode.unfocus();
                        primaryIceNumberFocusNode.unfocus();
                        if (formKey.currentState.validate()) {
                          _checkIfPassesngerExist(phoneController.text)
                              .whenComplete(() {
                            if (isExist) {
                              if (nameController.text.isEmpty) {
                                toastContainer(text: "Name is required");
                              } else {
                                setState(() {
                                  otherPassanger.add(
                                    {
                                      "name": nameController.text.isEmpty
                                          ? ""
                                          : "${nameController.text}",
                                      "phone": "${phoneController.text}",
                                      "seat_id":
                                          "${seatSelectedId[seatSelectedId.length - 1]}",
                                      "ice1_phone": primaryIceNumberController
                                              .text.isEmpty
                                          ? ""
                                          : "${primaryIceNumberController.text}",
                                      "pay": "1",
                                      "parent": otherPassanger.length == 0
                                          ? "1"
                                          : "0",
                                      "minor_count": minorController.text
                                    },
                                  );
                                  seatSelectedIdTemp.add(seatSelectedId[
                                      seatSelectedId.length - 1]);
                                  setSetSelectionTemp(seatSelectedIdTemp);
                                });
                                toastContainer(
                                  text: "Passenger added successfully...",
                                  backgroundColor: PRIMARYCOLOR,
                                );
                                Navigator.of(context).pop();
                              }
                            } else {
                              if (formKey.currentState.validate()) {
                                setState(() {
                                  otherPassanger.add(
                                    {
                                      "name": "",
                                      "phone": "${phoneController.text}",
                                      "seat_id":
                                          "${seatSelectedId[seatSelectedId.length - 1]}",
                                      "ice1_phone": "",
                                      "pay": "1",
                                      "parent": otherPassanger.length == 0
                                          ? "1"
                                          : "0",
                                      "minor_count": minorController.text
                                    },
                                  );
                                  seatSelectedIdTemp.add(seatSelectedId[
                                      seatSelectedId.length - 1]);
                                  setSetSelectionTemp(seatSelectedIdTemp);
                                });
                                toastContainer(
                                  text: "Passenger added successfully...",
                                  backgroundColor: PRIMARYCOLOR,
                                );
                                Navigator.of(context).pop();
                              }
                            }
                          });
                        }
                      },
                      title: "Add"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget otherPassengerFormDialog({
//   final TextEditingController nameController,
//   final TextEditingController phoneController,
//   final TextEditingController primaryIceNumberController,
//   final TextEditingController minorController,
//   final FocusNode nameFocusNode,
//   final FocusNode phoneFocusNode,
//   final FocusNode primaryIceNumberFocusNode,
//   final void Function() onAdd,
//   final Key key,
//   final bool isExist = true,
// }) {
//   return StatefulBuilder(
//     builder: (context, setState) {},
//   );
// }
