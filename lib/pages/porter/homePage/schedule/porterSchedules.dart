import 'package:flutter/material.dart';
import 'package:oya_porter/pages/admin/schedules/widgets/addScheduleWidget.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/pages/porter/homePage/schedule/widgets/loadedBuses.dart';
import 'package:oya_porter/pages/porter/homePage/schedule/widgets/scheduleBus.dart';

class PorterSchedule extends StatefulWidget {
  final bool isSchedule;
  PorterSchedule({@required this.isSchedule = false});
  @override
  _PorterScheduleState createState() => _PorterScheduleState();
}

class _PorterScheduleState extends State<PorterSchedule>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  int _selectedIndex = 0;

  List<Widget> list = [
    Tab(text: "Schedules Buses".toUpperCase()),
    Tab(text: "Loaded Buses".toUpperCase()),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: list.length, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedules"),
        elevation: 0.0,
        centerTitle: true,
        actions: [
          widget.isSchedule
              ? IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Schedules()));
                  })
              : Container(
                  height: 0,
                  width: 0,
                )
        ],
        bottom: TabBar(
          onTap: (index) {},
          controller: _controller,
          tabs: list,
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          ScheduledBus(
            stationId: stationId.toString(),
          ),
          LoadedBuses(
            stationId: stationId.toString(),
          ),
        ],
      ),
    );
  }
}
