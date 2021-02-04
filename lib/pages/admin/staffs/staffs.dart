import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/spec/colors.dart';

import 'addStaff.dart';

class Staffs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: ("Staffs"), actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddStaff()));
            })
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _itemTile(),
            _itemTile(),
            _itemTile(),
            _itemTile(),
            _itemTile(),
            _itemTile(),
            _itemTile(),
            _itemTile(),
          ],
        ),
      ),
    );
  }
}

_itemTile() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListTile(
      leading: Icon(FeatherIcons.user),
      title: Text("Name: Kofi Nkrumah"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Phone: 024537637"),
          Text("User: Admin"),
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
