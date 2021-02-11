import 'package:flutter/material.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/images.dart';

Widget emptyBox(BuildContext context, {String msg = ""}) {
  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Image.asset(
              EMPTYBIG,
              height: 200,
              width: 200,
            ),
          ),
          Center(
              child: Text(
            "Oops, Nothing Here !\n $msg",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: ASH),
          )),
        ],
      ),
    ),
  );
}
