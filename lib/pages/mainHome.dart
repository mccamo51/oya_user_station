import 'package:flutter/material.dart';
import 'package:oya_porter/components/appBar.dart';

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
                onTap: () {},
                title: Text(x['account_type']['name']),
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
