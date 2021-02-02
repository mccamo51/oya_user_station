import 'package:flutter/material.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/images.dart';
import 'package:oya_porter/spec/styles.dart';

import 'buttons.dart';

class PaymentSuccess extends StatefulWidget {
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
      conductorPhoneNumber;

  PaymentSuccess({
    @required this.ticketNo,
    @required this.amount,
    @required this.tripDate,
    @required this.tripTime,
    @required this.from,
    @required this.to,
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
  _PaymentSuccessState createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARYCOLOR,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  children: [
                    Center(
                      child: Container(
                          child: Image.asset(
                        VERIFYIMAGE,
                        width: 70,
                        height: 70,
                      )),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Transaction Successful",
                      style: h2WHITE,
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Text(
                        '''You should receive a prompt on the phone you specified. Follow the instructions to complete the payment''',
                        textAlign: TextAlign.center,
                        style: h4White,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: primaryButton(
                  title: "View Receipt",
                  color: WHITE,
                  onFunction: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) => TicketReceipt(
                    //       amount: widget.amount,
                    //       ticketNo: widget.ticketNo,
                    //       tripDate: widget.tripDate,
                    //       tripTime: widget.tripTime,
                    //       from: widget.from,
                    //       to: widget.to,
                    //       seatNumber: widget.seatNumber,
                    //       userName: widget.userName,
                    //       ice1Phone: widget.ice1Phone,
                    //       userPhoneNumber: widget.userPhoneNumber,
                    //       stationName: widget.stationName,
                    //       stationPhoneNumber: widget.stationPhoneNumber,
                    //       busRegNumber: widget.busRegNumber,
                    //       driverName: widget.driverName,
                    //       driverPhoneNumber: widget.driverPhoneNumber,
                    //       conductorName: widget.conductorName,
                    //       conductorPhoneNumber: widget.conductorPhoneNumber,
                    //     ),
                    //   ),
                    // );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
