import 'package:flutter/material.dart';
import 'package:oya_porter/components/buttons.dart';
import 'package:oya_porter/components/shimmerLoading.dart';
import 'package:oya_porter/config/button.dart';
import 'package:oya_porter/spec/styles.dart';

enum BusSelect { twentytwo, twentyfive, fiftyone, twelve }

class BusSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: customBack(context, "Rent a Bus"),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Bus Selection",
                  style: h3Black,
                ),
              ),
              Column(children: [
                _checTile(
                  text: "22 Seater",
                ),
              ])
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: primaryButton(
                    title: "Continue",
                    onFunction: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  LoadingListPage()));
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}

_checTile({String text}) {
  BusSelect _character = BusSelect.twentytwo;
  return Column(
    children: <Widget>[
      RadioListTile<BusSelect>(
        title: Text(
          '22 Seater',
          style: h2Black,
        ),
        value: BusSelect.twentytwo,
        groupValue: _character,
        onChanged: (BusSelect value) {},
      ),
      Divider(),
      RadioListTile<BusSelect>(
        title: Text(
          '25 Seater',
          style: h2Black,
        ),
        value: BusSelect.twentyfive,
        groupValue: _character,
        onChanged: (BusSelect value) {},
      ),
      Divider(),
      RadioListTile<BusSelect>(
        title: Text(
          '51 Seater',
          style: h2Black,
        ),
        value: BusSelect.fiftyone,
        groupValue: _character,
        onChanged: (BusSelect value) {},
      ),
      Divider(),
      RadioListTile<BusSelect>(
        title: Text(
          '12 Seater',
          style: h2Black,
        ),
        value: BusSelect.twelve,
        groupValue: _character,
        onChanged: (BusSelect value) {},
      ),
    ],
  );
}
