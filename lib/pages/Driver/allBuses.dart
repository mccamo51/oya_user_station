import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/bloc/busesBloc.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/emptyBox.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/offlineData.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/models/busModel.dart';
import 'package:oya_porter/pages/admin/busses/add_buss.dart';
import 'package:oya_porter/pages/admin/busses/widgets/bussesWidget.dart';
import 'package:http/http.dart' as http;
import 'package:oya_porter/pages/auth/login/login.dart';

class Busses extends StatefulWidget {
  final stationId;
  Busses({@required this.stationId});
  @override
  _BussesState createState() => _BussesState();
}

class _BussesState extends State<Busses> {
  bool isLoading = false;

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 3));
    busesBloc.fetchAllStaffs(widget.stationId);

    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    busesBloc.fetchAllStaffs(widget.stationId);
    loadallAllBussesOffline();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("==========${widget.stationId}");
    return Scaffold(
      appBar: appBar(
        title: ("Busses"),
      ),
      body: isLoading
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : RefreshIndicator(
              onRefresh: refreshList,
              key: refreshKey,
              child: StreamBuilder(
                stream: busesBloc.allBuses,
                initialData: alBussesMapOffline == null
                    ? null
                    : BussModel.fromJson(alBussesMapOffline),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  print("snapshot: ${snapshot.data}");
                  if (snapshot.hasData) {
                    return _mainContent(snapshot.data);
                  } else if (snapshot.hasError) {
                    return Scaffold(body: emptyBox(context));
                  }
                  return Center(
                    child: CupertinoActivityIndicator(),
                  );
                },
              ),
            ),
    );
  }

  Widget _mainContent(BussModel bussModel) {
    // print(bussModel.data);
    if (bussModel.data != null && bussModel.data.length > 0)
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  for (var x in bussModel.data)
                    itemTile(
                        carNumber: x.regNumber,
                        seater: x.busType.minCapacity.toString(),
                        showDele: true)
                ],
              ),
            ),
          ],
        ),
      );
    else
      return emptyBox(context);
  }
}
