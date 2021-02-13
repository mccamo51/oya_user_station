import 'package:flutter/material.dart';
import 'package:oya_porter/config/navigation.dart';
import 'package:oya_porter/spec/styles.dart';

import 'busses/busses.dart';
import 'rating/rating.dart';
import 'routes/routes.dart';
import 'schedules/schedules.dart';
import 'staffs/staffs.dart';
import 'tickets/tickets.dart';

class StationMasterPage extends StatelessWidget {
  final id;
  StationMasterPage({@required this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Home"),
        centerTitle: true,
        elevation: 0.6,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _cardWidget(
                  onTap: () => navigateBuss(context),
                  name: "Busses",
                  image: "assets/images/admin/longbus.png"),
              _cardWidget(
                  onTap: () => navigateSchedules(context),
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
                  onTap: () => navigateStaffs(context),
                  name: "Staffs",
                  image: "assets/images/admin/staffs.png"),
              _cardWidget(
                  onTap: () => _navigatePage(context),
                  name: "Ticket Sale",
                  image: "assets/images/admin/ticket.png"),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _cardWidget(
                  onTap: () => navigateRatings(context),
                  name: "Rating",
                  image: "assets/images/admin/rating.png"),
              _cardWidget(
                  onTap: () => navigateRoute(context),
                  name: "Routes",
                  image: "assets/images/admin/route.png"),
            ],
          ),
        ],
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

_navigatePage(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => TicketPage()));
}

navigateRoute(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Routes()));
}

navigateRatings(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Rating()));
}

navigateSchedules(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Schedules()));
}

navigateStaffs(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Staffs()));
}

navigateBuss(BuildContext context) {
  navigation(context: context, pageName: "busses");
}
