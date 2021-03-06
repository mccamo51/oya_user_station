import 'package:flutter/material.dart';
import 'package:oya_porter/pages/admin/busses/busses.dart';
import 'package:oya_porter/pages/admin/rating/rating.dart';
import 'package:oya_porter/pages/admin/routes/routes.dart';
import 'package:oya_porter/pages/admin/schedules/viewSchedules.dart';
import 'package:oya_porter/pages/porter/homePage/schedule/porterSchedules.dart';
import 'package:oya_porter/spec/styles.dart';

import 'staffs/staffs.dart';
import 'tickets/tickets.dart';

class GeneralManagerPage extends StatelessWidget {
  final stationID;
  final String title;

  GeneralManagerPage({@required this.stationID, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$title"),
        centerTitle: true,
        elevation: 0.6,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _cardWidget(
                    onTap: () => navigateBuss(context, stationID.toString()),
                    name: "Busses",
                    image: "assets/images/admin/longbus.png"),
                _cardWidget(
                    onTap: () =>
                        navigateSchedules(context, stationID.toString()),
                    name: "Schedules",
                    image: "assets/images/admin/bus.png"),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _cardWidget(
                    onTap: () => navigateStaffs(context, stationID.toString()),
                    name: "Staffs",
                    image: "assets/images/admin/staffs.png"),
                // _cardWidget(
                //     onTap: () => _navigatePage(context, stationID.toString()),
                //     name: "Ticket Sale",
                //     image: "assets/images/admin/ticket.png"),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _cardWidget(
                    onTap: () => navigateRatings(context, stationID.toString()),
                    name: "Rating",
                    image: "assets/images/admin/rating.png"),
                _cardWidget(
                    onTap: () => navigateRoute(context, stationID.toString()),
                    name: "Routes",
                    image: "assets/images/admin/route.png"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

_cardWidget({Function onTap, String image, String name}) {
  return InkWell(
    onTap: onTap,
    child: Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ClipOval(
                child: Image.asset(
              "$image",
              height: 100,
              width: 100,
            )),
            SizedBox(
              height: 10,
            ),
            Text(
              "$name",
              style: h3Black,
            )
          ],
        ),
      ),
    ),
  );
}

_navigatePage(BuildContext context, String id) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => TicketPage(id: id)));
}

navigateRoute(BuildContext context, String id) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => Routes(id: id)));
}

navigateRatings(BuildContext context, String id) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Rating(
                stationId: id,
              )));
}

navigateSchedules(BuildContext context, String id) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PorterSchedule(
                isSchedule: false,
              )));
}

navigateStaffs(BuildContext context, String id) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Staffs(
                id: id,
              )));
}

navigateBuss(BuildContext context, String id) {
  print(id);
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => Busses(stationId: id)));
}
