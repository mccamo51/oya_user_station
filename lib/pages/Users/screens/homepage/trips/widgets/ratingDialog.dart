import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/spec/colors.dart';

String ratintStars = "0";
Future<void> ratingDialog({
  @required BuildContext context,
  @required String star,
  @required Function(double rate) submit,
  @required TextEditingController commentController,
  @required FocusNode commentFocus,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Why $star Stars?'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              textFormField(
                controller: commentController,
                focusNode: commentFocus,
                hintText: "Optional Comment",
                labelText: "Optional Comment",
                minLine: 4,
                maxLine: 4,
                inputType: TextInputType.text,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          OutlineButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Skip", style: TextStyle(color: PRIMARYCOLOR)),
            borderSide: BorderSide(color: PRIMARYCOLOR),
          ),
          SizedBox(width: 10),
          FlatButton(
            onPressed: () => submit(double.parse(star)),
            child: Text("Save", style: TextStyle(color: WHITE)),
            color: PRIMARYCOLOR,
          ),
        ],
      );
    },
  );
}

Future<void> iosRatingDialog({
  @required BuildContext context,
  @required String star,
  @required String rate,
  @required Function(double rate) submit,
  @required TextEditingController commentController,
  @required FocusNode commentFocus,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text('Why $star Stars?'),
        content: CupertinoTextField(
          controller: commentController,
          focusNode: commentFocus,
          placeholder: "Optional Comment",
          placeholderStyle: TextStyle(color: BLACK),
          // labelText: "Optional Comment",
          minLines: 4,
          maxLines: 4,
          // inputType: TextInputType.text,
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('Skip'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            child: Text('Save'),
            onPressed: () => submit(double.parse(star)),
          ),
        ],
      );
    },
  );
}
