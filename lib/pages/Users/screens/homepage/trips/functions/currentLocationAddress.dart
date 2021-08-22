// import 'package:flutter/material.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:oya_mobile/spec/colors.dart';

// class CurrentLocationName extends StatefulWidget {
//   final double log, lat;

//   CurrentLocationName({
//     @required this.lat,
//     @required this.log,
//   });

//   @override
//   _CurrentLocationNameState createState() => _CurrentLocationNameState();
// }

// class _CurrentLocationNameState extends State<CurrentLocationName> {
//   String currentLocationName;

//   initState() {
//     super.initState();
//     _curentLocationAddress();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("lat ${widget.lat}");
//     print("lat ${widget.log}");
//     return Row(
//       children: [
//         Icon(FeatherIcons.truck, color: ASHDEEP),
//         SizedBox(width: 20),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Current Location", style: TextStyle(color: ASHDEEP)),
//             SizedBox(height: 5),
//             Text("$currentLocationName", style: TextStyle(color: PRIMARYCOLOR)),
//           ],
//         )
//       ],
//     );
//   }

//   Future<void> _curentLocationAddress() async {
//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(widget.lat, widget.log);
//     Placemark place = placemarks[0];
//     print(
//         "currentLocation ${place.locality}, ${place.postalCode}, ${place.country}");
//     setState(() {
//       currentLocationName =
//           "${place.locality} ${place.country}";
//     });
//   }
// }
