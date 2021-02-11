import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/pages/admin/busses/add_buss.dart';
import 'package:oya_porter/pages/admin/busses/widgets/bussesWidget.dart';
import 'package:oya_porter/spec/colors.dart';

class Busses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: ("Busses"),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => AddBus()));
              })
        ],
      ),
      body: Column(
        children: [
          itemTile(),
          itemTile(),
          itemTile(),
          itemTile(),
          itemTile(),
        ],
      ),
    );
  }
}
