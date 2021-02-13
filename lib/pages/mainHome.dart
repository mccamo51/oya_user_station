import 'package:flutter/material.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/pages/porter/homePage/homePageWithNav.dart';

import 'admin/adminPage.dart';

class MainHomePage extends StatelessWidget {
  final data;
  MainHomePage({@required this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Home"),
      body: Column(
        children: [
          for (var x in data)
            Card(
              child: ListTile(
                onTap: () {
                  if (x['account_type']['id'] == 1) {
                  } else if (x['account_type']['id'] == 2) {
                  } else if (x['account_type']['id'] == 3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StationMasterPage(
                          id: x['account_type']['id'],
                          stationID: x['station']['id'],
                        ),
                      ),
                    );
                  } else if (x['account_type']['id'] == 4) {
                  } else if (x['account_type']['id'] == 5) {
                  } else if (x['account_type']['id'] == 6) {
                  } else if (x['account_type']['id'] == 7) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PorterHomePage(
                            // id: x['account_type']['id'],
                            ),
                      ),
                    );
                  }
                },
                title: Text(x['account_type']['name']),
                subtitle: Text(x['station']['name']),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
              ),
            )
        ],
      ),
    );
  }
}
