import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/buttons.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:http/http.dart' as http;
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/arrays.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/styles.dart';

class AddStaff extends StatefulWidget {
  @override
  _AddStaffState createState() => _AddStaffState();
}

class _AddStaffState extends State<AddStaff> {
  TextEditingController searchController = TextEditingController();
  TextEditingController account_typeController = TextEditingController();
  String name, phone, uid, account_type_id;
  bool show = false;
  bool isLoading = false;
  FocusNode onSeachFocus;

  @override
  void initState() {
    onSeachFocus = FocusNode();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Add New Staff"),
      body: isLoading
          ? Center(child: CupertinoActivityIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: textFormField(
                      hintText: "Enter phone number to search",
                      controller: searchController,
                      focusNode: onSeachFocus,
                      inputType: TextInputType.phone,
                      icon: Icons.search,
                      iconColor: BLACK,
                      onEditingComplete: () =>
                          onSearch(phoneNo: searchController.text),
                      labelText: "Search"),
                ),
                Visibility(
                    visible: show,
                    child: Card(
                        child: Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name: $name",
                            style: h3Black,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Phone: $phone",
                            style: h3Black,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () => androidSelectCity(
                                context: context, title: "Select Account Type"),
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
                              onFunction: () => onSave(
                                  accountId: account_type_id,
                                  userId: uid,
                                  staId: stationId),
                              title: "Add Station Staff",
                            ),
                          )
                        ],
                      ),
                    )))
              ],
            ),
    );
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

  Future<void> androidSelectCity({String title, BuildContext context}) async {
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

  onSave({String userId, String accountId, String staId}) async {
    setState(() {
      isLoading = true;
    });
    try {
      Map<String, dynamic> body = {
        'user_id': userId,
        'account_type_id': accountId,
        'station_id': staId,
      };
      final response = await http.post(
        "$BASE_URL/staffs",
        body: json.encode(body),
        headers: {
          "Authorization": "Bearer $accessToken",
          'Content-Type': 'application/json'
        },
      ).timeout(
        Duration(seconds: 50),
      );
      print(response.body);
      if (response.statusCode == 200) {
        setState(() => isLoading = false);

        final responseData = json.decode(response.body);
        // print(responseData);
        if (responseData['status'] == 200) {
          setState(() {
            show = true;
            name = responseData['data']['name'];
            phone = responseData['data']['phone'];
            uid = responseData['data']['id'];
          });
          toastContainer(text: "New Staff Added Successfully");
          Navigator.pop(context);
        } else {
          toastContainer(text: responseData['message']);
        }
      } else if (response.statusCode == 401) {
        sessionExpired(context);
      } else {
        toastContainer(text: "Error has occured");
      }
    } on TimeoutException catch (e) {
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  onSearch({String phoneNo}) async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(
        "$BASE_URL/search/users?needle=$phoneNo",
        headers: {
          "Authorization": "Bearer $accessToken",
          'Content-Type': 'application/json'
        },
      ).timeout(
        Duration(seconds: 50),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        // print(responseData);
        if (responseData['status'] == 200) {
          setState(() {
            isLoading = false;
            show = true;
            name = responseData['data']['name'];
            phone = responseData['data']["phone"].toString();
            uid = responseData['data']['id'].toString();
          });
        }
      }else if (response.statusCode == 401) {
        sessionExpired(context);
      } else {
        toastContainer(text: "Error has occured");
      }
    } on TimeoutException catch (e) {
      toastContainer(text: "Connetction timeout");
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      toastContainer(text: "$e");
      setState(() {
        isLoading = false;
      });
    }
  }
}
