import 'package:flutter/material.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/pages/porter/homePage/parcels/addParcel.dart';

class Parcels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Parcels", actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddParcel())),
        )
      ]),
      body: Column(
        children: [Text("Parcels")],
      ),
    );
  }
}
