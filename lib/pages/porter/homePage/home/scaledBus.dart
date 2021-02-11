import 'package:flutter/material.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/pages/porter/homePage/loadBus/loadBus.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/styles.dart';

class ScaledBusses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Scaled Buses"),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _scaledCard(onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoadBuses()));
            })
          ],
        ),
      ),
    );
  }
}

_scaledCard({Function onTap, String number}) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      color: PRIMARYCOLOR,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Text(
            "GE-53452 2020[4272]",
            style: h3WHITE,
          ),
        ),
      ),
    ),
  );
}
