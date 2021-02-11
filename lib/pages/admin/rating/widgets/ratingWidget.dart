
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

itemTileReport() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
        child: Column(
      children: [
        Text("GT-12344 2010"),
        Text("From Accra to Kumasi"),
        Text("Sunday, 10th Feb, 2020. 10:20pm"),
        Divider(),
        Text("Name: Kofi Ntoh"),
        Text("Phone: 023456788"),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Speed: 1.8Km/h"),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        )
      ],
    )),
  );
}

itemTile() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
        child: Column(
      children: [
        Text("GT-12344 2010"),
        Text("From Accra to Kumasi"),
        Text("Sunday, 10th Feb, 2020. 10:20pm"),
        Divider(),
        Text("Name: Kofi Ntoh"),
        Text("Phone: 023456788"),
        SmoothStarRating(
            allowHalfRating: false,
            onRated: (v) {},
            starCount: 5,
            rating: 5,
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
    )),
  );
}
