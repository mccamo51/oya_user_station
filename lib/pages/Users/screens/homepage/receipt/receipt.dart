import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/images.dart';

class TicketReceipt extends StatefulWidget {
  final String ticketNo,
      amount,
      tripDate,
      tripTime,
      from,
      to,
      seatNumber,
      userName,
      ice1Phone,
      userPhoneNumber,
      stationName,
      stationPhoneNumber,
      busRegNumber,
      driverName,
      driverPhoneNumber,
      conductorName,
      logo,
      conductorPhoneNumber;

  TicketReceipt({
    @required this.ticketNo,
    @required this.amount,
    @required this.tripDate,
    @required this.tripTime,
    @required this.from,
    @required this.to,
    @required this.logo,
    @required this.seatNumber,
    @required this.userName,
    @required this.ice1Phone,
    @required this.userPhoneNumber,
    @required this.stationName,
    @required this.stationPhoneNumber,
    @required this.busRegNumber,
    @required this.driverName,
    @required this.driverPhoneNumber,
    @required this.conductorName,
    @required this.conductorPhoneNumber,
  });

  @override
  _TicketReceiptState createState() => _TicketReceiptState();
}

class _TicketReceiptState extends State<TicketReceipt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: BACKREDCOLOR,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: widget.logo == null
                                ? Image.asset(MAINLOGO, width: 80, height: 80)
                                : Image.network(widget.logo),
                          ),
                          Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: PRIMARYCOLOR),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Text(
                            "${widget.from}",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "To",
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            "${widget.to}",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Price: GHS ${widget.amount}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(
                                "Digitization & Insurance: GHS 0",
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Divider(),
                      ),

                      // Text(
                      //   "GHS ${widget.amount}",
                      //   style: h3Black,
                      // )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: EdgeInsets.only(left: 10, top: 10, right: 5),
                decoration: BoxDecoration(
                  color: WHITE,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Trip Details",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: BLACK,
                      ),
                    ),
                    Row(children: [
                      rowItem(
                          icon: FeatherIcons.tag,
                          title: "Ticket Number",
                          context: context,
                          subTitle: widget.ticketNo),
                      rowItem(
                          icon: Icons.event_seat,
                          title: "Seat Number",
                          context: context,
                          subTitle: "${widget.seatNumber}"),
                    ]),
                    Row(children: [
                      rowItem(
                          icon: FeatherIcons.truck,
                          context: context,
                          title: "Vehicle Number",
                          subTitle: widget.busRegNumber),
                      rowItem(
                        icon: FeatherIcons.calendar,
                        title: "Trip Date",
                        context: context,
                        subTitle: "${widget.tripDate}  \n${widget.tripTime}",
                      )
                    ]),
                    Row(children: [
                      rowItem(
                          icon: FeatherIcons.list,
                          title: "Station Code",
                          context: context,
                          subTitle: "${widget.stationName}"),
                      rowItem(
                          icon: FeatherIcons.user,
                          context: context,
                          title: "Driver's Contact",
                          subTitle:
                              "${widget.driverName}  \n${widget.driverPhoneNumber}"),
                    ]),
                    Row(children: [
                      rowItem(
                          icon: FeatherIcons.user,
                          title: "Conductor's Contact",
                          context: context,
                          subTitle:
                              "${widget.conductorName} \n${widget.conductorPhoneNumber}"),
                      rowItem(
                          icon: FeatherIcons.phone,
                          title: "Station Contact",
                          context: context,
                          subTitle: "${widget.stationPhoneNumber}"),
                    ]),
                    SizedBox(height: 15),
                    Divider(),
                    Text(
                      "Passenger Details",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: BLACK,
                      ),
                    ),
                    Row(children: [
                      rowItem(
                        icon: FeatherIcons.user,
                        title: "Passenger Details",
                        context: context,
                        subTitle:
                            "${widget.userName} \n${widget.userPhoneNumber}",
                      ),
                      rowItem(
                          icon: FeatherIcons.phone,
                          title: "Next of Kin Phone Number",
                          subTitle: "${widget.ice1Phone}",
                          context: context),
                    ]),
                    SizedBox(height: 15),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(
                          //   width: 120,
                          //   child: CupertinoButton(
                          //       padding: EdgeInsets.zero,
                          //       borderRadius: BorderRadius.circular(15),
                          //       color: PRIMARYCOLOR,
                          //       child: Padding(
                          //         padding: const EdgeInsets.only(
                          //             left: 10, right: 10),
                          //         child: Text(
                          //           "View Insurance",
                          //           style: TextStyle(fontSize: 12),
                          //         ),
                          //       ),
                          //       onPressed: () {}),
                          // ),
                          // SizedBox(
                          //   width: 120,
                          //   child: CupertinoButton(
                          //       padding: EdgeInsets.zero,
                          //       borderRadius: BorderRadius.circular(15),
                          //       color: PRIMARYCOLOR,
                          //       child: Padding(
                          //         padding: const EdgeInsets.only(
                          //             left: 10, right: 10),
                          //         child: Text(
                          //           "Share Ticket",
                          //           style: TextStyle(fontSize: 12),
                          //         ),
                          //       ),
                          //       onPressed: () {}),
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: PRIMARYCOLOR),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Powered by "),
                Text(
                  "Oya!",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: PRIMARYCOLOR,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
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
                child: Text(
                  "$title",
                  style: TextStyle(
                    fontSize: 10,
                  ),
                )),
            SizedBox(
              height: 4,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Text(
                  "$subTitle",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ],
        )
      ],
    ),
  );
}
