
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/spec/colors.dart';

itemTile() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListTile(
      leading: Icon(FeatherIcons.truck),
      title: Text("GT-1234 2010"),
      subtitle: Text("30 Seater"),
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