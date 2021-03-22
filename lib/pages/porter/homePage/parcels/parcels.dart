import 'package:flutter/material.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/pages/porter/homePage/parcels/addParcel.dart';
import 'package:oya_porter/pages/porter/homePage/parcels/parcelSentByStation.dart';
import 'package:oya_porter/pages/porter/homePage/parcels/parcelSentByUser.dart';

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
        children: [
          ListTile(
            leading: Icon(Icons.sentiment_dissatisfied),
            title: Text("Parcel Sent by Porter"),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => ParcelSent())),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(Icons.sentiment_dissatisfied),
            title: Text("Parcel Recieved"),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => ParcelRecieved())),
          )
        ],
      ),
    );
  }
}
