import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/components/phoneNumberText.dart';
import 'emerg/emergencyContact.dart';
import 'registerWidgets/registerWidget.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  FocusNode firstNameFocusNode, lastNameFocusNode, phoneNumberFocusNode;

  @override
  void initState() {
    super.initState();
    firstNameFocusNode = new FocusNode();
    lastNameFocusNode = new FocusNode();
    phoneNumberFocusNode = new FocusNode();
  }

  dispose() {
    super.dispose();
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    phoneNumberFocusNode.dispose();
  }

  void unfocusAllNodes() {
    firstNameFocusNode.unfocus();
    lastNameFocusNode.unfocus();
    phoneNumberFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return registerWidget(
      context: context,
      phoneNumberController: phoneNumberController,
      onContinue: () {
        unfocusAllNodes();
        if (_formKey.currentState.validate())
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EmergencyContact(
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                phoneNumber: "+${countryCode + phoneNumberController.text}",
              ),
            ),
          );
      },
      phoneNumberFocusNode: phoneNumberFocusNode,
      formKey: _formKey,
      firstNameController: firstNameController,
      firstNameFocusNode: firstNameFocusNode,
      lastNameController: lastNameController,
      lastNameFocusNode: lastNameFocusNode,
    );
  }
}
