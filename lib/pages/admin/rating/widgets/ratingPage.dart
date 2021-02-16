import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/bloc/ratingBloc.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/emptyBox.dart';
import 'package:oya_porter/config/offlineData.dart';
import 'package:oya_porter/models/ratingModel.dart';
import 'package:oya_porter/pages/admin/rating/widgets/ratingWidget.dart';

class RatingPage extends StatefulWidget {
  final id;
  RatingPage({this.id});
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAllRatingOffline();
    ratingBloc.fetchAllStaffs(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ratingBloc.allRating,
      initialData: allRatingMapOffline == null
          ? null
          : RatingModel.fromJson(allRatingMapOffline),
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
    );
  }

  Widget _mainContent(RatingModel ratingModel) {
    // print(bussModel.data);
    if (ratingModel.data != null && ratingModel.data.length > 0)
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
                  for (var x in ratingModel.data)
                    itemTile(
                      name: "${x.busSchedule.driver.user.name}",
                      phone: "${x.busSchedule.driver.user.phone}",
                      carNo: x.busSchedule.bus.regNumber,
                      from: x.busSchedule.route.from.name,
                      to: x.busSchedule.route.to.name,
                      datTime: x.createdAt,
                      rating: double.parse(x.rating),
                    )
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
