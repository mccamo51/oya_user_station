import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/bloc/myRouteBloc.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/emptyBox.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/offlineData.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/models/myRouteModel.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:http/http.dart' as http;

import 'addRoute.dart';

class Routes extends StatefulWidget {
  final id;
  Routes({@required this.id});
  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  bool isLoading = false;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 3));
    myRouteBloc.fetchAllStaffs(widget.id, context);

    return null;
  }

  @override
  void initState() {
    myRouteBloc.fetchAllStaffs(widget.id, context);
    // loadMyRouteOffline();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: ("Routes"), actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddRoute()));
            })
      ]),
      body: RefreshIndicator(
        onRefresh: refreshList,
        key: refreshKey,
        child: StreamBuilder(
          stream: myRouteBloc.myroutes,
          // initialData: myRouteMapOffline == null
          //     ? null
          //     : MyRouteModel.fromJson(myRouteMapOffline),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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

  deleteRoute({
    // ignore: non_constant_identifier_names
    String route_id,
  }) async {
    setState(() {
      isLoading = true;
    });
    try {
      final url = Uri.parse("$BASE_URL/routes/$route_id");

      final response = await http.delete(
        url,
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ).timeout(
        Duration(seconds: 50),
      );
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
        toastContainer(text: "Error has occured");
      }
    } on TimeoutException catch (e) {
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget _mainContent(MyRouteModel model) {
    // print(bussModel.data);
    if (model.data != null && model.data.length > 0)
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
                  for (var x in model.data)
                    _itemTile(
                        from: x.from.name,
                        to: x.to.name,
                        onDelete: () {
                          deleteRoute(
                            route_id: x.id.toString(),
                          );
                        })
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

_itemTile({String from, String to, Function onDelete}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Icon(FeatherIcons.mapPin),
          title: Text("From: $from   -   $to"),
          trailing: IconButton(
            icon: Icon(
              Icons.delete_forever,
              color: RED,
            ),
            onPressed: onDelete,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Divider(),
      )
    ],
  );
}
