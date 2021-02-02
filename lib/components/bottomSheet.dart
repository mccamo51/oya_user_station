import 'package:flutter/material.dart';
import 'package:oya_porter/spec/images.dart';
import 'package:oya_porter/spec/styles.dart';

customBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
            decoration: BoxDecoration(
              
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            )),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  // child: customBack(context, "Contact Us"),
                ),
                SizedBox(
                  height: 10,
                ),
                row(icon: KEYBOARD1IMAGE, number: "055 623 6339"),
                row(icon: KEYBOARD2IMAGE, number: "020 812 5243"),
                row(icon: EMAIL2IMAGE, number: "info@whitewindghana.com"),
              ],
            ));
      });
}

row({
  String icon,
  String number,
}) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      children: [
        Image.asset(
          icon,
          width: 40,
          height: 40,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          "055 623 6339",
          style: h4Black,
        ),
        Image.asset(
          EXTERNALIMAGE,
          width: 10,
          height: 10,
        ),
      ],
    ),
  );
}
