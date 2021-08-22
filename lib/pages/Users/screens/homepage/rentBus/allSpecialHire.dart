import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/components/emptyPage.dart';
import 'package:oya_porter/pages/Users/bloc/specialHiringBloc.dart';
import 'package:oya_porter/pages/Users/config/offlineData.dart';
import 'package:oya_porter/pages/Users/model/specialHiringModel.dart';
import 'package:oya_porter/pages/Users/screens/homepage/rentBus/specialHire.dart';
import 'package:oya_porter/spec/colors.dart';

class AllSpecialHiring extends StatefulWidget {
  @override
  _AllSpecialHiringState createState() => _AllSpecialHiringState();
}

class _AllSpecialHiringState extends State<AllSpecialHiring> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 5));
    // ticketsBloc.fetchAllTickets();

    return null;
  }

  @override
  void initState() {
    loadallSpecialHireOffline();
    specialHiringBloc.fetchCongregation(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARYCOLOR,
        elevation: 0,
        iconTheme: IconThemeData(color: WHITE),
        centerTitle: true,
        title: Text(
          "Special Hire",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: refreshList,
          key: refreshKey,
          child: StreamBuilder(
            stream: specialHiringBloc.specialHiring,
            initialData: specialHireMapOffline == null
                ? null
                : SpecialHiringModel.fromJson(specialHireMapOffline),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return _mainContent(snapshot.data);
              } else if (snapshot.hasError) {
                return Scaffold(body: EmptyPage());
              }
              return Center(
                child: CupertinoActivityIndicator(),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARYCOLOR,
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => SpecialHire())),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _mainContent(SpecialHiringModel ticketsModel) {
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
                    ListTile(
                      title: Text(x.user.name),
                    )
                ],
              ),
            ),
          ],
        ),
      );
    else
      return Scaffold(body: EmptyPage());
  }
}
