import 'package:flutter/material.dart';
import 'package:oya_porter/pages/Users/screens/homepage/rentBus/travellers/travellers.dart';

import 'widgets/rentBusWidget.dart';

class RentBusForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return rentBusFormWidget(
      context: context,
      lastNameController: null,
      firstNameController: null,
      onContinue: () => _continue(context),
      phoneNumberController: null,
    );
  }
}

_continue(BuildContext context) {
  Navigator.push(context,
      MaterialPageRoute(builder: (BuildContext context) => TravellersForm()));
}
