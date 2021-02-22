import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/spec/colors.dart';

itemTile(
    {@required String carNumber, @required String seater, Function onDelete}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Icon(FeatherIcons.truck),
          title: Text("$carNumber"),
          subtitle: Text("$seater Seater"),
          trailing: IconButton(
            icon: Icon(
              Icons.delete_forever,
              color: RED,
            ),
            onPressed: onDelete,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 50.0),
        child: Divider(),
      )
    ],
  );
}
