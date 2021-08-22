import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/styles.dart';


Widget busSelectionLayoutWidget({
  @required BuildContext context,
  @required void Function() onTap,
  @required String stationName,
  @required String busModel,
  @required String seatsNo,
  @required String time,
  @required String price,
  @required String regNo,
}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.all(5),
          title: Text(
            "$stationName",
            style: h3Black,
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  _iconText(
                    context: context,
                    icon: FeatherIcons.truck,
                    text: "$busModel",
                  ),
                  _iconText(
                    context: context,
                    icon: FeatherIcons.trello,
                    text: "$seatsNo Seater",
                  ),
                  _iconText(
                    context: context,
                    icon: FeatherIcons.clock,
                    text: "$time",
                  ),
                  _iconText(
                    context: context,
                    icon: FeatherIcons.tag,
                    text: "GHS $price",
                  ),
                  _iconText(
                    context: context,
                    icon: FeatherIcons.truck,
                    text: "$regNo",
                  ),
                ],
              ),
              SizedBox(height: 10),
              Divider(),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _iconText({
  @required IconData icon,
  @required String text,
  @required BuildContext context,
}) {
  return Container(
    padding: EdgeInsets.all(5),
    width: MediaQuery.of(context).size.width * .4,
    child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: ICONCOLOR),
          SizedBox(width: 10),
          Text(
            "$text",
            style: h4Black,
          )
        ]),
  );
}
