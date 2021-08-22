import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/pages/Users/model/tripModel.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/styles.dart';

Widget myTripsWidget({
  @required BuildContext context,
  @required Function onTap,
  @required TripsModel tripsModel,
  @required String from,
  @required String to,
  @required String price,
  @required String carNo,
  @required String departireDate,
  @required String status,
  @required String companyName,
}) {
  // if (tripsModel.data != null && tripsModel.data.length > 0)
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .85,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .6,
                      child: Text(
                        '$from - $to',
                        style: h3Black,
                      ),
                    ),
                    // Container(
                    //     padding: const EdgeInsets.all(5),
                    //     color: ICONCOLOR,
                    //     child: Text("In Progress", style: h4Red))
                  ],
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(FeatherIcons.truck, color: ICONCOLOR),
                title: Text('$from $to $companyName ($carNo)'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          FeatherIcons.clock,
                          color: ICONCOLOR,
                        ),
                        SizedBox(width: 10),
                        Text("$departireDate", style: h5Black)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          FeatherIcons.tag,
                          color: ICONCOLOR,
                        ),
                        SizedBox(width: 10),
                        Text("GHC $price", style: h5Black)
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
            ],
          ),
        ],
      ),
    );
}
