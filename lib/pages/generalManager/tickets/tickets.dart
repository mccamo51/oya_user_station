import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/bloc/ticketBloc.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/emptyBox.dart';
import 'package:oya_porter/config/offlineData.dart';
import 'package:oya_porter/models/ticketModel.dart';
import 'package:oya_porter/spec/colors.dart';


class TicketPage extends StatefulWidget {
  final id;
  TicketPage({@required this.id});
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  @override
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 3));
    ticketBloc.fetchAllTicket(widget.id);

    return null;
  }

  void initState() {
    // TODO: implement initState
    ticketBloc.fetchAllTicket(widget.id);
    loadallTicketsOffline();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: ("Tickets"),
      ),
      body: RefreshIndicator(
        onRefresh: refreshList,
        key: refreshKey,
        child: StreamBuilder(
          stream: ticketBloc.allTickets,
          initialData: ticketMapOffline == null
              ? null
              : TicketsModel.fromJson(ticketMapOffline),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            print("snapshot: ${snapshot.data}");
            if (snapshot.hasData) {
              return _mainContent(snapshot.data);
            } else if (snapshot.hasError) {
              return Scaffold(body: emptyBox(context));
            }
            return Center(
              child: CupertinoActivityIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _mainContent(TicketsModel model) {
    if (model.data != null && model.data.length > 0)
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  for (var x in model.data)
                    _itemTile(
                        from: x.busSchedule.route.from.name,
                        to: x.busSchedule.route.to.name,
                        depTime: x.busSchedule.departureTime,
                        depDate: x.busSchedule.departureDate,
                        regNo: x.busSchedule.bus.regNumber,
                        company: x.busSchedule.bus.busCompany.name)
                ],
              ),
            ),
          ],
        ),
      );
    else
      return emptyBox(context);
  }
}

_itemTile({
  String company,
  String from,
  to,
  regNo,
  depTime,
  depDate,
}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Icon(Icons.car_repair),
          title: Text("$company $from $to ($regNo)"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$company $from $to"),
              Text("Departure: $depDate \n@ $depTime"),
            ],
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.delete_forever,
              color: RED,
            ),
            onPressed: () {},
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Divider(),
      )
    ],
  );
}
