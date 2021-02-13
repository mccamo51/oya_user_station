import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/bloc/busesBloc.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/emptyBox.dart';
import 'package:oya_porter/models/busModel.dart';
import 'package:oya_porter/pages/admin/busses/add_buss.dart';
import 'package:oya_porter/pages/admin/busses/widgets/bussesWidget.dart';
import 'package:oya_porter/spec/colors.dart';

class Busses extends StatefulWidget {
  final stationId;
  Busses({@required this.stationId});
  @override
  _BussesState createState() => _BussesState();
}

class _BussesState extends State<Busses> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    busesBloc.fetchAllStaffs(widget.stationId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: ("Busses"),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => AddBus()));
              })
        ],
      ),
      body: StreamBuilder(
        stream: busesBloc.allBuses,
        // initialData: allTripsMapOffline == null
        //     ? null
        //     : TripsModel.fromJson(allTripsMapOffline),
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
    );
  }

  Widget _mainContent(BussModel bussModel) {
    // print(bussModel.data);
    if (bussModel.data != null && bussModel.data.length > 0)
      return SingleChildScrollView(
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
                      seater: x.busType.name,
                    )
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
