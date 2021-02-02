import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/spec/colors.dart';

primaryButton({Function onFunction, String title, Color color = PRIMARYCOLOR}) {
  return  Platform.isIOS
        ? CupertinoButton(
            color: color,
            onPressed: onFunction,
            child: Text(
              "$title",
              style: TextStyle(
                color: color == WHITE ? BLACK : WHITE,
                fontSize: 16,
              ),
            ),
          )
        : FlatButton(
            color: color,
            onPressed: onFunction,
            child: Text(
              "$title",
              style: TextStyle(
                color: color == WHITE ? BLACK : WHITE,
                fontSize: 16,
              ),
            ),
         
  );
}
