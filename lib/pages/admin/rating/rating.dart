import 'package:flutter/material.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'widgets/ratingWidget.dart';

enum TabSelect { report, rating }

class Rating extends StatefulWidget {
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  TabSelect selectTab = TabSelect.rating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: ("Rating"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Container(
                height: 47,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: PRIMARYCOLOR)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectTab = TabSelect.rating;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.47,
                        height: 47,
                        decoration: BoxDecoration(
                            color: selectTab == TabSelect.rating
                                ? PRIMARYCOLOR
                                : WHITE,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(9),
                                topLeft: Radius.circular(9))),
                        child: Center(
                            child: Text(
                          "RATINGS",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: selectTab == TabSelect.rating
                                ? WHITE
                                : PRIMARYCOLOR,
                          ),
                        )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectTab = TabSelect.report;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.47,
                        height: 47,
                        decoration: BoxDecoration(
                          color: selectTab == TabSelect.report
                              ? PRIMARYCOLOR
                              : WHITE,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(9),
                            topRight: Radius.circular(9),
                          ),
                        ),
                        child: Center(
                            child: Text(
                          "SPEED REPORTING",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: selectTab == TabSelect.report
                                ? WHITE
                                : PRIMARYCOLOR,
                          ),
                        )),
                      ),
                    )
                  ],
                ),
              ),
            ),
            selectTab == TabSelect.report
                ? Column(children: [
                    itemTileReport(),
                    itemTileReport(),
                    itemTileReport(),
                    itemTileReport(),
                  ])
                : Column(children: [
                    itemTile(),
                    itemTile(),
                    itemTile(),
                    itemTile(),
                  ])
          ],
        ),
      ),
    );
  }
}
