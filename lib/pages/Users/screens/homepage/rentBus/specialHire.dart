import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oya_porter/components/alerts.dart';
import 'package:oya_porter/components/iosBottomSheet.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/Users/bloc/cngregationBloc.dart';
import 'package:oya_porter/pages/Users/bloc/destinationBloc.dart';
import 'package:oya_porter/pages/Users/bloc/featureBloc.dart';
import 'package:oya_porter/pages/Users/config/offlineData.dart';
import 'package:oya_porter/pages/Users/model/congrgationModel.dart';
import 'package:oya_porter/pages/Users/model/featuresModel.dart';
import 'package:oya_porter/pages/Users/model/sepcialDestinantionModel.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/colors.dart';

import 'widget/specialHireWidget.dart';

class SpecialHire extends StatefulWidget {
  @override
  _SpecialHireState createState() => _SpecialHireState();
}

class _SpecialHireState extends State<SpecialHire> {
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
  List<int> selectedFeaturesId = List<int>();
  List<String> selectedFeatures = List<String>();
  bool _isChecked = true;

  @override
  Widget build(BuildContext context) {
    setCurrentTime();

    return Scaffold(
      body: isLoading
          ? Center(child: CupertinoActivityIndicator())
          : specialHireBusWidget(
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
              rentBus: () => _onSpecialHireABus(
                cong: congregationID,
                destination: destinationID,
                secondName: secondaryNameController.text,
                secondPhone: secondaryPhoneController.text,
                pickDate: datePickController.text,
                pickUpTime: timePickController.text,
                returnTime: returnTimeController.text,
                numOfDays: numberOfDaysController.text,
                purpose: purposeController.text,
                pass: passengersController.text,
                features: featureID,
              ),
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
              onSelectTIme: () => selectTime(context, timePickController),
              onSelectReturnTime: () =>
                  selectTime(context, returnTimeController),
            ),
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
    loadCongregationOffline();
    return StreamBuilder<Object>(
      stream: destinationBloc.destinations,
      initialData: congregationMapOffline == null
          ? null
          : SepcialDestinantionModel.fromJson(congregationMapOffline),
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
        for (int x = 0; x < model.data.length; ++x) ...[
          Platform.isIOS
              ? CupertinoActionSheetAction(
                  child: Text('${model.data[x].name}',
                      style: TextStyle(color: BLACK)),
                  onPressed: () {
                    setState(() {
                      // _toCode = data.id;
                      featureID = (model.data[x].id).toString();
                      featuresController.text = model.data[x].name;
                      if (selectedFeaturesId.contains(int.parse(featureID))) {
                        print(x);
                        // selectedFeaturesId.removeAt(x);

                        toastContainer(text: "${model.data[x].name} removed");
                      } else {
                        selectedFeaturesId.add(int.parse(featureID));

                        selectedFeatures.add(model.data[x].name);
                        toastContainer(text: "${model.data[x].name} selected");
                      }
                    });

                    // Navigator.pop(context);
                  },
                )
              : SimpleDialogOption(
                  onPressed: () {
                    featureID = (model.data[x].id).toString();
                    featuresController.text = model.data[x].name;
                    print(x);

                    if (selectedFeaturesId.contains(int.parse(featureID))) {
                      selectedFeaturesId.removeWhere(
                          (element) => element == int.parse(featureID));
                      toastContainer(text: "${model.data[x].name} removed");
                    } else {
                      selectedFeaturesId.add(int.parse(featureID));

                      selectedFeatures.add(model.data[x].name);
                      toastContainer(text: "${model.data[x].name} selected");
                    }
                    // Navigator.pop(context);
                  },
                  child: Text("${model.data[x].name}",
                      style: TextStyle(fontSize: 20)),
                ),
          Divider(),
        ]
      ],
    );
  }

  TimeOfDay _currentTime = new TimeOfDay.now();
  String timeText = 'Set A Time';

  Future<Null> selectTime(
      BuildContext context, TextEditingController controller) async {
    TimeOfDay selectedTime = await showTimePicker(
      context: context,
      initialTime: _currentTime,
    );

    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    if (selectedTime != null) {
      String formattedTime = localizations.formatTimeOfDay(selectedTime,
          alwaysUse24HourFormat: false);
      if (formattedTime != null) {
        setState(() {
          timeText = formattedTime;
          controller.text = timeText;
        });
      }
    }
  }

  void setCurrentTime() {
    TimeOfDay selectedTime = new TimeOfDay.now();
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    String formattedTime = localizations.formatTimeOfDay(selectedTime,
        alwaysUse24HourFormat: false);
    if (formattedTime != null) {
      setState(() {
        timeText = formattedTime;
      });
    }
  }

  Widget allFeatures() {
    featuresBloc.fetchDestination(context);
    loadalFeatures();
    return StreamBuilder<Object>(
      stream: featuresBloc.features,
      initialData: featureMapOffline == null
          ? null
          : FeaturesModel.fromJson(featureMapOffline),
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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$title'),
                IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context))
              ],
            ),
            children: <Widget>[allFeatures()],
          );
        })) {
    }
  }

  _onSpecialHireABus(
      {cong,
      destination,
      secondName,
      secondPhone,
      pickDate,
      pickUpTime,
      returnTime,
      pass,
      numOfDays,
      purpose,
      features}) async {
    setState(() {
      isLoading = true;
    });
    print(secondPhone);
    final url = Uri.parse("$BASE_URL/account/special_hirings");
    try {
      Map<String, dynamic> body = {
        'congregation_id': '$cong',
        'special_destination_id': '$destination',
        'secondary_name': '$secondName',
        'secondary_phone': '$secondPhone',
        'pickup_date': '$pickDate',
        'pickup_time': '$pickUpTime',
        'return_time': '$returnTime',
        'passengers': '$pass',
        'purpose': '$purpose',
        'number_of_days': '$numOfDays',
        'selected_features': '$features'
      };
      final response = await http
          .post(url,
              headers: {
                "Authorization": "Bearer $accessToken",
                'Content-Type': 'application/json'
              },
              body: json.encode(body))
          .timeout(Duration(seconds: 50));

      print(response.body);

      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        final responseData = json.decode(response.body);
        if (responseData['status'] == 200) {
          toastContainer(text: responseData['message']);
          Navigator.pop(context);
        } else {
          toastContainer(text: responseData['message']);
        }
      } else if (response.statusCode == 401) {
        sessionExpired(context);
      } else {
        setState(() {
          isLoading = false;
        });
        toastContainer(text: "Error has occured");
      }
    } on TimeoutException catch (_) {
      setState(() {
        isLoading = false;
      });
      Platform.isIOS
          ? iosexceptionAlert(
              context: context,
              title: "Connection TimeOut",
              message: "Please check your connection and try again")
          : exceptionAlert(
              context: context,
              title: "Connection TimeOut",
              message: "Please check your connection and try again");
    } on SocketException catch (_) {
      setState(() {
        isLoading = false;
      });
      Platform.isIOS
          ? iosexceptionAlert(
              context: context,
              title: "No Internet connection",
              message: "Please connection to internet and try again",
            )
          : exceptionAlert(
              context: context,
              title: "No Internet connection",
              message: "Please connection to internet and try again",
            );
    } catch (f) {}
  }
}
