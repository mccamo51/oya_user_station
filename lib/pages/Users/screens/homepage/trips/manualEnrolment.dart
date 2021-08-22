import 'package:flutter/material.dart';
import 'package:oya_porter/spec/colors.dart';

import 'myTrips.dart';
import 'widgets/manuelEnrolmentWidget.dart';

class ManualEnrolment extends StatefulWidget {
  @override
  _ManualEnrolmentState createState() => _ManualEnrolmentState();
}

class _ManualEnrolmentState extends State<ManualEnrolment> {
  final _toController = TextEditingController();
  final _fromController = TextEditingController();
  final _dateController = TextEditingController();
  final _busNumberController = TextEditingController();

  FocusNode _toFocusNode, _fromFocusNode;

  initState() {
    super.initState();
    _toFocusNode = new FocusNode();
    _fromFocusNode = new FocusNode();
  }

  dispose() {
    super.dispose();
    _toFocusNode.dispose();
    _fromFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      appBar: AppBar(
        elevation: 0,
        title: Text('Manuel Enrolment'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.info_outline_rounded,
              color: Colors.red,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: manuelEnrolmentWidget(
        busNumberController: _busNumberController,
        dateController: _dateController,
        fromController: _fromController,
        fromFocusNode: _fromFocusNode,
        toController: _toController,
        toFocusNode: _toFocusNode,
        onBusNumber: () {},
        onDate: () {},
      ),
      bottomNavigationBar: manuelEnrolmentBottomWidget(
        onAddTrip: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => MyTrips()));
        },
        onCancel: () => Navigator.of(context).pop(),
      ),
    );
  }
}
