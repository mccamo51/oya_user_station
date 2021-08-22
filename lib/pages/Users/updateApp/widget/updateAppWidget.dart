import 'package:flutter/material.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/images.dart';
import 'package:oya_porter/spec/styles.dart';

Widget updateAppWidget({
  @required BuildContext context,
  @required String title,
  @required String message,
  @required bool allowNotNow,
  @required void Function() onNotNow,
  @required void Function() onUpdate,
}) {
  return Container(
    padding: EdgeInsets.all(10),
    child: Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 500),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(UPDATE,
                  height: MediaQuery.of(context).size.height * 0.5),
              SizedBox(height: 20),
              Text("$title", style: h1Black),
              SizedBox(height: 10),
              Center(
                child: Text(
                  "$message",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: BLACK,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 200,
                  child: _customButtonAndroid(
                    color: PRIMARYCOLOR,
                    txtChild: "UPDATE APP",
                    function: onUpdate,
                  ),
                ),
              ),
              if (allowNotNow)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FlatButton(
                    child: Text(
                      "NOT NOW",
                      style: TextStyle(
                          fontSize: 17,
                          color: BLACK,
                          fontWeight: FontWeight.w500),
                    ),
                    onPressed: onNotNow,
                  ),
                ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _customButtonAndroid({
  Function function,
  String txtChild,
  Color color,
  double top = 20,
}) {
  return Padding(
    padding: EdgeInsets.only(left: 0.0, right: 0, top: top),
    child: SizedBox(
      width: double.infinity,
      height: 50,
      child: RaisedButton(
        onPressed: function,
        child: Text("$txtChild", style: h5WhiteBold),
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      ),
    ),
  );
}
