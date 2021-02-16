import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/bloc/regionBloc.dart';
import 'package:oya_porter/bloc/townBloc.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/models/regionModel.dart';
import 'package:oya_porter/models/townModle.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:http/http.dart' as http;

import 'widgets/addRouteWidget.dart';

class AddRoute extends StatefulWidget {
  @override
  _AddRouteState createState() => _AddRouteState();
}

class _AddRouteState extends State<AddRoute> {
  TextEditingController destinationController = TextEditingController();
  TextEditingController townController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController insExpController = TextEditingController();
  TextEditingController regNoController = TextEditingController();

  String townId, regionId, destId;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : addRouteWidget(
              context: context,
              destinationController: destinationController,
              regionController: regionController,
              townController: townController,
              onSelectDestination: () => androidSelectDestination(
                context: context,
                title: "Select Town",
              ),
              onAddROute: () =>
                  _onSave(destId: destId, regID: regionId, souId: townId),
              onSelectRegion: () => androidSelectRegion(
                context: context,
                title: "Select Region",
              ),
              onSelectTown: () => androidSelectDestination2(
                context: context,
                title: "Select Town",
              ),
            ),
    );
  }

  _onSave({
    String souId,
    String destId,
    String regID,
  }) async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.post(
        "$BASE_URL/routes",
        body: {
          'source': souId,
          'destination': destId,
          'region_id': regID,
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
          Navigator.pop(context);
          toastContainer(text: responseData['message']);
        } else {
          toastContainer(text: responseData['message']);
        }
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

  Widget _mDest(TownModel model, BuildContext context) {
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
                      destId = (data.id).toString();
                      destinationController.text = data.name;
                    });

                    Navigator.pop(context);
                  },
                )
              : SimpleDialogOption(
                  onPressed: () {
                    destId = (data.id).toString();
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

  Widget _mDest2(TownModel model, BuildContext context) {
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
                      townId = (data.id).toString();
                      townController.text = data.name;
                    });

                    Navigator.pop(context);
                  },
                )
              : SimpleDialogOption(
                  onPressed: () {
                    townId = (data.id).toString();
                    townController.text = data.name;
                    Navigator.pop(context);
                  },
                  child: Text("${data.name}", style: TextStyle(fontSize: 20)),
                ),
          Divider(),
        ]
      ],
    );
  }

  Widget allDestination2() {
    // loadAllCities();
    townBloc.fetchTown();
    return StreamBuilder<Object>(
      stream: townBloc.towns,
      // initialData: allCities == null ? null : CitiesModel.fromJson(allCities),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return _mDest2(snapshot.data, context);
        } else if (snapshot.hasError) {
          return Text("Error");
        }
        return Center(child: CupertinoActivityIndicator(radius: 15));
      },
    );
  }

  Future<void> androidSelectDestination2(
      {String title, BuildContext context}) async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('$title'),
            children: <Widget>[
              allDestination2(),
            ],
          );
        })) {
    }
  }

  Widget allDestination() {
    // loadAllCities();
    townBloc.fetchTown();
    return StreamBuilder<Object>(
      stream: townBloc.towns,
      // initialData: allCities == null ? null : CitiesModel.fromJson(allCities),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return _mDest(snapshot.data, context);
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
            children: <Widget>[
              allDestination(),
            ],
          );
        })) {
    }
  }

  Widget _mRegion(RegionModel model, BuildContext context) {
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
                      regionId = (data.id).toString();
                      regionController.text = data.name;
                    });

                    Navigator.pop(context);
                  },
                )
              : SimpleDialogOption(
                  onPressed: () {
                    regionId = (data.id).toString();
                    regionController.text = data.name;
                    Navigator.pop(context);
                  },
                  child: Text("${data.name}", style: TextStyle(fontSize: 20)),
                ),
          Divider(),
        ]
      ],
    );
  }

  Widget region() {
    // loadAllCities();
    regionBloc.fetchRegion();
    return StreamBuilder<Object>(
      stream: regionBloc.regions,
      // initialData: allCities == null ? null : CitiesModel.fromJson(allCities),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return _mRegion(snapshot.data, context);
        } else if (snapshot.hasError) {
          return Text("Error");
        }
        return Center(child: CupertinoActivityIndicator(radius: 15));
      },
    );
  }

  Future<void> androidSelectRegion({String title, BuildContext context}) async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('$title'),
            children: <Widget>[region()],
          );
        })) {
    }
  }
}
