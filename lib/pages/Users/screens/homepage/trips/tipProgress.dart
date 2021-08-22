// import 'package:flutter/material.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// // import 'package:geolocator/geolocator.dart';
// import 'package:location/location.dart';
// import 'package:oya_mobile/config/button.dart';
// import 'package:oya_mobile/config/functions.dart';
// import 'package:oya_mobile/spec/colors.dart';
// import 'package:oya_mobile/spec/styles.dart';
// import 'package:oya_mobile/utils/map.dart';
// import 'package:share/share.dart';
// import 'dart:math' show cos, sqrt, asin, pow;

// import 'functions/currentLocationAddress.dart';

// class TripProgress extends StatefulWidget {
//   final String fromlongitde;
//   final String tolongitde;
//   final String fromlatitud;
//   final String tolatitud;
//   final String destination;
//   final double currentLog, currentLat;

//   TripProgress({
//     @required this.fromlongitde,
//     @required this.fromlatitud,
//     @required this.tolongitde,
//     @required this.tolatitud,
//     @required this.destination,
//     @required this.currentLat,
//     @required this.currentLog,
//   });

//   @override
//   _TripProgressState createState() => _TripProgressState();
// }

// class _TripProgressState extends State<TripProgress> {
//   bool _serviceEnabled;
//   Location location = new Location();
//   PermissionStatus _permissionGranted;
//   LocationData currentLocation, currentLocations;
//   double distance;
//   double currentLong, curentLat;
//   // final Geolocator geolocator = Geolocator();

//   Future<void> _getCurrentLocation() async {
//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }

//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }

//     _currentLoc();
//   }

//   initState() {
//     super.initState();
//     curentLat = widget.currentLat;
//     currentLong = widget.currentLog;
//     _getCurrentLocation();

//     distance = calculateDistance(
//         cos: cos,
//         sqrt: sqrt,
//         asin: asin,
//         data: [
//           {"lat": curentLat, "lng": currentLong},
//           {
//             "lat": double.parse(widget.tolatitud),
//             "lng": double.parse(widget.tolongitde)
//           },
//         ],
//         pow: pow);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   customBack(context, "Back"),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 40.0),
//                     child: OutlineButton(
//                         borderSide: BorderSide(color: PRIMARYCOLOR),
//                         onPressed: () => _share(),
//                         child: Text("Share Progress",
//                             style: TextStyle(color: PRIMARYCOLOR))),
//                   )
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Journey",
//                     style: h3Black,
//                   ),
//                   SizedBox(height: 15),
//                   CurrentLocationName(lat: curentLat, log: currentLong),
//                   SizedBox(height: 15),
//                   _rowItem(currentLoc: "${widget.destination}", approach: true),
//                   SizedBox(height: 15),
//                   Row(
//                     children: [
//                       Icon(FeatherIcons.clock, color: ASHDEEP),
//                       SizedBox(width: 20),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Estimated Distance to Destination",
//                               style: TextStyle(color: ASHDEEP)),
//                           SizedBox(height: 5),
//                           Text("$distance km", style: TextStyle(color: BLACK)),
//                         ],
//                       )
//                     ],
//                   ),
//                   SizedBox(height: 30),
//                   if (widget.fromlatitud != "null" &&
//                       widget.fromlongitde != "null" &&
//                       widget.tolatitud != "null" &&
//                       widget.tolongitde != "null") ...[
//                     Text("Trip Route", style: h3Black),
//                     SizedBox(height: 10),
//                     Container(
//                       height: 450,
//                       width: MediaQuery.of(context).size.width,
//                       child: GoogleMapPage(
//                         fromlatitud: widget.fromlatitud,
//                         fromlongitde: widget.fromlongitde,
//                         tolatitud: widget.tolatitud,
//                         tolongitde: widget.tolongitde,
//                         liveLocation: true,
//                       ),
//                     ),
//                   ],
//                   if (widget.fromlatitud == "null" &&
//                       widget.fromlongitde == "null" &&
//                       widget.tolatitud == "null" &&
//                       widget.tolongitde == "null")
//                     Container(
//                         padding: EdgeInsets.symmetric(vertical: 50),
//                         alignment: Alignment.center,
//                         child: Text("Error loading map", style: h3Red)),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   _share() async {
//     currentLocation = await location.getLocation();
//     Share.share(
//         'https://www.google.com/maps/search/?api=1&query=${currentLocation.latitude},${currentLocation.longitude}');
//   }

//   Future<void> _currentLoc() async {
//     location.onLocationChanged.listen((LocationData cLoc) {
//       setState(() {
//         currentLocation = cLoc;
//         currentLong = currentLocations.longitude;
//         curentLat = currentLocations.latitude;
//       });
//     });
//   }

//   _rowItem({
//     String currentLoc,
//     bool approach = false,
//   }) {
//     return Row(
//       children: [
//         Icon(FeatherIcons.truck, color: ASHDEEP),
//         SizedBox(
//           width: 20,
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             approach
//                 ? Text("Approaching", style: TextStyle(color: ASHDEEP))
//                 : Text("Current Location", style: TextStyle(color: ASHDEEP)),
//             SizedBox(height: 5),
//             Text("$currentLoc", style: TextStyle(color: PRIMARYCOLOR)),
//           ],
//         )
//       ],
//     );
//   }
// }
