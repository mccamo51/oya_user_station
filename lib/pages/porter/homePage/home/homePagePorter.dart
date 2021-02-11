import 'package:flutter/material.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/pages/porter/homePage/home/priorityBus.dart';
import 'package:oya_porter/pages/porter/homePage/home/scaledBus.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/styles.dart';

class HomePagePorter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Home"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Mr. Amo",
                  style: h2Black,
                ),
                Text("Role: Porter",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: PRIMARYCOLOR,
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
              child: Text(
            "No Loading Bus",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: RED,
            ),
          )),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _cardItem(onContinue: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ScaledBusses()));
                }),
                _cardItem(onContinue: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PriorityBuses()));
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}

_cardItem({String image, String name, Function onContinue}) {
  return Card(
    child: GestureDetector(
      onTap: onContinue,
      child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              CircleAvatar(
                radius: 30,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Scale",
                style: h4Black,
              )
            ],
          )),
    ),
  );
}
