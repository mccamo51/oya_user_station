import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/spec/colors.dart';

import 'addRoute.dart';

class Routes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: ("Routes"), actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddRoute()));
            })
      ]),
      body: Column(
        children: [
          _itemTile(),
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
      leading: Icon(FeatherIcons.mapPin),
      title: Text("Accra   -   Kumasi"),
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
