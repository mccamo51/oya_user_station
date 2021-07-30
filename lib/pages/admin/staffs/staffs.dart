import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/bloc/staffBloc.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/emptyBox.dart';
import 'package:oya_porter/config/offlineData.dart';
import 'package:oya_porter/models/stuffModel.dart';
import 'package:oya_porter/pages/admin/staffs/editStaff.dart';
import 'package:oya_porter/spec/colors.dart';

import 'addStaff.dart';

class Staffs extends StatefulWidget {
  final id;
  Staffs({@required this.id});
  @override
  _StaffsState createState() => _StaffsState();
}

class _StaffsState extends State<Staffs> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 3));
    stafBloc.fetchAllStaffs(widget.id.toString(), context);

    return null;
  }

  @override
  void initState() {
    stafBloc.fetchAllStaffs(widget.id.toString(), context);
    // loadAllStaffOffline();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    return Scaffold(
      appBar: appBar(title: ("Staffs"), actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddStaff()));
            })
      ]),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: refreshList,
        child: StreamBuilder(
          stream: stafBloc.allStaff,
          // initialData: allStaffMapOffline == null
          //     ? null
          //     : StaffModel.fromJson(allStaffMapOffline),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            print("snapshot: ${snapshot.data}");
            if (snapshot.hasData) {
              return _mainContent(snapshot.data);
            } else if (snapshot.hasError) {
              return Scaffold(body: emptyBox(context));
            }
            return Center(
              child: CupertinoActivityIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _mainContent(StaffModel staffModel) {
    if (staffModel.data != null && staffModel.data.length > 0)
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  for (var x in staffModel.data)
                    _itemTile(
                        name: x.user.name,
                        phone: x.user.phone,
                        role: x.accountType.name,
                        onFunction: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditStaff(
                                  icePhone: x.user.ice1Phone,
                                  name: x.user.name,
                                  phone: x.user.phone,
                                  uid: x.user.id,
                                  accountId: x.accountType.name),
                            ),
                          );
                        })
                ],
              ),
            ),
          ],
        ),
      );
    else
      return emptyBox(context);
  }
}

_itemTile(
    {@required String name,
    @required String phone,
    String role,
    Function onFunction}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Icon(FeatherIcons.user),
          title: Text("Name: $name"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Phone: $phone"),
              Text("User: $role"),
            ],
          ),
          trailing: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              FeatherIcons.edit,
              color: PRIMARYCOLOR,
            ),
            onPressed: onFunction,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Divider(),
      )
    ],
  );
}
