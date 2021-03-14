import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/bloc/busesBloc.dart';
import 'package:oya_porter/config/offlineData.dart';
import 'package:oya_porter/models/busModel.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/styles.dart';

TextEditingController busController = TextEditingController();
String busId, routId, driverId, conductorId, porterId;
TextEditingController driverController = TextEditingController();

class SeachBus extends StatefulWidget {
  @override
  _SeachBusState createState() => _SeachBusState();
}

class _SeachBusState extends State<SeachBus> {
  String _searchText = "";

  TextEditingController searchController = TextEditingController();

  bool _showDivider = true;

  @override
  Widget build(BuildContext context) {
    return allBus();
  }

  Widget allBus() {
    loadbusesOffline();
    busesBloc.fetchAllStaffs(stationId);
    return StreamBuilder<Object>(
      stream: busesBloc.allBuses,
      initialData:
          busesMapOffline == null ? null : BussModel.fromJson(busesMapOffline),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return _mBusT(snapshot.data, context);
        } else if (snapshot.hasError) {
          return Text("Error");
        }
        return Center(child: CupertinoActivityIndicator(radius: 15));
      },
    );
  }

  Widget _mBusT(BussModel model, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Select Bus",
              style: h2Black,
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.only(left: 6),
              decoration: BoxDecoration(
                  color: SECONDARYCOLOR,
                  borderRadius: BorderRadius.circular(6)),
              child: TextFormField(
                cursorColor: SECONDARYCOLOR,
                controller: searchController,
                focusNode: null,
                onChanged: (String text) => setState(() => _searchText = text),
                onFieldSubmitted: (String text) =>
                    setState(() => _searchText = text),
                decoration: InputDecoration(
                  hintText: "Type your seach here",
                  hoverColor: BLACK,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          for (var data in model.data) ...[
            if (_searchText == "" || _searchText == null)
              Platform.isIOS
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: CupertinoActionSheetAction(
                          child: Text('${data.regNumber}',
                              style: TextStyle(color: BLACK)),
                          onPressed: () {
                            setState(() {
                              // _toCode = data.id;
                              busId = (data.id).toString();
                              busController.text = data.regNumber;
                              driverController.text = data.driver.user.name;
                              driverId = data.driver.id.toString();
                            });

                            Navigator.pop(context);
                          },
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: SimpleDialogOption(
                          onPressed: () {
                            busId = (data.id).toString();
                            busController.text = data.regNumber;

                            driverController.text = data.driver.user.name;
                            driverId = data.driver.id.toString();
                            Navigator.pop(context);
                          },
                          child: Text("${data.regNumber}",
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ),
            if (_searchText != null &&
                _searchText != "" &&
                data.regNumber
                    .toLowerCase()
                    .contains(_searchText.toLowerCase()))
              Platform.isIOS
                  ? SizedBox(
                      width: double.infinity,
                      child: CupertinoActionSheetAction(
                        child: Text('${data.regNumber}',
                            style: TextStyle(color: BLACK)),
                        onPressed: () {
                          setState(() {
                            // _toCode = data.id;
                            busId = (data.id).toString();
                            busController.text = data.regNumber;
                            driverController.text = data.driver.user.name;
                            driverId = data.driver.id.toString();
                          });

                          Navigator.pop(context);
                        },
                      ),
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: SimpleDialogOption(
                        onPressed: () {
                          busId = (data.id).toString();
                          busController.text = data.regNumber;

                          driverController.text = data.driver.user.name;
                          driverId = data.driver.id.toString();
                          Navigator.pop(context);
                        },
                        child: Text("${data.regNumber}",
                            style: TextStyle(fontSize: 20)),
                      ),
                    ),
          ]
        ],
      ),
    );
  }
}
