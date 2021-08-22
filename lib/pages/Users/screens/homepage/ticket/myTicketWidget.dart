import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/pages/Users/model/ticketModel.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/styles.dart';
Widget myTicketWidget({
  @required BuildContext context,
  @required Function onTap,
  @required TicketsModel ticketsModel,
  @required String from,
  @required String to,
  @required String pmtStatus,
  @required String busRegNumber,
  @required String tripDate,
  @required String tripTime,
}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                width: MediaQuery.of(context).size.width * .9,
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
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color:
                            pmtStatus == "Completed" ? PRIMARYCOLOR : ICONCOLOR,
                      ),
                      child: Text(
                        pmtStatus == "Completed" ? "Paid" : "Not Paid",
                        style: pmtStatus == "Completed" ? h4White : h4Red,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(children: [
                rowItem(
                  icon: FeatherIcons.truck,
                  context: context,
                  title: "Vehicle Number",
                  subTitle: "$busRegNumber",
                ),
                rowItem(
                  icon: FeatherIcons.calendar,
                  title: "Trip Date",
                  context: context,
                  subTitle: "$tripDate  \n$tripTime",
                )
              ]),
            ],
          ),
        ),
      ),
    ),
  );
}

rowItem({IconData icon, String title, String subTitle, BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        Icon(icon, color: PRIMARYCOLOR),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Text("$title")),
            SizedBox(
              height: 4,
            ),
            Text("$subTitle"),
          ],
        )
      ],
    ),
  );
}
