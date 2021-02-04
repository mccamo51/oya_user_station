import 'package:flutter/material.dart';
import 'package:oya_porter/spec/styles.dart';

Widget buttonWithNoIcon({
  @required Color color,
  @required void Function() function,
  @required String text,
  @required BuildContext context,
  @required TextStyle textStyle,
  double width,
  double radius = 10,
}) {
  double w = width == null ? MediaQuery.of(context).size.width * .43 : width;
  return GestureDetector(
    onTap: function,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
      width: w,
      height: 50,
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: textStyle),
        ],
      )),
    ),
  );
}

customBack(BuildContext context, String backDescriiption) {
  return GestureDetector(
    onTap: () => Navigator.pop(context),
    child: Container(
      padding: EdgeInsets.only(top: 40),
      child: Row(
        children: [
          CircleAvatar(
            radius: 13,
            child: Padding(
              padding: const EdgeInsets.only(left: 3.0),
              child: Icon(
                Icons.arrow_back_ios,
                size: 13,
                color: Color(0xffc44646),
              ),
            ),
            backgroundColor: Color(0xffe9d8d8),
          ),
          SizedBox(width: 10),
          Text(
            "$backDescriiption",
            style: h2Black,
          ),
        ],
      ),
    ),
  );
}
