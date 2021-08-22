import 'package:flutter/material.dart';
import 'package:oya_porter/spec/colors.dart';

import 'summary.dart';
import 'widgets/passengerSelectionWidget.dart';

class PassengerSelection extends StatefulWidget {
  @override
  _PassengerSelectionState createState() => _PassengerSelectionState();
}

class _PassengerSelectionState extends State<PassengerSelection> {
  bool slide = false, slide2 = false;
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _seatAssignController = TextEditingController();
  final _fullNameController2 = TextEditingController();
  final _phoneController2 = TextEditingController();
  final _seatAssignController2 = TextEditingController();

  FocusNode _fullNameFocusNode,
      _phoneFocusNode,
      _seatAssignFocusNode,
      _fullNameFocusNode2,
      _phoneFocusNode2,
      _seatAssignFocusNode2;

  initState() {
    super.initState();
    _fullNameFocusNode = new FocusNode();
    _phoneFocusNode = new FocusNode();
    _seatAssignFocusNode = new FocusNode();
    _fullNameFocusNode2 = new FocusNode();
    _phoneFocusNode2 = new FocusNode();
    _seatAssignFocusNode2 = new FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _fullNameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _seatAssignFocusNode.dispose();
    _fullNameFocusNode2.dispose();
    _phoneFocusNode2.dispose();
    _seatAssignFocusNode2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      appBar: AppBar(
        elevation: 0,
        title: Text("Passenger Selection"),
      ),
      body: passengerSelectionWidget(
        context: context,
        slide: slide,
        fullNameController: _fullNameController,
        fullNameController2: _fullNameController2,
        fullNamefocusNode: _fullNameFocusNode,
        fullNamefocusNode2: _fullNameFocusNode2,
        onContinue: () => _onContinue(),
        onSlideChanges: (bool value) => setState(() => slide = value),
        onSlideChanges2: (bool value) => setState(() => slide2 = value),
        onSlidedTap: () => setState(() => slide = !slide),
        onSlidedTap2: () => setState(() => slide2 = !slide2),
        phoneController: _phoneController,
        phoneController2: _phoneController2,
        phonefocusNode: _phoneFocusNode,
        phonefocusNode2: _phoneFocusNode2,
        seatAssignController: _seatAssignController,
        seatAssignController2: _seatAssignController2,
        seatAssignfocusNode: _seatAssignFocusNode,
        seatAssignfocusNode2: _seatAssignFocusNode2,
        slide2: slide2,
      ),
    );
  }

  void _onContinue() {
    _fullNameFocusNode.unfocus();
    _phoneFocusNode.unfocus();
    _seatAssignFocusNode.unfocus();
    _fullNameFocusNode2.unfocus();
    _phoneFocusNode2.unfocus();
     Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Summary()));
  }
}
