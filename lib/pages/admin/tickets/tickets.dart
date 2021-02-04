import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/spec/colors.dart';

import 'addTickets.dart';

class TicketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: ("Tickets"), actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddTicket()));
            })
      ]),
      body: Column(
        children: [
          _itemTile(),
          _itemTile(),
          _itemTile(),
          _itemTile(),
          _itemTile(),
        ],
      ),
    );
  }
}

_itemTile() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListTile(
      leading: Icon(Icons.car_repair),
      title: Text("G.P.R.T.U KANESHIE CAPE, & TARDI (GT-123 2020)"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("GPRTU KANESHIE CAPE, & TARDI"),
          Text("Departure: 12th Dec, 2021 \n@ 12:20pm"),
        ],
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.delete_forever,
          color: RED,
        ),
        onPressed: () {},
      ),
    ),
  );
}
