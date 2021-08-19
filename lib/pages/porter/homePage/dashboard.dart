import 'dart:convert';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:http/http.dart' as http;
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/pages/porter/homePage/graph/graphScreen.dart';
import 'package:oya_porter/spec/colors.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  DateTime today = DateTime.now();
  String passengers = "0",
      trave = "0",
      minor = "0",
      registered = "0",
      frmDate,
      beginDte,
      fromRawDate;
  bool isLoading = false;
  @override
  void initState() {
    frmDate = DateFormat.MEd().format(today);
    fromRawDate = "2021-07-01 10:48:19.621169";
    beginDte = DateFormat.MEd().format(
      DateTime.parse("2021-07-01 10:48:19.621169"),
    );
    super.initState();
    _getData(
      startDate: fromRawDate,
      endDate: today.toUtc().toString(),
    );
    _getTotal(
      endDate: today.toUtc().toString(),
      startDate: fromRawDate,
    );
  }

  List<charts.Series<_SalesData, String>> _seriesData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(title: 'Dashboard', actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GraphScreen(
                              passenger: passengers,
                              minor: (minor),
                              users: (registered),
                              traveller: (trave),
                            )));
              },
              icon: Icon(FeatherIcons.barChart2))
        ]),
        body: Column(children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 15.0, right: 15, top: 5, bottom: 5),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: WHITE,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0.1, 0.7),
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 0.5,
                        spreadRadius: 0.3)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Date (From - To)",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                          child: Text("$beginDte"),
                          onPressed: () {
                            _fromPickDate();
                          }),
                      Text("To"),
                      CupertinoButton(
                          child: Text("$frmDate"),
                          onPressed: () {
                            print("Time open");
                            _pickDate();
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                cardContainer(
                    icon: FeatherIcons.dollarSign,
                    name: 'PASSENGERS',
                    num: 2.3,
                    color: Colors.green,
                    context: context,
                    number: isLoading ? 'Loading...' : '$passengers'),
                cardContainer(
                    icon: FeatherIcons.list,
                    name: 'MINORS',
                    num: 2.3,
                    color: Colors.yellow[800],
                    context: context,
                    number: isLoading ? 'Loading...' : '$trave'),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: cardContainer(
                icon: FeatherIcons.users,
                name: 'REGISTERED USERS',
                num: 1,
                color: Colors.blue[700],
                context: context,
                number: isLoading ? 'Loading...' : '$registered'),
          )
        ]));
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(1980),
      lastDate: DateTime(DateTime.now().year + 10),
      initialDate: today,
    );
    if (date != null)
      setState(() {
        frmDate = DateFormat.MEd().format(date);
        print("end Date ${date.toUtc().toString()}");
        print("Start Date $fromRawDate");

        _getData(
          startDate: fromRawDate,
          endDate: date.toUtc().toString(),
        );
        _getTotal(endDate: date.toUtc().toString(), startDate: fromRawDate);

        // dateString =
        //     "${date.year.toString()}-${date.month.toString()}-${date.day.toString()}";
      });
  }

  _fromPickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(1980),
      lastDate: DateTime(DateTime.now().year + 10),
      initialDate: today,
    );
    if (date != null)
      setState(() {
        beginDte = DateFormat.MEd().format(date);
        print("Start Date ${date.toUtc().toString()}");
        fromRawDate = date.toUtc().toString();
        // dateString =
        //     "${date.year.toString()}-${date.month.toString()}-${date.day.toString()}";
      });
  }

  Future<void> _getData({String startDate, String endDate}) async {
    setState(() {
      isLoading = true;
    });
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
      if (response.statusCode == 200) {
        // setState(() {
        //   isLoading = false;
        // });
        final responseData = json.decode(response.body);
        setState(() {
          passengers = responseData['passengers'].toString();
          trave = responseData['minors'].toString();
          minor = responseData['minors'].toString();
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print("error");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  _getTotal({String startDate, String endDate}) async {
    try {
      final url = Uri.parse(
          "$BASE_URL/metrics/registrations?paginate=true&limit=1&start_date=$startDate&end_date=$endDate");

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $accessToken",
          'Content-Type': 'application/json'
        },
      ).timeout(Duration(seconds: 50));
      print(response.body);
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        final responseData = json.decode(response.body);
        setState(() {
          registered = responseData['total'].toString();
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print("error");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
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

// FeatherIcons.dollarSign
Widget cardContainer(
    {String name,
    String number,
    IconData icon,
    double num = 1,
    Color color,
    BuildContext context}) {
  return Stack(
    children: [
      Container(
        width: MediaQuery.of(context).size.width / num,
        height: 100,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: WHITE,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0.1, 0.7),
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 0.5,
                  spreadRadius: 0.3)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$name",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text("$number",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            Icon(icon)
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
              height: 80,
              width: 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      bottomLeft: Radius.circular(25)),
                  color: color)),
        ),
      ),
    ],
  );
}
