import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/pages/admin/tickets/addTickets.dart';
import 'package:oya_porter/pages/porter/homePage/account/account.dart';
import 'package:oya_porter/pages/porter/homePage/dashboard.dart';
import 'package:oya_porter/pages/porter/homePage/graph/graphScreen.dart';
import 'package:oya_porter/pages/porter/homePage/home/homePagePorter.dart';
import 'package:oya_porter/pages/porter/homePage/parcels/parcels.dart';
import 'package:oya_porter/pages/porter/homePage/schedule/porterSchedules.dart';
import 'package:oya_porter/spec/colors.dart';

class PorterHomePage extends StatefulWidget {
  @override
  _PorterHomePageState createState() => _PorterHomePageState();
}

class _PorterHomePageState extends State<PorterHomePage> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    HomePagePorter(),
    PorterSchedule(
      isSchedule: true,
    ),
    AddTicket(),
    Parcels(),
    // DashBoard(),
    Account(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Trips'),
          ),
          BottomNavigationBarItem(
            icon: Icon(FeatherIcons.list),
            title: Text('Ticket'),
          ),
          BottomNavigationBarItem(
            icon: Icon(FeatherIcons.box),
            title: Text('Parcels'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: Text('Account'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: PRIMARYCOLOR,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
