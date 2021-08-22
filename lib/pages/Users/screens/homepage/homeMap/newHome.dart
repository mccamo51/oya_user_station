import 'package:flutter/material.dart';
import 'package:oya_porter/pages/Users/config/navigation.dart';
import 'package:oya_porter/pages/Users/screens/homepage/homeMap/bookingHome.dart';
import 'package:oya_porter/pages/Users/screens/homepage/parcels/parcelsRecieved.dart';
import 'package:oya_porter/pages/Users/screens/homepage/parcels/parcelsSent.dart';
import 'package:oya_porter/pages/Users/screens/homepage/rentBus/rentBus.dart';
import 'package:oya_porter/pages/Users/screens/homepage/rentBus/specialHire.dart';
import 'package:oya_porter/pages/Users/screens/homepage/trips/enrollTrip.dart';
import 'package:oya_porter/pages/Users/updateApp/function/checkUpdate.dart';
import 'package:oya_porter/pages/Users/updateApp/updateApp.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/styles.dart';

bool buyTicketForOthers;

class ItemMenu1 extends StatefulWidget {
  final bool isStaff;
  ItemMenu1({@required this.isStaff});
  @override
  _ItemMenu1State createState() => _ItemMenu1State();
}

class _ItemMenu1State extends State<ItemMenu1> {
  initState() {
    super.initState();
    if (forceUser) checkUpdate(context);
    // check();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      appBar: AppBar(
        title: Text("Menu"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        // color: WHITE,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image.asset("assets/images/admin/travelling.png"),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Wrap(
                    spacing: 15,
                    runSpacing: 15,
                    children: [
                      item(
                          icon: "assets/images/admin/buy_ticket.png",
                          title: "Buy a Ticket",
                          onFunc: () => _onBuyTicket(context)),
                      item(
                        icon: "assets/images/admin/homeTicket.png",
                        title: "My Tickets",
                        onFunc: () =>
                            navigation(context: context, pageName: "tickets"),
                      ),
                      item(
                        icon: "assets/images/admin/homeBus.png",
                        title: "Enrol",
                        onFunc: () => _onEnrollBus(context),
                      ),

                      item(
                          icon: "assets/images/admin/rent_bus.png",
                          title: "Rent a bus",
                          onFunc: () => _onHireBus(context)),
                      item(
                        // icon: Icons.wallet_travel,
                        icon: "assets/images/admin/distances.png",

                        title: "Trips",
                        onFunc: () =>
                            navigation(context: context, pageName: "trips"),
                      ),
                      item(
                        // icon: FeatherIcons.gift,
                        icon: "assets/images/admin/parcel.png",

                        title: "Parcels",
                        onFunc: () => _onParcelService(context),
                      ),
                      // item(
                      //   // icon: Icons.shield,
                      //   icon: "assets/images/admin/insurance.png",

                      //   title: "Local Travel Insurance",
                      //   onFunc: () =>
                      //       navigation(context: context, pageName: "insurance"),
                      // ),
                      isStaff
                          ? item(
                              // icon: Icons.dashboard,
                              icon: "assets/images/admin/more.png",
                              title: "Switch to Admin",
                              onFunc: () => Navigator.pop(context))
                          : item(
                              // icon: Icons.dashboard,
                              icon: "assets/images/admin/more.png",

                              title: "More",
                              onFunc: () => navigation(
                                  context: context, pageName: "more"),
                            )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onParcelService(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Parcels'),
        children: [
          ListTile(
            title: Text('Parcels Sent', style: h3Black),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ParcelSent(),
              ),
            ),
          ),
          ListTile(
            title: Text('Parcels Recieved', style: h3Black),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ParcelRecieved(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onEnrollBus(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Enrol on Bus'),
        children: [
          ListTile(
            title: Text('Ticket Enrolment', style: h3Black),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EnrollTrip(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onHireBus(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Rent a Bus'),
        children: [
          ListTile(
            title: Text('Normal Hiring', style: h3Black),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RentBus(),
              ),
            ),
          ),
          ListTile(
            title: Text('Special Hiring', style: h3Black),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SpecialHire(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onBuyTicket(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Buy Ticket'),
        children: [
          Divider(),
          ListTile(
            title: Text('Buy for Self', style: h3Black),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              setState(() {
                buyTicketForOthers = false;
              });
              navigation(context: context, pageName: "rentals");
            },
          ),
          ListTile(
            title: Text('Buy for others', style: h3Black),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              setState(() {
                buyTicketForOthers = true;
              });
              print(buyTicketForOthers);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MapView()));
            },
          ),
        ],
      ),
    );
  }
}

item({String icon, String title, Function onFunc}) {
  return GestureDetector(
    onTap: onFunc,
    child: Container(
      decoration: BoxDecoration(
          color: WHITE,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
      width: 100,
      height: 100,
      // he
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      child: Column(
        children: [
          Image.asset(
            icon,
            height: 50,
            width: 70,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '$title',
            overflow: TextOverflow.ellipsis,
            // maxLines: 2,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
        // trailing: Icon(
        //   Icons.arrow_forward_ios,
        //   size: 15,
        // ),
      ),
    ),
  );
}
