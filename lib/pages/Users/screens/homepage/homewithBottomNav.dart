// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:oya_porter/pages/Users/screens/homepage/rentBus/rentBus.dart';
// import 'package:oya_porter/pages/Users/screens/homepage/trips/myTrips.dart';
// import 'more/more.dart';
// import 'ticket/ticketing.dart';

// // ignore: must_be_immutable
// class HomePageWithBottomNav extends StatelessWidget {
//   final index;
//   HomePageWithBottomNav({this.index = 0});

//   List<Widget> _widgetOptions = <Widget>[
//     Ticketing(),
//     RentBus(),
//     MyTrips(),
//     More(),
//   ];

  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Platform.isIOS
//               ? IOSHomepagePatient(
//                   pageOptions: _widgetOptions,
//                   intex: index,
//                 )
//               : AndroidPatientHomePage(
//                   pageOptions: _widgetOptions,
//                   selectedIntex: index,
//                 ),
//           // if (_showRestartDialog)
//           //   Container(
//           //     height: MediaQuery.of(context).size.height,
//           //     width: MediaQuery.of(context).size.width,
//           //     color: BLACK.withOpacity(.6),
//           //   ),
//         ],
//       ),
//     );
//   }
// }
