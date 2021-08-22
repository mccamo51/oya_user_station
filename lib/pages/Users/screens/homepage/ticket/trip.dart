import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/components/emptyBox.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/pages/Users/bloc/pickupPointBloc.dart';
import 'package:oya_porter/pages/Users/model/pickupPointModel.dart';
import 'package:oya_porter/pages/Users/screens/homepage/ticket/summary.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/styles.dart';


enum _TripSelection { Station, Enroute }
_TripSelection _character = _TripSelection.Station;

Map<String, dynamic> pickupMapOffline;

class Trip extends StatefulWidget {
  final bool mySelf;
  final List<int> seatId;
  final String busId,
      price,
      seatsSelected,
      selectedBusModel,
      tripDate,
      tripTime,
      route,
      station;
  final List<Map<String, dynamic>> otherPassanger;

  Trip({
    @required this.seatId,
    @required this.busId,
    @required this.price,
    @required this.seatsSelected,
    @required this.selectedBusModel,
    @required this.tripDate,
    @required this.tripTime,
    @required this.route,
    @required this.station,
    @required this.mySelf,
    @required this.otherPassanger,
  });

  @override
  _TripState createState() => _TripState();
}

class _TripState extends State<Trip> {
  final pickupController = TextEditingController();
  final minorController = TextEditingController(text: "0");
  String pickupId = '0';

  FocusNode minorFocusNode;

  initState() {
    super.initState();
    pickupMapOffline = null;
    minorFocusNode = FocusNode();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      appBar: AppBar(
        elevation: 0,
        title: Text("Trip"),
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
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Where are you joining the bus?", style: h3Black),
              SizedBox(height: 10),
              ListTile(
                title: const Text('Station', style: h3Black),
                leading: Radio(
                  activeColor: PRIMARYCOLOR,
                  value: _TripSelection.Station,
                  groupValue: _character,
                  onChanged: (_TripSelection value) {
                    setState(() {
                      _character = value;
                      pickupId = "0";
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              ListTile(
                title: const Text('Mid-Route', style: h3Black),
                leading: Radio(
                  activeColor: PRIMARYCOLOR,
                  value: _TripSelection.Enroute,
                  groupValue: _character,
                  onChanged: (_TripSelection value) {
                    setState(() {
                      _character = value;
                      pickupController.clear();
                      pickupId = "";
                    });
                  },
                ),
              ),
              if (_character == _TripSelection.Enroute) ...[
                SizedBox(height: 15),
                GestureDetector(
                  onTap: _onPickupPoint,
                  child: textFormField(
                    removeBorder: true,
                    controller: pickupController,
                    focusNode: null,
                    hintText: "Pickup Point",
                    labelText: "Pickup Point",
                    enable: false,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        child: ButtonTheme(
          minWidth: 500,
          height: 40,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: PRIMARYCOLOR),
          ),
          child: FlatButton(
            onPressed: () {
              if (pickupId != "")
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => PassengerSelection()));
                _onInputMinor();
              else
                toastContainer(
                  text: "No pickup selected",
                  backgroundColor: RED,
                );
            },
            child: Text("Continue", style: h4Button),
            textColor: PRIMARYCOLOR,
          ),
        ),
      ),
    );
  }

  void _onInputMinor() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Minor'),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Enter total number of minors"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textFormField(
              controller: minorController,
              focusNode: minorFocusNode,
              hintText: "Total minor number",
              labelText: "Total minor number",
              inputType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonTheme(
                  minWidth: 100,
                  height: 40,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: PRIMARYCOLOR),
                  ),
                  child: FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("Cancel", style: h4Button),
                    textColor: PRIMARYCOLOR,
                  ),
                ),
                ButtonTheme(
                  minWidth: 100,
                  height: 40,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: PRIMARYCOLOR),
                  ),
                  child: FlatButton(
                    onPressed: () {
                      minorFocusNode.unfocus();
                      if (minorController.text == null ||
                          minorController.text == "")
                        toastContainer(
                            text:
                                "Enter minor number else enter '0' if no minor");
                      else
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Summary(
                              pickupPointId: pickupId,
                              pickupPointName: pickupId == "0"
                                  ? widget.station
                                  : pickupController.text,
                              price: widget.price,
                              seatsSelected: widget.seatsSelected,
                              selectedBusId: widget.busId,
                              selectedBusModel: widget.selectedBusModel,
                              tripDate: widget.tripDate,
                              tripTime: widget.tripTime,
                              seatId: widget.seatId,
                              route: widget.route,
                              minor: minorController.text,
                              mySelf: widget.mySelf,
                              otherPassanger: widget.otherPassanger,
                              insurancePolicyId: '',
                            ),
                          ),
                        );
                    },
                    child: Text("Continue", style: h4Button),
                    textColor: WHITE,
                    color: PRIMARYCOLOR,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onPickupPoint() {
    Platform.isIOS ? _iosSelectPickup() : _androidSelectPickup();
  }

  Future<void> _iosSelectPickup() async {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text('Select your pickup point'),
          actions: <Widget>[pickupFuture()],
        );
      },
    );
  }

  Future<void> _androidSelectPickup() async {
    switch (await showDialog<Object>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select your pickup point', style: h5Black),
            children: <Widget>[pickupFuture()],
          );
        })) {
    }
  }

  Widget pickupFuture() {
    pickupPointBloc.fetchPickupPoint(widget.busId, context);
    // pickupPointBloc.fetchPickupPoint("1");
    return StreamBuilder<Object>(
      stream: pickupPointBloc.pickupPoint,
      initialData: pickupMapOffline == null
          ? null
          : PickupPointModel.fromJson(pickupMapOffline),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.data == null) return emptyBox(context);
          return _m(snapshot.data);
        } else if (snapshot.hasError) {
          return emptyBox(context);
        }
        return Center(child: CupertinoActivityIndicator(radius: 15));
      },
    );
  }

  Widget _m(PickupPointModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var data in model.data) ...[
          Platform.isIOS
              ? ListTile(
                  title: Text('${data.name}', style: TextStyle(color: BLACK)),
                  onTap: () {
                    setState(() {
                      pickupId = data.id.toString();
                      pickupController.text = data.name;
                    });
                    Navigator.of(context).pop();
                  },
                )
              : ListTile(
                  onTap: () {
                    pickupId = data.id.toString();
                    pickupController.text = data.name;
                    Navigator.pop(context);
                  },
                  title: Text(data.name, style: TextStyle(fontSize: 20)),
                ),
          Divider(),
        ]
      ],
    );
  }
}
