import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/components/emptyPage.dart';
import 'package:oya_porter/components/shimmerLoading.dart';
import 'package:oya_porter/pages/Users/bloc/ticketsBloc.dart';
import 'package:oya_porter/pages/Users/config/offlineData.dart';
import 'package:oya_porter/pages/Users/model/ticketModel.dart';
import 'package:oya_porter/pages/Users/screens/auth/register/secureAccount/secure.dart';
import 'package:oya_porter/pages/Users/screens/homepage/receipt/receipt.dart';
import 'package:oya_porter/pages/Users/screens/homepage/ticket/myTicketWidget.dart';
import 'package:oya_porter/pages/Users/screens/homepage/ticket/tickets.dart';
import 'package:oya_porter/spec/colors.dart';

class MyTickets extends StatefulWidget {
  @override
  _TicketsState createState() => _TicketsState();
}

class _TicketsState extends State<MyTickets> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 5));
    ticketsBloc.fetchAllTickets(context);

    return null;
  }

  @override
  void initState() {
    loadallAllTicketsOffline();
    ticketsBloc.fetchAllTickets(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARYCOLOR,
        iconTheme: IconThemeData(color: WHITE),
        title: Text(
          "Tickets",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: refreshList,
          key: refreshKey,
          child: StreamBuilder(
            stream: ticketsBloc.allTickets,
            initialData: allTicketsMapOffline == null
                ? null
                : TicketsModel.fromJson(allTicketsMapOffline),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              print("snapshot: ${snapshot.data}");
              if (snapshot.hasData) {
                return _mainContent(snapshot.data);
              } else if (snapshot.hasError) {
                return EmptyPage();
              }
              return Center(
                child: LoadingListPage(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _mainContent(TicketsModel ticketsModel) {
    print(ticketsModel.data);
    if (ticketsModel.data != null && ticketsModel.data.length > 0)
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  for (var x in ticketsModel.data)
                    myTicketWidget(
                      ticketsModel: ticketsModel,
                      context: context,
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                          new CupertinoPageRoute(
                            fullscreenDialog: true,
                            builder: (context) {
                              return TicketReceipt(
                                logo: x.busSchedule.station.busCompany.logo,
                                to: x.busSchedule.route.to.name,
                                from: x.busSchedule.route.from.name,
                                busRegNumber: x.busSchedule.bus.regNumber,
                                driverName: x.busSchedule.bus.driver.user.name,
                                driverPhoneNumber:
                                    x.busSchedule.bus.driver.user.phone,
                                conductorName: x.busSchedule.conductor != null
                                    ? x.busSchedule.conductor.user.name
                                    : "",
                                conductorPhoneNumber:
                                    x.busSchedule.conductor != null
                                        ? x.busSchedule.conductor.user.phone
                                        : "",
                                amount: "${x.price}",
                                seatNumber:
                                    x.seat != null ? "${x.seat.number}" : "",
                                ticketNo: x.ticketNo,
                                stationName: x.busSchedule.station.name,
                                stationPhoneNumber: x.busSchedule.station.phone,
                                tripDate: x.busSchedule.departureDate,
                                tripTime: x.busSchedule.departureTime,
                                ice1Phone: icePrimaryPhone,
                                userName: userName,
                                userPhoneNumber: userPhone,
                              );
                            },
                          ),
                        );
                      },
                      to: x.busSchedule.route.to.name,
                      from: x.busSchedule.route.from.name,
                      pmtStatus: x.pmtStatus,
                      tripDate: x.busSchedule.departureDate,
                      tripTime: x.busSchedule.departureTime,
                      busRegNumber: x.busSchedule.bus.regNumber,
                    )
                ],
              ),
            ),
          ],
        ),
      );
    else
      return Tickets();
  }
}
