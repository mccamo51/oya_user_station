import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:oya_porter/components/appBar.dart';

class SalesData {
  SalesData({this.label, this.total});

  final String label;
  final int total;
}

class GraphScreen extends StatefulWidget {
  GraphScreen({Key key, this.minor, this.passenger, this.traveller, this.users})
      : super(key: key);
  final String passenger;
  final String minor;
  final String traveller;
  final String users;

  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  @override
  Widget build(BuildContext context) {
    List<SalesData> listEarnings = [
      SalesData(total: int.parse(widget.passenger), label: "Passengers"),
      SalesData(total: int.parse(widget.minor), label: "Minors"),
      SalesData(total: int.parse(widget.traveller), label: "Travellers"),
      SalesData(total: int.parse(widget.users), label: "Users"),
    ];
    List<charts.Series<SalesData, String>> timeline = [
      charts.Series(
        id: "Statistics",
        data: listEarnings,
        domainFn: (SalesData timeline, _) => timeline.label,
        measureFn: (SalesData timeline, _) => timeline.total,
      )
    ];
    return Scaffold(
      appBar: appBar(title: 'Statistics'),
      body: Center(
          child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                "Passengers Monthly Statistics ",
              ),
              Expanded(
                child: charts.BarChart(
                  timeline,
                  animate: true,
                  // barGroupingType: charts.BarGroupingType.grouped,
                ),
              ),
              Text(
                "Source: Oya!!",
              ),
            ],
          ),
        ),
      )),
    );
  }
}
