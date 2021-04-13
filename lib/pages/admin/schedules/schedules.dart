import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oya_porter/bloc/busesBloc.dart';
import 'package:oya_porter/bloc/conductorBloc.dart';
import 'package:oya_porter/bloc/driverBloc.dart';
import 'package:oya_porter/bloc/myRouteBloc.dart';
import 'package:oya_porter/bloc/porterBloc.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/buttons.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/offlineData.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/models/PorterModel.dart';
import 'package:oya_porter/models/busModel.dart';
import 'package:oya_porter/models/conductorModel.dart';
import 'package:oya_porter/models/driverModel.dart';
import 'package:oya_porter/models/myRouteModel.dart';
import 'package:oya_porter/pages/admin/schedules/widgets/seachWidgetBus.dart';
import 'package:oya_porter/pages/admin/schedules/widgets/searchConductor.dart';
import 'package:oya_porter/pages/admin/schedules/widgets/searchDriver.dart';
import 'package:oya_porter/pages/admin/schedules/widgets/searchPorter.dart';
import 'package:oya_porter/pages/admin/schedules/widgets/searchRoute.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:http/http.dart' as http;

enum SelectPriority { PRIORITY, NOTPRI }
enum SelectTicket { YesTick, NoTick }
enum SelectBoarding { YesBoard, NoBoard }
SelectPriority _character = SelectPriority.NOTPRI;
SelectTicket _characterT = SelectTicket.NoTick;
SelectBoarding _characterB = SelectBoarding.NoBoard;

class Schedules extends StatefulWidget {
  @override
  _SchedulesState createState() => _SchedulesState();
}

class _SchedulesState extends State<Schedules> {
  String driverId, conductorId, porterId;
  // TextEditingController conductorController = TextEditingController();
  // TextEditingController porterController = TextEditingController();
  TextEditingController arrivalDateTimeController = TextEditingController();
  TextEditingController deptimeDateController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  int priority = 0, board = 0, ticket = 0;
  String _searchText = "";

  bool isLoading = false;

  var pickedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  String _setTime, _setDate;

  String _hour, _minute, _time;

  String dateTime;
  @override
  Widget build(BuildContext context) {
    setCurrentTime();
    return Scaffold(
      appBar: appBar(
        title: ("Schedules"),
      ),
      body: isLoading
          ? Center(child: CupertinoActivityIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => androidSelectRoute(
                        context: context,
                      ),
                      child: textFormField(
                        hintText: "Select Route",
                        controller: routeController,
                        focusNode: null,
                        icon: Icons.arrow_drop_down,
                        enable: false,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () => androidSelectBus(
                        context: context,
                      ),
                      child: textFormField(
                        hintText: "Select Bus",
                        controller: busController,
                        focusNode: null,
                        icon: Icons.arrow_drop_down,
                        enable: false,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () => androidSelectDriver(context: context),
                      child: textFormField(
                        hintText: "Select Driver",
                        controller: driverController,
                        focusNode: null,
                        icon: Icons.arrow_drop_down,
                        enable: false,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () => androidSelectConductor(
                          context: context, title: "Select Conductor"),
                      child: textFormField(
                        hintText: "Select Conductor",
                        controller: conductorController,
                        focusNode: null,
                        icon: Icons.arrow_drop_down,
                        enable: false,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () => androidSelectPorter(
                          context: context, title: "Select Porter"),
                      child: textFormField(
                        hintText: "Select Porter",
                        controller: porterController,
                        focusNode: null,
                        icon: Icons.arrow_drop_down,
                        enable: false,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () => _pickDate(),
                      child: textFormField(
                        hintText: "Departure Date",
                        controller: deptimeDateController,
                        focusNode: null,
                        icon: Icons.arrow_drop_down,
                        enable: false,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () => selectTime(
                        context,
                        arrivalDateTimeController,
                      ),
                      child: textFormField(
                        hintText: "Departure Time",
                        controller: arrivalDateTimeController,
                        focusNode: null,
                        icon: Icons.arrow_drop_down,
                        enable: false,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: textFormField(
                        hintText: "Ticket Price",
                        controller: priceController,
                        focusNode: null,
                        labelText: "Ticket Price",
                        inputType: TextInputType.number,
                        // icon: Icons.arrow_drop_down,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Is this a Priority BUS?"),
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Radio(
                                  activeColor: Colors.blue,
                                  value: SelectPriority.PRIORITY,
                                  groupValue: _character,
                                  onChanged: (SelectPriority value) {
                                    setState(() {
                                      _character = value;
                                      priority = 1;
                                    });
                                  },
                                ),
                                Text("Yes")
                              ],
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Row(
                              children: [
                                Radio(
                                  activeColor: Colors.blue,
                                  value: SelectPriority.NOTPRI,
                                  groupValue: _character,
                                  onChanged: (SelectPriority value) {
                                    setState(() {
                                      _character = value;
                                      priority = 0;
                                    });
                                  },
                                ),
                                Text("No")
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("A low ticket sales?"),
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Radio(
                                  activeColor: Colors.blue,
                                  value: SelectTicket.YesTick,
                                  groupValue: _characterT,
                                  onChanged: (SelectTicket value) {
                                    setState(() {
                                      _characterT = value;
                                      ticket = 1;
                                    });
                                  },
                                ),
                                Text("Yes")
                              ],
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Row(
                              children: [
                                Radio(
                                  activeColor: Colors.blue,
                                  value: SelectTicket.NoTick,
                                  groupValue: _characterT,
                                  onChanged: (SelectTicket value) {
                                    setState(() {
                                      _characterT = value;
                                      ticket = 0;
                                    });
                                  },
                                ),
                                Text("No")
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("A low mid route boarding?"),
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Radio(
                                  activeColor: Colors.blue,
                                  value: SelectBoarding.YesBoard,
                                  groupValue: _characterB,
                                  onChanged: (SelectBoarding value) {
                                    setState(() {
                                      _characterB = value;
                                      board = 1;
                                    });
                                  },
                                ),
                                Text("Yes")
                              ],
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Row(
                              children: [
                                Radio(
                                  activeColor: Colors.blue,
                                  value: SelectBoarding.NoBoard,
                                  groupValue: _characterB,
                                  onChanged: (SelectBoarding value) {
                                    setState(() {
                                      _characterB = value;
                                      board = 0;
                                    });
                                  },
                                ),
                                Text("No")
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: primaryButton(
                              title: "Save",
                              onFunction: () => _onSave(
                                  arrialId: arrivalDateTimeController.text,
                                  busId: busId,
                                  conductorId: conductorId,
                                  depId: deptimeDateController.text,
                                  driverId: driverId,
                                  midRute: board.toString(),
                                  porterId: porterId,
                                  price: priceController.text,
                                  priorityId: priority.toString(),
                                  routeId: routId,
                                  ticketID: ticket.toString()))),
                    )
                  ],
                ),
              ),
            ),
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

  _onSave({
    @required String routeId,
    @required String busId,
    @required String conductorId,
    @required String porterId,
    @required String driverId,
    @required String depId,
    @required String arrialId,
    @required String priorityId,
    @required String ticketID,
    @required String price,
    @required String midRute,
  }) async {
    setState(() {
      isLoading = true;
    });
    try {
      print("$routeId");
      final response = await http.post(
        "$BASE_URL/schedules",
        body: {
          'route_id': routeId,
          'station_id': stationId,
          'bus_id': busId,
          'conductor_id': conductorId,
          'porter_id': porterId,
          'driver_id': driverId,
          'departure_date': depId,
          'departure_time': arrialId,
          'priority': priorityId,
          'ticketing': ticketID,
          'mid_route': midRute,
          'price': price,
        },
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ).timeout(
        Duration(seconds: 50),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          isLoading = false;
        });
        if (responseData['status'] == 200) {
          toastContainer(text: responseData['message']);
          Navigator.pop(context);
        } else {
          toastContainer(text: responseData['message']);
        }
      }
    } on TimeoutException catch (e) {
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  // Widget allBus() {
  //   loadbusesOffline();
  //   busesBloc.fetchAllStaffs(stationId);
  //   return StreamBuilder<Object>(
  //     stream: busesBloc.allBuses,
  //     initialData:
  //         busesMapOffline == null ? null : BussModel.fromJson(busesMapOffline),
  //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
  //       if (snapshot.hasData) {
  //         return _mBusT(snapshot.data, context);
  //       } else if (snapshot.hasError) {
  //         return Text("Error");
  //       }
  //       return Center(child: CupertinoActivityIndicator(radius: 15));
  //     },
  //   );
  // }

  Future<void> androidSelectBus({BuildContext context}) async {
    switch (await showDialog<String>(
        context: (context),
        builder: (BuildContext context) {
          return Dialog(
            child: SeachBus(),
          );
        })) {
    }
  }

  Future<void> androidSelectRoute({BuildContext context}) async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            // title: Text('$title'),
            child: SearchRoute(),
          );
        })) {
    }
  }

  // Widget _mDriver(DriversModel model, BuildContext context) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       for (var data in model.data) ...[
  //         Platform.isIOS
  //             ? CupertinoActionSheetAction(
  //                 child:
  //                     Text('${data.user.name}', style: TextStyle(color: BLACK)),
  //                 onPressed: () {
  //                   setState(() {
  //                     // _toCode = data.id;
  //                     driverId = (data.id).toString();
  //                     driverController.text = data.user.name;
  //                   });

  //                   Navigator.pop(context);
  //                 },
  //               )
  //             : SimpleDialogOption(
  //                 onPressed: () {
  //                   driverId = (data.id).toString();
  //                   driverController.text = data.user.name;
  //                   Navigator.pop(context);
  //                 },
  //                 child:
  //                     Text("${data.user.name}", style: TextStyle(fontSize: 20)),
  //               ),
  //         Divider(),
  //       ]
  //     ],
  //   );
  // }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ':' + _minute;
        arrivalDateTimeController.text = _time;
        print(_minute);
        // arrivalDateTimeController.text = formatDate(
        //     DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
        //     ['hh', ':', 'nn', " ", 'am']).toString();
      });
  }

  // Widget allDriver() {
  //   loadDriverOffline();
  //   driverBloc.fetchDrivers(stationId);
  //   return StreamBuilder<Object>(
  //     stream: driverBloc.drivers,
  //     initialData: driversMapOffline == null
  //         ? null
  //         : DriversModel.fromJson(driversMapOffline),
  //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
  //       if (snapshot.hasData) {
  //         return _mDriver(snapshot.data, context);
  //       } else if (snapshot.hasError) {
  //         return Text("Error");
  //       }
  //       return Center(child: CupertinoActivityIndicator(radius: 15));
  //     },
  //   );
  // }

  Future<void> androidSelectDriver({BuildContext context}) async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            // title: Text('$title'),
            child: SearchDiver(),
          );
        })) {
    }
  }

  // Widget _mConductor(ConductorModel model, BuildContext context) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       for (var data in model.data) ...[
  //         Platform.isIOS
  //             ? CupertinoActionSheetAction(
  //                 child:
  //                     Text('${data.user.name}', style: TextStyle(color: BLACK)),
  //                 onPressed: () {
  //                   setState(() {
  //                     conductorId = data.id.toString();
  //                     conductorController.text = "${data.user.name}";
  //                   });

  //                   Navigator.pop(context);
  //                 },
  //               )
  //             : SimpleDialogOption(
  //                 onPressed: () {
  //                   conductorId = data.id.toString();
  //                   conductorController.text = "${data.user.name}";
  //                   Navigator.pop(context);
  //                 },
  //                 child:
  //                     Text("${data.user.name}", style: TextStyle(fontSize: 20)),
  //               ),
  //         Divider(),
  //       ]
  //     ],
  //   );
  // }

  // Widget allConductor() {
  //   loadconductorsOffline();
  //   conductorBloc.fetchConductors(stationId);
  //   return StreamBuilder<Object>(
  //     stream: conductorBloc.conductors,
  //     initialData: conductorsMapOffline == null
  //         ? null
  //         : ConductorModel.fromJson(conductorsMapOffline),
  //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
  //       if (snapshot.hasData) {
  //         return _mConductor(snapshot.data, context);
  //       } else if (snapshot.hasError) {
  //         return Text("Error");
  //       }
  //       return Center(child: CupertinoActivityIndicator(radius: 15));
  //     },
  //   );
  // }

  Future<void> androidSelectConductor(
      {String title, BuildContext context}) async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: SearchConductor(),
          );
        })) {
    }
  }

  // Widget _mPorter(PortersModel model, BuildContext context) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       for (var data in model.data) ...[
  //         Platform.isIOS
  //             ? CupertinoActionSheetAction(
  //                 child:
  //                     Text('${data.user.name}', style: TextStyle(color: BLACK)),
  //                 onPressed: () {
  //                   setState(() {
  //                     porterId = data.id.toString();
  //                     porterController.text = "${data.user.name}";
  //                   });

  //                   Navigator.pop(context);
  //                   Navigator.pop(context);
  //                 },
  //               )
  //             : SimpleDialogOption(
  //                 onPressed: () {
  //                   porterId = data.id.toString();
  //                   porterController.text = "${data.user.name}";
  //                   Navigator.pop(context);
  //                 },
  //                 child:
  //                     Text("${data.user.name}", style: TextStyle(fontSize: 20)),
  //               ),
  //         Divider(),
  //       ]
  //     ],
  //   );
  // }

  // Widget allPorter() {
  //   loadportersOffline();
  //   porterBloc.fetchPorters(stationId);
  //   return StreamBuilder<Object>(
  //     stream: porterBloc.porters,
  //     initialData: portersMapOffline == null
  //         ? null
  //         : PortersModel.fromJson(portersMapOffline),
  //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
  //       if (snapshot.hasData) {
  //         return _mPorter(snapshot.data, context);
  //       } else if (snapshot.hasError) {
  //         return Text("Error");
  //       }
  //       return Center(child: CupertinoActivityIndicator(radius: 15));
  //     },
  //   );
  // }

  Future<void> androidSelectPorter({String title, BuildContext context}) async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: SearchPorter(),
          );
        })) {
    }
  }

  void _showDatePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 200,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (val) {
                          setState(() {
                            deptimeDateController.text =
                                DateFormat.yMMMMEEEEd().format(val);
                          });
                        }),
                  ),
                ],
              ),
            ));
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate,
    );
    if (date != null)
      setState(() {
        deptimeDateController.text = DateFormat.yMMMMEEEEd().format(date);
      });
  }
}
