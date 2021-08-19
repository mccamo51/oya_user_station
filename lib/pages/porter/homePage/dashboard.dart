import 'dart:convert';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:http/http.dart' as http;
import 'package:oya_porter/pages/auth/login/login.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  DateTime today = DateTime.now();

  @override
  void initState() {
    super.initState();
    _getData(
      startDate: today.toUtc().toString(),
      endDate: today.toUtc().toString(),
    );
  }

  List<charts.Series<_SalesData, String>> _seriesData;

  @override
  Widget build(BuildContext context) {
    print(today);

    return Scaffold(
        appBar: appBar(title: 'Metrix'),
        body: Column(children: [
          //Initialize the chart widget
          Container(
            decoration: BoxDecoration(

            ),
          ),
          
          Row(
            children: [
              CupertinoButton(child: Text("Start Date"), onPressed: () {}),
              Text("To"),
              CupertinoButton(child: Text("End Date"), onPressed: () {}),
            ],
          )
        ]));
  }

  _getData({String startDate, String endDate}) async {
    try {
      final url = Uri.parse(
          "$BASE_URL/metrics/trips?paginate=true&limit=1&start_date=$startDate&end_date=$endDate");

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $accessToken",
          'Content-Type': 'application/json'
        },
      ).timeout(Duration(seconds: 50));
      print(response.body);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _SalesData(
          'passengers',
          responseData['total'],
          responseData['minors'],
          responseData['passengers'],
        );
      } else {
        print("error");
      }
    } catch (e) {}
  }
}

class _SalesData {
  _SalesData(this.label, this.total, this.minor, this.passengers,
      {this.colors});

  final String label;
  final double minor;
  final double passengers;
  final double total;
  Color colors;
}
