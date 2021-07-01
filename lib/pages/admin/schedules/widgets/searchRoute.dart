import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/bloc/myRouteBloc.dart';
import 'package:oya_porter/config/offlineData.dart';
import 'package:oya_porter/models/myRouteModel.dart';
import 'package:oya_porter/pages/admin/schedules/widgets/seachWidgetBus.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/styles.dart';

TextEditingController routeController = TextEditingController();

class SearchRoute extends StatefulWidget {
  @override
  _SearchRouteState createState() => _SearchRouteState();
}

class _SearchRouteState extends State<SearchRoute> {
  String _searchText = "";
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return allRoute();
  }

  Widget _mRoute(MyRouteModel model, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Select Route",
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
                          child: Text('${data.from.name} - ${data.to.name}',
                              style: TextStyle(color: BLACK)),
                          onPressed: () {
                            setState(() {
                              routId = data.id.toString();
                              routeController.text =
                                  "${data.from.name} - ${data.to.name}";
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
                              routId = data.id.toString();
                              routeController.text =
                                  "${data.from.name} - ${data.to.name}";
                            });
                            Navigator.pop(context);
                          },
                          child: Text("${data.from.name} - ${data.to.name}",
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ),
            if (_searchText != null &&
                _searchText != "" &&
                data.from.name
                    .toLowerCase()
                    .contains(_searchText.toLowerCase()))
              Platform.isIOS
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: CupertinoActionSheetAction(
                          child: Text('${data.from.name} - ${data.to.name}',
                              style: TextStyle(color: BLACK)),
                          onPressed: () {
                            setState(() {
                              routId = data.id.toString();
                              routeController.text =
                                  "${data.from.name} - ${data.to.name}";
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
                              routId = data.id.toString();
                              routeController.text =
                                  "${data.from.name} - ${data.to.name}";
                            });

                            Navigator.pop(context);
                          },
                          child: Text("${data.from.name} - ${data.to.name}",
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
    // loadMyRouteOffline();
    myRouteBloc.fetchAllStaffs(stationId, context);
    return StreamBuilder<Object>(
      stream: myRouteBloc.myroutes,
      // initialData: myRouteMapOffline == null
      //     ? null
      //     : MyRouteModel.fromJson(myRouteMapOffline),
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
