import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/pages/Driver/allBuses.dart';
import 'package:oya_porter/pages/Driver/viewStaffs.dart';
import 'package:oya_porter/spec/colors.dart';

class ConductorHomePage extends StatelessWidget {
  final String id;

  ConductorHomePage({@required this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Conductor"),
      body: Column(
        children: [
          item(
              icon: Icons.person,
              title: "All Staffs",
              onFunc: () {
                print(id);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewStaffs(id: id),
                  ),
                );
              }),
          item(
              icon: FeatherIcons.truck,
              title: "All Buses",
              onFunc: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Busses(stationId: id),
                  ),
                );
              })
        ],
      ),
    );
  }
}

item({IconData icon, String title, Function onFunc}) {
  return Card(
    child: Container(
      padding: EdgeInsets.all(5),
      child: ListTile(
        title: Text(
          '$title',
          style: TextStyle(fontSize: 22),
        ),
        leading: Icon(
          icon,
          color: PRIMARYCOLOR,
        ),
        onTap: onFunc,
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 15,
        ),
      ),
    ),
  );
}
