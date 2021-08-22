import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/components/alerts.dart';
import 'package:oya_porter/components/phoneNumberText.dart';
import 'package:oya_porter/pages/Users/screens/auth/register/secureAccount/secure.dart';
import 'widgets/emergencyWidget.dart';

class EmergencyContact extends StatefulWidget {
  final String firstName, lastName, phoneNumber;

  EmergencyContact({
    @required this.firstName,
    @required this.lastName,
    @required this.phoneNumber,
  });

  @override
  _EmergencyContactState createState() => _EmergencyContactState();
}

class _EmergencyContactState extends State<EmergencyContact> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final primaryContactController = TextEditingController();
  final secondaryContactController = TextEditingController();

  FocusNode primaryContactFocusNode, secondaryContactFocusNode;

  initState() {
    super.initState();
    primaryContactFocusNode = new FocusNode();
    secondaryContactFocusNode = new FocusNode();
  }

  dispose() {
    super.dispose();
    primaryContactFocusNode.dispose();
    secondaryContactFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return emergencyContactWidget(
      context: context,
      primaryContactController: primaryContactController,
      secondaryContactController: secondaryContactController,
      onCreate: () {
        primaryContactFocusNode.unfocus();
        secondaryContactFocusNode.unfocus();
        if (_formKey.currentState.validate())
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SecureAccount(
                firstName: widget.firstName,
                ice1: "+${countryCode + primaryContactController.text}",
                ice2: "+${countryCode + secondaryContactController.text}",
                lastName: widget.lastName,
                phoneNumber: widget.phoneNumber,
              ),
            ),
          );
      },
      onShowDialog: () => iceAlert(
          context, "Your ICE contact is needed for a variety of reasons."),
      formKey: _formKey,
      primaryContactFocusNode: primaryContactFocusNode,
      secondaryContactFocusNode: secondaryContactFocusNode,
    );
  }
}
