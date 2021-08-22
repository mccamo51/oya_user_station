import 'dart:async';
import 'dart:convert';
import 'dart:io';
// import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:oya_porter/components/emptyBox.dart';
import 'package:oya_porter/components/iosBottomSheet.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/checkConnection.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/Users/bloc/ticketFromBloc.dart';
import 'package:oya_porter/pages/Users/bloc/ticketToBloc.dart';
import 'package:oya_porter/pages/Users/config/offlineData.dart';
import 'package:oya_porter/pages/Users/model/ticketFromModel.dart';
import 'package:oya_porter/pages/Users/model/ticketToModel.dart';
import 'package:oya_porter/pages/Users/provider/ticketToProvider.dart';
import 'package:oya_porter/pages/Users/screens/homepage/homeMap/newHome.dart';
import 'package:oya_porter/pages/Users/screens/homepage/ticket/busSelection.dart';
import 'package:oya_porter/pages/Users/screens/homepage/ticket/widgets/ticketWidget.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/strings.dart';
import 'package:oya_porter/spec/styles.dart';

import 'menuPage.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();
  // String _darkMapStyle;
  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();

  // String _startAddress = '';
  // String _destinationAddress = '';
  // // String _placeDistance;
  // var fromLong, fromLat;

  // Set<Marker> markers = {};

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool _internet = false;
  bool _isLoading = false;
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  final _dateController = TextEditingController();
  int _fromCode, _toCode;
  @override
  void initState() {
    super.initState();
    checkInternet();
    loadTicketFromOffline();
    ticketFromBloc.fetchTicketFrom(context);
  }

  Future<void> checkInternet() async {
    await checkConnection().then((value) => setState(() => _internet = value));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            SvgPicture.asset("assets/images/admin/traveller.svg"),
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: .0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    width: width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Buy a Ticket',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          SizedBox(height: 3),
                          _internet
                              ? ticketFromFuture()
                              : ticketFromMapOffline == null
                                  ? Container(
                                      height: 0,
                                      width: 0,
                                    )
                                  : loopTicketFrom(
                                      TicketFromModel.fromJson(
                                          ticketFromMapOffline),
                                    ),
                          OutlineButton(
                            onPressed: () => _onBuyTicket(context),
                            child: Text("Buy Ticket"),
                            borderSide: BorderSide(color: PRIMARYCOLOR),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SafeArea(
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 55.0),
                      child: Text(
                        "Where are you travelling \nto?",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25),
                      ),
                    ))),
            // Show current location button

            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                  child: ClipOval(
                    child: Material(
                      // color: Colors.orange[100], // button color
                      child: InkWell(
                        splashColor: Colors.orange, // inkwell color
                        child: SizedBox(
                          width: 56,
                          height: 56,
                          child: Icon(Icons.menu),
                        ),
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                            new CupertinoPageRoute<bool>(
                                fullscreenDialog: true,
                                builder: (BuildContext context) => ItemMenu1(isStaff: isStaff,)),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget loopTicketFrom(TicketFromModel model) {
    return Stack(
      children: [
        ticketContactWidget(
          context: context,
          onCreate: () => _onBuyTicket(context),
          onDate: _onDate,
          dateController: _dateController,
          fromController: _fromController,
          fromTap: () async {
            setState(() {
              _toCode = null;
              _toController.clear();
              ticketToMapOffline = null;
            });
            Platform.isIOS ? _iosSelectFrom(model) : _androidSelectFrom(model);
          },
          toController: _toController,
          toTap: () {
            if (_fromCode == null)
              toastContainer(
                text: "Select where you are travelling from",
                backgroundColor: RED,
              );
            else {
              Platform.isIOS ? _iosSelectTo() : _androidSelectTo();
            }
          },
          formKey: _formKey,
        ),
        if (_isLoading)
          Align(
            alignment: Alignment.center,
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          ),
      ],
    );
  }

  Future<void> _onBuyTicket(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      setState(() => _isLoading = true);
      try {
        final url = Uri.parse("$AVALIABLEBUSES_URL");
        Map<String, dynamic> body = {
          "departure": "${_dateController.text}",
          "from": _fromCode.toString(),
          "to": _toCode.toString(),
        };
        final response = await http
            .post(
              url,
              headers: {
                "Authorization": "Bearer $accessToken",
                'Content-Type': 'application/json'
              },
              body: json.encode(body),
            )
            .timeout(Duration(seconds: 50));
        print(response.statusCode);
        if (response.statusCode == 200) {
          setState(() => _isLoading = false);
          if (response.body != null &&
              json.decode(response.body)["data"].length > 0) {
            Navigator.of(context, rootNavigator: true).push(
              new CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (context) {
                  return BusSelection(buses: json.decode(response.body));
                },
              ),
            );
          } else {
            toastContainer(
              text: "No bus available",
              backgroundColor: RED,
            );
          }
        } else {
          setState(() {
            _isLoading = false;
          });
          toastContainer(
            text: "Error occured. Please try again...",
            backgroundColor: RED,
          );
        }
      } on TimeoutException catch (_) {
        setState(() {
          _isLoading = false;
        });
        toastContainer(
          text: CONNECTIONTIMEOUT,
          backgroundColor: RED,
        );
      } on SocketException catch (s) {
        setState(() {
          _isLoading = false;
        });
        print(s);
        toastContainer(
          text: INTERNETCONNECTIONPROBLEM,
          backgroundColor: RED,
        );
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        print(e);
        toastContainer(
          text: "Error occured. Please try again...$e",
          backgroundColor: RED,
        );
      }
    }
  }

  void _onDate() {
    DateTime dateTime = new DateTime.now();
    int day = dateTime.day;
    int month = dateTime.month;
    int year = dateTime.year;
    Platform.isIOS
        ? _iosDateofBirth(year: year, month: month, day: day)
        : _androidDateofBirth(day: day, month: month, year: year);
  }

  void _androidDateofBirth({
    @required int day,
    @required int month,
    @required int year,
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
      _dateController.text = "${value.year}-${value.month}-${value.day}";
    });
  }

  void _iosDateofBirth({
    @required int day,
    @required int month,
    @required int year,
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
                      _dateController.text =
                          "${dateTime.year.toString()}-${dateTime.month.toString()}-${dateTime.day.toString()} ";
                    });
                  }
                },
              ),
            ),
          );
        });
  }

  Future<void> _iosSelectTo() async {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text('Select where you are travelling to'),
          actions: <Widget>[ticketToFuture()],
        );
      },
    );
  }

  //
  Future<void> _androidSelectTo() async {
    switch (await showDialog<Object>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select where you are travelling to',
                style: h5Black),
            children: <Widget>[ticketToFuture()],
          );
        })) {
    }
  }

  Widget ticketToFuture() {
    print("$_fromCode");
    ticketToBloc.fetchTicketTo(_fromCode, context);
    return StreamBuilder<Object>(
      stream: ticketToBloc.ticketTo,
      initialData: ticketToMapOffline == null
          ? null
          : TicketToModel.fromJson(ticketToMapOffline),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return _m(snapshot.data, context);
        } else if (snapshot.hasError) {
          return emptyBox(context);
        }
        return Center(child: CupertinoActivityIndicator(radius: 15));
      },
    );
  }

  Widget _m(TicketToModel model, BuildContext context) {
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
                      _toCode = data.id;
                      _toController.text = data.name;
                    });
                    Navigator.pop(context);
                  },
                )
              : SimpleDialogOption(
                  onPressed: () {
                    setState(() {
                      _toCode = data.id;
                      _toController.text = data.name;
                    });

                    Navigator.pop(context);
                  },
                  child: Text(data.name, style: TextStyle(fontSize: 20)),
                ),
          Divider(),
        ]
      ],
    );
  }

  Future<void> _iosSelectFrom(TicketFromModel model) async {
    // double _originLatitude = 5.562947067618004,
    //     _originLongitude = -0.22508729249238968;
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text('Select where you travelling from'),
          actions: <Widget>[
            for (var data in model.data)
              CupertinoActionSheetAction(
                child: Text('${data.name}', style: TextStyle(color: BLACK)),
                onPressed: () {
                  setState(() {
                    _fromCode = data.id;
                    _fromController.text = data.name;
                  });

                  Navigator.of(context).pop();
                },
              )
          ],
        );
      },
    );
  }

  Future<void> _androidSelectFrom(TicketFromModel model) async {
    // double _originLatitude = 5.562947067618004,
    //     _originLongitude = -0.22508729249238968;
    switch (await showDialog<TicketFromModel>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title:
                const Text('Select where you travelling from', style: h5Black),
            children: <Widget>[
              for (var data in model.data) ...[
                SimpleDialogOption(
                  onPressed: () {
                    _fromCode = data.id;
                    _fromController.text = data.name;

                    Navigator.pop(context);
                  },
                  child: Text(data.name, style: TextStyle(fontSize: 20)),
                ),
                Divider(),
              ]
            ],
          );
        })) {
    }
  }

  Widget ticketFromFuture() {
    return StreamBuilder<Object>(
      stream: ticketFromBloc.ticketFrom,
      initialData: ticketFromMapOffline == null
          ? null
          : TicketFromModel.fromJson(ticketFromMapOffline),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return loopTicketFrom(snapshot.data);
        } else if (snapshot.hasError) {
          return emptyBox(context);
        }
        return Center(child: CupertinoActivityIndicator(radius: 15));
      },
    );
  }
}
