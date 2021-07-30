import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

itemTileReport(
    {String carNo,
    String from,
    String to,
    String datTime,
    String name,
    String phone,
    String speed}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
          children: [
              Text("$carNo"),
              Text("From $from to $to"),
              Text("$datTime"),
              Divider(),
              Text("Name: $name"),
              Text("Phone: $phone"),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Speed: $speed Km/h"),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              )
          ],
        ),
            )),
      ),
      // Padding(
      //   padding: const EdgeInsets.only(left: 25.0),
      //   child: Divider(),
      // )
    ],
  );
}

itemTile(
    {String carNo,
    String from,
    String to,
    String datTime,
    String name,
    String phone,
    rating}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("$carNo"),
              Text("From $from to $to"),
              Text("$datTime"),
              Divider(),
              Text("Name: $name"),
              Text("Phone: $phone"),
              SmoothStarRating(
                  allowHalfRating: false,
                  onRated: (v) {},
                  starCount: 5,
                  rating: rating,
                  size: 40.0,
                  isReadOnly: true,
                  // fullRatedIconData: Icons.blur_off,
                  // halfRatedIconData: Icons.blur_on,
                  color: Colors.green,
                  borderColor: Colors.green,
                  spacing: 0.0),
              SizedBox(
                height: 10,
              )
            ],
          ),
        )),
      ),
      // Padding(
      //   padding: const EdgeInsets.only(left: 25.0),
      //   child: Divider(),
      // )
    ],
  );
}
