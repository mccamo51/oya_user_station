import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/bloc/conductorBloc.dart';
import 'package:oya_porter/bloc/driverBloc.dart';
import 'package:oya_porter/bloc/myRouteBloc.dart';
import 'package:oya_porter/config/offlineData.dart';
import 'package:oya_porter/models/conductorModel.dart';
import 'package:oya_porter/models/driverModel.dart';
import 'package:oya_porter/models/myRouteModel.dart';
import 'package:oya_porter/pages/admin/schedules/widgets/seachWidgetBus.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/styles.dart';

  TextEditingController conductorController = TextEditingController();

class SearchConductor extends StatefulWidget {
  @override
  _SearchConductorState createState() => _SearchConductorState();
}

class _SearchConductorState extends State<SearchConductor> {
  String _searchText = "";
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return allRoute();
  }

  Widget _mRoute(ConductorModel model, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Select Conductor",
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
                          child: Text('${data.user.name}',
                              style: TextStyle(color: BLACK)),
                          onPressed: () {
                            setState(() {
                    conductorId = data.id.toString();
                    conductorController.text = "${data.user.name}";
                            });

                            Navigator.pop(context);
                          },
                        ),
                      ))
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: SimpleDialogOption(
                          onPressed: () {
                            setState(() {
                    conductorId = data.id.toString();
                    conductorController.text = "${data.user.name}";
                            });
                            Navigator.pop(context);
                          },
                          child: Text('${data.user.name}',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ),
            if (_searchText != null &&
                _searchText != "" &&
                data.user.name
                    .toLowerCase()
                    .contains(_searchText.toLowerCase()))
              Platform.isIOS
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: CupertinoActionSheetAction(
                          child: Text('${data.user.name}',
                              style: TextStyle(color: BLACK)),
                          onPressed: () {
                            setState(() {
                    conductorId = data.id.toString();
                    conductorController.text = "${data.user.name}";
                            });

                            Navigator.pop(context);
                          },
                        ),
                      ))
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: SimpleDialogOption(
                          onPressed: () {
                            setState(() {
                    conductorId = data.id.toString();
                    conductorController.text = "${data.user.name}";
                            });

                            Navigator.pop(context);
                          },
                          child: Text("${data.user.name}",
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ),
            // Divider(),
          ]
        ],
      ),
    );
  }

  Widget allRoute() {
  loadconductorsOffline();
    conductorBloc.fetchConductors(stationId);
    return StreamBuilder<Object>(
      stream: conductorBloc.conductors,
      initialData: conductorsMapOffline == null
          ? null
          : ConductorModel.fromJson(conductorsMapOffline),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return _mRoute(snapshot.data, context);
        } else if (snapshot.hasError) {
          return Text("Error");
        }
        return Center(child: CupertinoActivityIndicator(radius: 15));
      },
    );
  }
}
