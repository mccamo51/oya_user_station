import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/bloc/ratingBloc.dart';
import 'package:oya_porter/bloc/reportBloc.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/emptyBox.dart';
import 'package:oya_porter/config/offlineData.dart';
import 'package:oya_porter/models/ratingModel.dart';
import 'package:oya_porter/models/reportModel.dart';
import 'package:oya_porter/pages/admin/rating/widgets/ratingWidget.dart';

class ReportPage extends StatefulWidget {
  final id;
  ReportPage({this.id});
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  void initState() {
    // TODO: implement initState
    loadReportOffline();
    reportBloc.fetchDrivers(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: reportBloc.reports,
      initialData: reportMapOffline == null
          ? null
          : ReportModel.fromJson(reportMapOffline),
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
    );
  }

  Widget _mainContent(ReportModel ratingModel) {
    if (ratingModel.data != null && ratingModel.data.length > 0)
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
                  for (var x in ratingModel.data)
                    itemTileReport(
                        name: x.user.name,
                        phone: x.user.phone,
                        carNo: x.busSchedule.bus.regNumber,
                        from: x.busSchedule.route.from.name,
                        to: x.busSchedule.route.to.name,
                        datTime: x.createdAt,
                        speed: x.speed.toString())
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
