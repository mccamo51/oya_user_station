import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/bloc/staffBloc.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/emptyBox.dart';
import 'package:oya_porter/models/stuffModel.dart';
import 'package:oya_porter/spec/colors.dart';

import 'addStaff.dart';

class Staffs extends StatefulWidget {
  final id;
  Staffs({@required this.id});
  @override
  _StaffsState createState() => _StaffsState();
}

class _StaffsState extends State<Staffs> {
  @override
  void initState() {
    stafBloc.fetchAllStaffs(widget.id.toString());
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
      body: StreamBuilder(
        stream: stafBloc.allStaff,
        // initialData: allTripsMapOffline == null
        //     ? null
        //     : TripsModel.fromJson(allTripsMapOffline),
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
    );
  }

  Widget _mainContent(StaffModel staffModel) {
    if (staffModel.data != null && staffModel.data.length > 0)
      return SingleChildScrollView(
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
                    )
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

_itemTile({@required String name, @required String phone, String role}) {
  return Padding(
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
        icon: Icon(
          Icons.delete_forever,
          color: RED,
        ),
        onPressed: () {},
      ),
    ),
  );
}
