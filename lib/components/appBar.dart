import 'package:flutter/material.dart';

Widget appBar({String title, List<Widget> actions}) {
  return AppBar(
    title: Text("$title"),
    centerTitle: true,
    actions: actions,
    elevation: 0.3,
  );
}
