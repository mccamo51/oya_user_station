import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oya_porter/components/iosBottomSheet.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/Users/bloc/cngregationBloc.dart';
import 'package:oya_porter/pages/Users/bloc/destinationBloc.dart';
import 'package:oya_porter/pages/Users/bloc/featureBloc.dart';
import 'package:oya_porter/pages/Users/model/congrgationModel.dart';
import 'package:oya_porter/pages/Users/model/featuresModel.dart';
import 'package:oya_porter/pages/Users/model/sepcialDestinantionModel.dart';
import 'package:oya_porter/spec/colors.dart';

import 'widget/rentBusWidget.dart';

class RentBus extends StatefulWidget {
  @override
  _RentBusState createState() => _RentBusState();
}

class _RentBusState extends State<RentBus> {
  TextEditingController timePickController = TextEditingController();
  TextEditingController datePickController = TextEditingController();
  TextEditingController secondaryPhoneController = TextEditingController();
  TextEditingController secondaryNameController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController congregationController = TextEditingController();
  TextEditingController returnTimeController = TextEditingController();
  TextEditingController numberOfDaysController = TextEditingController();
  TextEditingController passengersController = TextEditingController();
  TextEditingController featuresController = TextEditingController();
  TextEditingController purposeController = TextEditingController();

  String congregationID, destinationID, featureID;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return rentBusWidget(
      context: context,
      congregationController: congregationController,
      datePickController: datePickController,
      destinationController: destinationController,
      featuresController: featuresController,
      numberOfDaysController: numberOfDaysController,
      passengersController: passengersController,
      purposeController: purposeController,
      returnTimeController: returnTimeController,
      secondaryNameController: secondaryNameController,
      secondaryPhoneController: secondaryPhoneController,
      timePickController: timePickController,
      rentBus: () => _onHireABus(),
      onSelectCongregation: () => androidSelectCongregation(
        context: context,
        title: "Select Congregation",
      ),
      onSelectDate: () => _onDate(datePickController, context),
      onSelectDestination: () => androidSelectDestination(
        context: context,
        title: "Select Destination",
      ),
      onSelectFeature: () => androidSelectFeatures(
        context: context,
        title: "Select Features",
      ),
      onSelectTIme: null,
      onSelectReturnTime: null,
    );
  }

  void _onDate(TextEditingController controller, BuildContext context) {
    DateTime dateTime = new DateTime.now();
    int day = dateTime.day;
    int month = dateTime.month;
    int year = dateTime.year;
    Platform.isIOS
        ? _iosDateofBirth(
            year: year,
            month: month,
            day: day,
            context: context,
            controller: controller,
          )
        : _androidDateofBirth(
            day: day,
            month: month,
            year: year,
            context: context,
            controller: controller,
          );
  }

  void _androidDateofBirth({
    @required int day,
    @required int month,
    @required int year,
    @required TextEditingController controller,
    @required BuildContext context,
  }) {
    showDatePicker(
      context: context,
      initialDate: DateTime(year, month, day),
      firstDate: DateTime(year, month, day),
      lastDate: DateTime(year + 100, 12, 31),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    ).then((value) {
      controller.text = "${value.year}-${value.month}-${value.day}";
    });
  }

  void _iosDateofBirth({
    @required int day,
    @required int month,
    @required int year,
    @required TextEditingController controller,
    @required BuildContext context,
  }) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return buildBottomPicker(
            DefaultTextStyle.merge(
              style: TextStyle(fontSize: 20),
              child: CupertinoDatePicker(
                minimumDate: DateTime(year, month, day),
                maximumDate: DateTime(year + 100, 12, 31),
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime(year, month, day),
                onDateTimeChanged: (DateTime dateTime) {
                  if (mounted) {
                    setState(() {
                      controller.text =
                          "${dateTime.year.toString()}-${dateTime.month.toString()}-${dateTime.day.toString()} ";
                    });
                  }
                },
              ),
            ),
          );
        });
  }

  Widget _mCong(CongrgationModel model, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var data in model.data) ...[
          Platform.isIOS
              ? CupertinoActionSheetAction(
                  child: Text('${data.name}', style: TextStyle(color: BLACK)),
                  onPressed: () {
                    setState(() {
                      // _toCode = data.id;
                      congregationID = (data.id).toString();
                      congregationController.text = data.name;
                    });

                    Navigator.pop(context);
                  },
                )
              : SimpleDialogOption(
                  onPressed: () {
                    congregationID = (data.id).toString();
                    congregationController.text = data.name;
                    Navigator.pop(context);
                  },
                  child: Text("${data.name}", style: TextStyle(fontSize: 20)),
                ),
          Divider(),
        ]
      ],
    );
  }

  Widget allCongregation() {
    congregationBloc.fetchCongregation(context);

    return StreamBuilder<Object>(
      stream: congregationBloc.congregation,
      // initialData: busTypeModelMapOffline == null
      //     ? null
      //     : BusTypeModel.fromJson(busTypeModelMapOffline),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return _mCong(snapshot.data, context);
        } else if (snapshot.hasError) {
          return Text("Error");
        }
        return Center(child: CupertinoActivityIndicator(radius: 15));
      },
    );
  }

  Future<void> androidSelectCongregation(
      {String title, BuildContext context}) async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('$title'),
            children: <Widget>[allCongregation()],
          );
        })) {
    }
  }

  Widget _mDestination(SepcialDestinantionModel model, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var data in model.data) ...[
          Platform.isIOS
              ? CupertinoActionSheetAction(
                  child: Text('${data.name}', style: TextStyle(color: BLACK)),
                  onPressed: () {
                    setState(() {
                      // _toCode = data.id;
                      destinationID = (data.id).toString();
                      destinationController.text = data.name;
                    });

                    Navigator.pop(context);
                  },
                )
              : SimpleDialogOption(
                  onPressed: () {
                    destinationID = (data.id).toString();
                    destinationController.text = data.name;
                    Navigator.pop(context);
                  },
                  child: Text("${data.name}", style: TextStyle(fontSize: 20)),
                ),
          Divider(),
        ]
      ],
    );
  }

  Widget allDestination() {
    destinationBloc.fetchDestination(context);

    return StreamBuilder<Object>(
      stream: destinationBloc.destinations,
      // initialData: busTypeModelMapOffline == null
      //     ? null
      //     : BusTypeModel.fromJson(busTypeModelMapOffline),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return _mDestination(snapshot.data, context);
        } else if (snapshot.hasError) {
          return Text("Error");
        }
        return Center(child: CupertinoActivityIndicator(radius: 15));
      },
    );
  }

  Future<void> androidSelectDestination(
      {String title, BuildContext context}) async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('$title'),
            children: <Widget>[allDestination()],
          );
        })) {
    }
  }

  Widget _mFeatures(FeaturesModel model, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var data in model.data) ...[
          Platform.isIOS
              ? CupertinoActionSheetAction(
                  child: Text('${data.name}', style: TextStyle(color: BLACK)),
                  onPressed: () {
                    setState(() {
                      // _toCode = data.id;
                      featureID = (data.id).toString();
                      featuresController.text = data.name;
                    });

                    Navigator.pop(context);
                  },
                )
              : SimpleDialogOption(
                  onPressed: () {
                    featureID = (data.id).toString();
                    featuresController.text = data.name;
                    Navigator.pop(context);
                  },
                  child: Text("${data.name}", style: TextStyle(fontSize: 20)),
                ),
          Divider(),
        ]
      ],
    );
  }

  Widget allFeatures() {
    featuresBloc.fetchDestination(context);

    return StreamBuilder<Object>(
      stream: featuresBloc.features,
      // initialData: busTypeModelMapOffline == null
      //     ? null
      //     : BusTypeModel.fromJson(busTypeModelMapOffline),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return _mFeatures(snapshot.data, context);
        } else if (snapshot.hasError) {
          return Text("Error");
        }
        return Center(child: CupertinoActivityIndicator(radius: 15));
      },
    );
  }

  Future<void> androidSelectFeatures(
      {String title, BuildContext context}) async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('$title'),
            children: <Widget>[allFeatures()],
          );
        })) {
    }
  }

  _onHireABus() async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> body = {
      'pickup_time': '',
      'departure_date': '',
      'return_date': '',
      'hiring_type': '',
      'region_from_id': '',
      'town_from_id': '',
      'region_to_id': '',
      'town_to_id': '',
      'purpose_choice': '',
      'passenger_range': ''
    };
    final url = Uri.parse("$BASE_URL/account/hirings");
    final response = await http
        .post(url, body: json.encode(body))
        .timeout(Duration(seconds: 50));

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      final responseData = json.decode(response.body);
      if (responseData['status'] == 200) {
        toastContainer(text: responseData['message']);
      } else {
        toastContainer(text: responseData['message']);
      }
    }
  }
}
