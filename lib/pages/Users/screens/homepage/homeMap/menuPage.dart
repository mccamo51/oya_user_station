// import 'package:flutter/material.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:oya_mobile/config/navigation.dart';
// import 'package:oya_mobile/screens/homepage/parcels/parcelsRecieved.dart';
// import 'package:oya_mobile/screens/homepage/parcels/parcelsSent.dart';
// import 'package:oya_mobile/screens/homepage/rentBus/rentBus.dart';
// import 'package:oya_mobile/screens/homepage/rentBus/specialHire.dart';
// import 'package:oya_mobile/screens/homepage/trips/enrollTrip.dart';
// import 'package:oya_mobile/spec/colors.dart';
// import 'package:oya_mobile/spec/styles.dart';

// // bool buyTicketForOthers = false;

// class ItemMenu extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Menu"),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Container(
//         child: SingleChildScrollView(
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 8.0),
//               child: Wrap(
//                 spacing: 10,
//                 runSpacing: 10,
//                 children: [
//                   item(
//                       icon: Icons.home,
//                       title: "Buy a Ticket",
//                       onFunc: () => _onBuyTicket(context)),
//                   item(
//                     icon: Icons.receipt,
//                     title: "My Tickets",
//                     onFunc: () =>
//                         navigation(context: context, pageName: "tickets"),
//                   ),
//                   item(
//                     icon: FeatherIcons.bookOpen,
//                     title: "Enrol on a bus",
//                     onFunc: () => _onEnrollBus(context),
//                   ),
//                   item(
//                       icon: FeatherIcons.truck,
//                       title: "Rent a bus",
//                       onFunc: () => _onHireBus(context)),
//                   item(
//                     icon: Icons.wallet_travel,
//                     title: "Trips",
//                     onFunc: () =>
//                         navigation(context: context, pageName: "trips"),
//                   ),
//                   item(
//                     icon: FeatherIcons.gift,
//                     title: "Parcel Service",
//                     onFunc: () => _onParcelService(context),
//                   ),
//                   item(
//                     icon: Icons.shield,
//                     title: "Local Travel Insurance",
//                     onFunc: () =>
//                         navigation(context: context, pageName: "insurance"),
//                   ),
//                   item(
//                     icon: Icons.dashboard,
//                     title: "More",
//                     onFunc: () =>
//                         navigation(context: context, pageName: "more"),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _onParcelService(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => SimpleDialog(
//         title: Text('Parcels'),
//         children: [
//           ListTile(
//             title: Text('Parcels Sent', style: h3Black),
//             trailing: Icon(Icons.arrow_forward_ios),
//             onTap: () => Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => ParcelSent(),
//               ),
//             ),
//           ),
//           ListTile(
//             title: Text('Parcels Recieved', style: h3Black),
//             trailing: Icon(Icons.arrow_forward_ios),
//             onTap: () => Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => ParcelRecieved(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _onEnrollBus(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => SimpleDialog(
//         title: Text('Enrol on Bus'),
//         children: [
//           ListTile(
//             title: Text('Ticket Enrolment', style: h3Black),
//             trailing: Icon(Icons.arrow_forward_ios),
//             onTap: () => Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => EnrollTrip(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _onHireBus(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => SimpleDialog(
//         title: Text('Rent a Bus'),
//         children: [
//           ListTile(
//             title: Text('Normal Hiring', style: h3Black),
//             trailing: Icon(Icons.arrow_forward_ios),
//             onTap: () => Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => RentBus(),
//               ),
//             ),
//           ),
//           ListTile(
//             title: Text('Special Hiring', style: h3Black),
//             trailing: Icon(Icons.arrow_forward_ios),
//             onTap: () => Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => SpecialHire(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _onBuyTicket(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => SimpleDialog(
//         title: Text('Buy Ticket'),
//         children: [
//           Divider(),
//           ListTile(
//             title: Text('Buy for Self', style: h3Black),
//             trailing: Icon(Icons.arrow_forward_ios),
//             onTap: () {
//               buyTicketForOthers = false;
//               navigation(context: context, pageName: "rentals");
//             },
//           ),
//           ListTile(
//             title: Text('Buy for others', style: h3Black),
//             trailing: Icon(Icons.arrow_forward_ios),
//             onTap: () {
//               buyTicketForOthers = true;
//               navigation(context: context, pageName: "rentals");
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// item({IconData icon, String title, Function onFunc}) {
//   return Card(
//     child: GestureDetector(
//       onTap: onFunc,
//       child: Container(
//         width: 150,
//         // he
//         padding: EdgeInsets.symmetric(vertical: 15),
//         child: Column(
//           children: [
//             Icon(
//               icon,
//               color: PRIMARYCOLOR,
//               size: 50,
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Text(
//               '$title',
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//           ],
//           // trailing: Icon(
//           //   Icons.arrow_forward_ios,
//           //   size: 15,
//           // ),
//         ),
//       ),
//     ),
//   );
// }
