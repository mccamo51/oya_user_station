import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/bloc/regionBloc.dart';
import 'package:oya_porter/bloc/townBloc.dart';
import 'package:oya_porter/bloc/townByRegionBloc.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/models/regionModel.dart';
import 'package:oya_porter/models/townModle.dart';
import 'package:oya_porter/models/townRegionModel.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:http/http.dart' as http;

import 'widgets/addRouteWidget.dart';

class AddRoute extends StatefulWidget {
  final stationID;
  AddRoute({@required this.stationID});
  @override
  _AddRouteState createState() => _AddRouteState();
}

class _AddRouteState extends State<AddRoute> {
  TextEditingController destinationController = TextEditingController();
  TextEditingController townController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController insExpController = TextEditingController();
  TextEditingController regNoController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String townId, regionId, destId;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    print(stationId);

    return Scaffold(
      key: _scaffoldKey,
      body: isLoading
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : addRouteWidget(
              formKey: _formKey,
              context: context,
              destinationController: destinationController,
              regionController: regionController,
              townController: townController,
              onSelectDestination: () {
                if (_formKey.currentState.validate()) {
                  androidSelectSource(
                    context: context,
                    title: "Select Town",
                  );
                }
              },
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
    if (townController.text.isEmpty && destinationController.text.isEmpty) {
      toastContainer(text: "Please select town to continue");
    } else {
      setState(() {
        isLoading = true;
      });
      try {
        Map<String, dynamic> body = {
          'source': souId,
          'destination': destId,
          'region_id': regID,
        };
        final url = Uri.parse("$BASE_URL/stations/${widget.stationID}/routes");

        final response = await http.post(
          url,
          body: json.encode(body),
          headers: {
            "Authorization": "Bearer $accessToken",
            'Content-Type': 'application/json'
          },
        ).timeout(
          Duration(seconds: 50),
        );
        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          setState(() {
            isLoading = false;
          });
          print(responseData);
          if (responseData['status'] == 200) {
            Navigator.pop(context);
            toastContainer(text: responseData['message']);
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
  }

  Widget _mSource(TonwFromRegionModel model, BuildContext context) {
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
    townBloc.fetchTown(context);
    return StreamBuilder<Object>(
      stream: townBloc.towns,
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

  Widget allSOurce() {
    print(regionId);
    townsByRegBloc.fetchTownByReg(regionId, context);
    return StreamBuilder<Object>(
      stream: townsByRegBloc.townFromregion,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return _mSource(snapshot.data, context);
        } else if (snapshot.hasError) {
          return Text("Error");
        }
        return Center(child: CupertinoActivityIndicator(radius: 15));
      },
    );
  }

  Future<void> androidSelectSource({String title, BuildContext context}) async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('$title'),
            children: <Widget>[
              allSOurce(),
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
    regionBloc.fetchRegion(context);
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
