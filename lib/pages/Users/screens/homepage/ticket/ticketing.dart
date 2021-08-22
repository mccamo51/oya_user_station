import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oya_porter/components/alerts.dart';
import 'package:oya_porter/components/customLoading.dart';
import 'package:oya_porter/components/emptyBox.dart';
import 'package:oya_porter/components/iosBottomSheet.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/checkConnection.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/Users/bloc/ticketFromBloc.dart';
import 'package:oya_porter/pages/Users/bloc/ticketToBloc.dart';
import 'package:oya_porter/pages/Users/config/offlineData.dart';
import 'package:oya_porter/pages/Users/model/ticketFromModel.dart';
import 'package:oya_porter/pages/Users/model/ticketToModel.dart';
import 'package:oya_porter/pages/Users/provider/ticketToProvider.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/strings.dart';
import 'package:oya_porter/spec/styles.dart';

import 'busSelection.dart';
import 'widgets/ticketWidget.dart';

class Ticketing extends StatefulWidget {
  @override
  _TicketingState createState() => _TicketingState();
}

class _TicketingState extends State<Ticketing> {
  bool _isLoading = false, _internet = false;
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  final _dateController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    return Scaffold(
      backgroundColor: WHITE,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Buy a Ticket",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.info_outline_rounded,
              color: Colors.red,
            ),
            onPressed: () => iceAlert(
              context,
              "You may buy a ticket by completing this form, or enrol on a bus on the trips page with an existing ticket.",
            ),
          ),
        ],
      ),
      body: _internet
          ? ticketFromFuture()
          : ticketFromMapOffline == null
              ? emptyBox(context, msg: INTERNETCONNECTIONPROBLEM)
              : loopTicketFrom(
                  TicketFromModel.fromJson(ticketFromMapOffline),
                ),
    );
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
        if (_isLoading) customLoadingPage(),
      ],
    );
  }

  Future<void> _onBuyTicket(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      setState(() => _isLoading = true);
      final url = Uri.parse("$AVALIABLEBUSES_URL");
      try {
        final response = await http
            .post(url,
                headers: {
                  "Authorization": "Bearer $accessToken",
                  'Content-Type': 'application/json'
                },
                body: json.encode({
                  "departure": "${_dateController.text}",
                  "from": _fromCode.toString(),
                  "to": _toCode.toString(),
                }))
            .timeout(Duration(seconds: 50));
        if (response.statusCode == 200) {
          print(response.body);
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
        } else if (response.statusCode == 401) {
          sessionExpired(context);
        } else {
          print(response.body);
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
                    _toCode = data.id;
                    _toController.text = data.name;
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
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text('Select where you are travelling from'),
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
    switch (await showDialog<TicketFromModel>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select where you are travelling from',
                style: h5Black),
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
}
