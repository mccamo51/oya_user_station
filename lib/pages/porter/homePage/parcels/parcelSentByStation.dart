import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/bloc/parcelSentBloc.dart';
import 'package:oya_porter/bloc/staffBloc.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/emptyBox.dart';
import 'package:oya_porter/config/offlineData.dart';
import 'package:oya_porter/models/parcelByPorter.dart';
import 'package:oya_porter/models/stuffModel.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/colors.dart';

class ParcelSent extends StatefulWidget {
  @override
  _ParcelSentState createState() => _ParcelSentState();
}

class _ParcelSentState extends State<ParcelSent> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 3));
    parcelSentBloc.fetchAllParcelSent(stationId);

    return null;
  }

  @override
  void initState() {
    parcelSentBloc.fetchAllParcelSent(stationId);
    loadParcelSentOffline();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: ("Parcel Sent"),
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: refreshList,
        child: StreamBuilder(
          stream: parcelSentBloc.parcelsent,
          initialData: loadParcelSentMapOffline == null
              ? null
              : ParcelSentUserModel.fromJson(loadParcelSentMapOffline),
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

  Widget _mainContent(ParcelSentUserModel staffModel) {
    if (staffModel.data != null && staffModel.data.length > 0)
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
                  for (var x in staffModel.data)
                    _itemTile(
                        name: x.user.name,
                        reciever: x.user.phone,
                        price: x.price.toString(),
                        item: x.name,
                        onFunction: () => _alertWidget(
                            context: context,
                            img: x.image,
                            senderPhone: x.user.phone,
                            sender: x.user.name,
                            stationName: x.station.name,
                            reciever: x.recipient.name,
                            price: x.price.toString(),
                            recPhone: x.recipient.phone,
                            itemName: x.name))
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

_itemTile(
    {@required String name,
    @required String reciever,
    @required String price,
    String item,
    Function onFunction}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          onTap: onFunction,
          leading: Icon(Icons.transfer_within_a_station),
          title: Text("Sender: $name"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Reciever: $reciever"),
              Text("Item Name: $item"),
            ],
          ),
          trailing: Container(
            width: 80,
            child: Row(
              children: [
                Text("GH$price"),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                ),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Divider(),
      )
    ],
  );
}

_alertWidget(
    {BuildContext context,
    String img,
    String itemName,
    String sender,
    reciever,
    price,
    stationName,
    recPhone,
    senderPhone}) {
  return showDialog(
    builder: (context) => AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: double.infinity,
            child: Image.network("https://api.oyaghana.dev/$img"),
          ),
          Divider(),
          Text("Item Name: $itemName"),
          Text("Sender's Name: $sender"),
          Text("Sender's Phone: $senderPhone"),
          Text("Reciever Name: $reciever"),
          Text("Reciever Phone: $recPhone"),
          Text("Station: $stationName"),
          Text("Price: $price"),
        ],
      ),
    ),
    context: context,
  );
}
