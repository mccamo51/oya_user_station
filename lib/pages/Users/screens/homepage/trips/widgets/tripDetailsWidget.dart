import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/components/ratingStars.dart';
import 'package:oya_porter/config/button.dart';
import 'package:oya_porter/pages/Users/screens/homepage/speedometer/speedoPaint.dart';
import 'package:oya_porter/pages/Users/screens/homepage/trips/widgets/ratingDialog.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/styles.dart';

Widget tripDetailsWidget({
  @required BuildContext context,
  @required Function onTrip,
  @required String fromTo,
  @required String from,
  @required String to,
  @required String price,
  @required String transportCompany,
  @required String noPassenger,
  @required String tripDate,
  @required String tripTime,
  @required Function(double rating) onRating,
  @required TextEditingController commentController,
  @required FocusNode commentfocus,
  // @required Widget map,
  String ticketNo,
  String seatNumbers,
  String busRegNumbers,
  String stationNames,
  String driverNames,
  String driverPhoneNumbers,
  String conductorPhoneNumbers,
  String conductorNames,
  String stationPhoneNumbers,
  @required String id,
  // @required void Function() onShare,
}) {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customBack(context, "Trip Details"),
            ],
          ),
        ),
        ListTile(
          title: Text("$fromTo", style: h3Black),
          trailing: Text("GHS$price", style: h3Black),
        ),
        ListTile(
          leading: Icon(FeatherIcons.truck, color: ICONCOLOR),
          title: Text("Transport Company", style: h4Black),
          subtitle: Text("$transportCompany", style: h3Black),
          dense: true,
        ),
        ListTile(
          leading: Icon(FeatherIcons.users, color: ICONCOLOR),
          title: Text("Passengers", style: h4Black),
          subtitle: Text("$noPassenger adults", style: h3Black),
          dense: true,
        ),
        ListTile(
          leading: Icon(FeatherIcons.calendar, color: ICONCOLOR),
          title: Text("Trip Date", style: h4Black),
          subtitle: Text("$tripDate, $tripTime", style: h3Black),
          dense: true,
        ),
        _reporting(
            context: context,
            onTripProgress: onTrip,
            // onShare: onShare,
            busScheduleId: id),
        _ratings(
            context: context,
            onRating: (rating) => onRating,
            controller: commentController,
            focus: commentfocus),
        // map == null ? null : _route(map),
      ],
    ),
  );
}

// Widget _route(Widget map) {
//   return Container(
//     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Trip Route", style: h5BlackBold),
//         SizedBox(height: 10),
//         map,
//       ],
//     ),
//   );
// }

Widget _ratings(
    {BuildContext context,
    Function(double rating) onRating,
    TextEditingController controller,
    FocusNode focus}) {
  return Container(
    color: WHITE,
    // height: 100,
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Trip Ratings", style: h5BlackBold),
        SizedBox(height: 10),
        ratingStar(
          function: (double rating) {
            print(rating);
            Platform.isIOS
                ? iosRatingDialog(
                    commentController: controller,
                    commentFocus: focus,
                    context: context,
                    star: "$rating",
                    submit: onRating(rating),
                    rate: rating.toString(),
                  )
                : ratingDialog(
                    commentController: controller,
                    commentFocus: focus,
                    context: context,
                    star: "$rating",
                    submit: onRating(rating));
          },
          rate: 0,
        ),
      ],
    ),
  );
}

Widget _reporting({
  @required BuildContext context,
  @required Function onTripProgress,
  // @required Function onShare,
  @required String busScheduleId,
}) {
  return Container(
    color: BACKREDCOLOR,
    height: 150,
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Reporting", style: h5BlackBold),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // _reportingButton(
            //   icon: Icons.share,
            //   onTap: () => onShare(),
            //   text: "Share Trip",
            //   context: context,
            // ),
            _reportingButton(
              icon: Icons.speed_sharp,
              onTap: () {
                final Map<String, dynamic> data = new Map<String, dynamic>();
                data['busScheduleId'] = busScheduleId;
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SpeedometerContainer(
                      busScheduleId: busScheduleId,
                    ),
                  ),
                );
              },
              text: "Speed Report",
              context: context,
            ),
            // _reportingButton(
            //   icon: Icons.location_searching,
            //   onTap: onTripProgress,
            //   text: "Share Progress",
            //   context: context,
            // ),
          ],
        ),
      ],
    ),
  );
}

Widget _reportingButton({
  @required void Function() onTap,
  @required IconData icon,
  @required String text,
  @required BuildContext context,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: MediaQuery.of(context).size.width * .3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
                padding: const EdgeInsets.all(10),
                color: LIGHTRED.withOpacity(.4),
                child: Icon(icon, color: RED)),
          ),
          SizedBox(height: 10),
          Text("$text", style: h4Red),
        ],
      ),
    ),
  );
}

rowItem({IconData icon, String title, String subTitle}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        Icon(icon, color: PRIMARYCOLOR),
        SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$title"),
            SizedBox(
              height: 4,
            ),
            Text("$subTitle"),
          ],
        )
      ],
    ),
  );
}
