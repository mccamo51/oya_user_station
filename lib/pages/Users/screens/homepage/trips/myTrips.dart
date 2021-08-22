import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/components/emptyPage.dart';
import 'package:oya_porter/components/shimmerLoading.dart';
import 'package:oya_porter/pages/Users/bloc/tripsBloc.dart';
import 'package:oya_porter/pages/Users/config/offlineData.dart';
import 'package:oya_porter/pages/Users/model/tripModel.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/styles.dart';

import 'enrollTrip.dart';
import 'tripDetails.dart';
import 'trips.dart';
import 'widgets/myTripsWidget.dart';

class MyTrips extends StatefulWidget {
  @override
  _MyTripsState createState() => _MyTripsState();
}

class _MyTripsState extends State<MyTrips> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 5));
    tripsBloc.fetchAllTrips(context);

    return null;
  }

  @override
  void initState() {
    loadallAllTripsOffline();
    tripsBloc.fetchAllTrips(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARYCOLOR,
        iconTheme: IconThemeData(color: WHITE),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My Trips",
              style: TextStyle(color: Colors.white),
            ),
            FlatButton(
              onPressed: _onEnrollBus,
              color: WHITE,
              textColor: PRIMARYCOLOR,
              child: Text("Enrol on Bus"),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: refreshList,
          key: refreshKey,
          child: StreamBuilder(
            stream: tripsBloc.alltrips,
            initialData: allTripsMapOffline == null
                ? null
                : TripsModel.fromJson(allTripsMapOffline),
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

  Widget _mainContent(TripsModel tripsModel) {
    print(tripsModel.data);
    if (tripsModel.data != null && tripsModel.data.length > 0)
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  for (var x in tripsModel.data)
                    myTripsWidget(
                        context: context,
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                            new CupertinoPageRoute(
                              fullscreenDialog: true,
                              builder: (context) {
                                return TripDetails(
                                  id: '${x.busSchedule.id}',
                                  fromTo:
                                      '${x.busSchedule.route.from.name} - ${x.busSchedule.route.to.name}',
                                  numberOfPass: '${x.onboard}',
                                  price: '${x.busSchedule.price}',
                                  transportCompany:
                                      '${x.busSchedule.bus.busCompany.name}',
                                  tripDate: '${x.busSchedule.departureDate}',
                                  tripTime: '${x.busSchedule.departureTime}',
                                  fromlatitud:
                                      '${x.busSchedule.route.from.latitude}',
                                  fromlongitde:
                                      '${x.busSchedule.route.from.longitude}',
                                  tolatitud:
                                      '${x.busSchedule.route.to.longitude}',
                                  tolongitde:
                                      '${x.busSchedule.route.to.latitude}',
                                  to: "${x.busSchedule.route.to.name}",
                                  from: "${x.busSchedule.route.from.name}",
                                  manifestCode: "${x.manifestCode}",
                                );
                              },
                            ),
                          );
                        },
                        tripsModel: tripsModel,
                        from: '${x.busSchedule.route.from.name}',
                        carNo: '${x.busSchedule.bus.regNumber}',
                        companyName: '${x.busSchedule.bus.busCompany.name}',
                        departireDate: '${x.busSchedule.departureDate}',
                        price: '${x.busSchedule.price}',
                        status: '',
                        to: '${x.busSchedule.route.to.name}'),
                ],
              ),
            ),
          ],
        ),
      );
    else
      return Trips();
  }

  void _onEnrollBus() {
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
}
