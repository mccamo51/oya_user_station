import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/pages/Users/screens/homepage/homeMap/newHome.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/styles.dart';

Widget summaryWidget({
  @required String route,
  @required String dateTime,
  @required String selectedBus,
  @required String pickup,
  @required String seatsSelected,
  @required String price,
  @required List<Map<String, dynamic>> passengers,
}) {
  return Container(
    padding: EdgeInsets.all(5),
    child: SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$route", style: h2Black),
            SizedBox(height: 15),
            _layout(
              icon: FeatherIcons.calendar,
              subTitle: "$dateTime",
              title: "Trip Date",
            ),
            SizedBox(height: 5),
            _layout(
              icon: FeatherIcons.truck,
              subTitle: "$selectedBus",
              title: "Selected Bus",
            ),
            SizedBox(height: 5),
            _layout(
              icon: Icons.location_history,
              subTitle: "$pickup",
              title: "Pickup Point",
            ),
            SizedBox(height: 5),
            _layout(
              icon: FeatherIcons.tag,
              subTitle: "$price",
              title: "Price",
            ),
            SizedBox(height: 5),
            ListTile(
              leading: Icon(FeatherIcons.users, color: ICONCOLOR),
              title: Text("Passengers' Detail", style: h5Black),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int x = 0; x < passengers.length; ++x)
                    _passengerLayout(
                      iceNumber: '${passengers[x]["ice1_phone"]}',
                      name: '${passengers[x]["name"]}',
                      num: x + 1,
                      phoneNumber: '${passengers[x]["phone"]}',
                      seatId: '${passengers[x]["seat_id"]}',
                    ),
                ],
              ),
            ),
            SizedBox(height: 5),
            // insurancePolicy != null
            //     ? _layout(
            //         icon: FeatherIcons.shield,
            //         subTitle: "$insurancePolicy",
            //         title: "Insurance Policy",
            //       )
            //     : Container(
            //         height: 0,
            //         width: 0,
            //       ),
          ]),
    ),
  );
}

Widget summaryButtonWidget({
  @required void Function() onPressed,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ButtonTheme(
      minWidth: 500,
      height: 40,
      child: FlatButton(
        color: PRIMARYCOLOR,
        onPressed: onPressed,
        child: Text("Proceed to Pay", style: h4Button),
        textColor: WHITE,
      ),
    ),
  );
}

Widget _passengerLayout({
  @required int num,
  @required String name,
  @required String phoneNumber,
  @required String iceNumber,
  @required String seatId,
}) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    leading: buyTicketForOthers
        ? CircleAvatar(
            backgroundColor: BLACK,
            child: Text(
              "$num",
              style: TextStyle(color: WHITE, fontSize: 12),
            ),
            radius: 9,
          )
        : null,
    title: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Name: $name"),
        Text("Phone No.: $phoneNumber"),
        Text("ICE Number: $iceNumber"),
        Text("Seat Id: $seatId"),
      ],
    ),
  );
}

Widget _layout({
  @required IconData icon,
  @required String title,
  @required String subTitle,
}) {
  return ListTile(
    leading: Icon(icon, color: ICONCOLOR),
    title: Text("$title", style: h5Black),
    subtitle: Text("$subTitle", style: h3Black),
  );
}
