import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/buttons.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/arrays.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:http/http.dart' as http;

class EditStaff extends StatefulWidget {
  final name, phone, icePhone, uid, accountId;
  EditStaff(
      {@required this.icePhone,
      @required this.name,
      @required this.phone,
      @required this.accountId,
      @required this.uid});

  @override
  _EditStaffState createState() => _EditStaffState();
}

class _EditStaffState extends State<EditStaff> {
  String account_type_id;
  TextEditingController account_typeController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    account_typeController.text = widget.accountId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Edit Staff"),
      body: isLoading
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name: ${widget.name}"),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Phone: ${widget.phone}"),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Primary ICE: ${widget.icePhone}"),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () => androidSelectUserRole(
                        context: context, title: "Select User Role"),
                    child: textFormField(
                        hintText: "Account Type",
                        controller: account_typeController,
                        enable: false,
                        icon: Icons.arrow_drop_down,
                        focusNode: null),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: primaryButton(
                      onFunction: () => _updateStaff(
                          accoutId: account_type_id,
                          statID: stationId,
                          uid: widget.uid.toString(),
                          userId: userId.toString()),
                      title: "Update Staff Role",
                    ),
                  )
                ],
              ),
            ),
    );
  }

  _updateStaff({String uid, String statID, userId, accoutId}) async {
    print(accoutId.toString());
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> body = {
      'station_id': '$statID',
      'account_type_id': '$accoutId',
      'updated_by': '$userId',
    };
    final url = Uri.parse("$BASE_URL/staffs/$uid");

    final response = await http
        .put(url,
            headers: {
              "Authorization": "Bearer $accessToken",
              'Content-Type': 'application/json'
            },
            body: json.encode(body))
        .timeout(
          Duration(seconds: 50),
        );
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      final responseData = json.decode(response.body);
      if (responseData['status'] == 200) {
        toastContainer(text: responseData['message']);
      } else {
        toastContainer(text: responseData['message']);
      }
    } else if (response.statusCode == 401) {
      sessionExpired(context);
    } else {
      toastContainer(text: "Error has occured");
    }
  }

  Widget _mCities(List<String> model, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int x = 0; x < model.length; x++) ...[
          Platform.isIOS
              ? CupertinoActionSheetAction(
                  child: Text('${model[x]}', style: TextStyle(color: BLACK)),
                  onPressed: () {
                    setState(() {
                      // _toCode = data.id;
                      account_type_id = (x + 1).toString();
                      account_typeController.text = model[x];
                    });

                    Navigator.pop(context);
                  },
                )
              : SimpleDialogOption(
                  onPressed: () {
                    account_type_id = (x + 1).toString();

                    print(x + 1);
                    // _toCode = data.id;
                    account_typeController.text = model[x];
                    Navigator.pop(context);
                  },
                  child: Text("${model[x]}", style: TextStyle(fontSize: 20)),
                ),
          Divider(),
        ]
      ],
    );
  }

  Future<void> androidSelectUserRole(
      {String title, BuildContext context}) async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('$title'),
            children: <Widget>[_mCities(account_types, context)],
          );
        })) {
    }
  }
}
