// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:oya_mobile/components/textField.dart';
// import 'package:oya_mobile/spec/colors.dart';
// import 'package:oya_mobile/spec/styles.dart';

// Widget buyForSelfOthersWidget({
//   @required BuildContext context,
//   @required bool showMomo = false,
//   @required Function onSelectPaymentMode,
//   @required Function onSelectPaymentType,
//   @required Function onDestination,
//   @required TextEditingController fullnameController,
//   @required TextEditingController destinationController,
//   @required TextEditingController busNumberController,
//   @required TextEditingController iceController,
//   @required TextEditingController stationController,
//   @required TextEditingController paymentTypeController,
//   @required TextEditingController paymentModeController,
// }) {
//   return Scaffold(
//     appBar: AppBar(
//       backgroundColor: PRIMARYCOLOR,
//       centerTitle: true,
//       iconTheme: IconThemeData(color: WHITE),
//       elevation: 0,
//       title: Text(
//         "Local Travel Insurance",
//         style: TextStyle(color: Colors.white),
//       ),
//     ),
//     body: SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: EdgeInsets.all(8),
//             child: Text(
//               'Buy for Self and Others',
//               style: h2Black,
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           textFormField(
//             hintText: "Fullname",
//             controller: fullnameController,
//             focusNode: null,
//             // labelText: "Item Name",
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           textFormField(
//             hintText: "ICE's Phone",
//             controller: iceController,
//             focusNode: null,
//             labelText: "ICE's Phone",
//             inputType: TextInputType.number,
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           textFormField(
//             hintText: "Vehicle Number",
//             controller: busNumberController,
//             focusNode: null,
//             labelText: "Vehicle Number",
//             inputType: TextInputType.text,
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           textFormField(
//             hintText: "Station Name",
//             controller: stationController,
//             focusNode: null,
//             labelText: "Station Name",
//             inputType: TextInputType.number,
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           GestureDetector(
//             onTap: onDestination,
//             child: textFormField(
//               hintText: "Select Destination",
//               controller: destinationController,
//               focusNode: null,
//               enable: false,
//               labelText: "Select Destination",
//               // icon: Icons.calendar_today,
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           GestureDetector(
//             onTap: onSelectPaymentType,
//             child: textFormField(
//               hintText: "Select Payment Type",
//               controller: paymentTypeController,
//               focusNode: null,
//               enable: false,
//               labelText: "Select Payment Type",
//               icon: Icons.money,
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Visibility(
//             visible: showMomo,
//             child: GestureDetector(
//               onTap: onSelectPaymentMode,
//               child: textFormField(
//                 hintText: "Select Payment Mode",
//                 controller: paymentModeController,
//                 focusNode: null,
//                 enable: false,
//                 labelText: "Select Payment Mode",
//                 // icon: Icons.calendar_today,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 30,
//           ),
//           Center(
//             child: CupertinoButton(
//               color: PRIMARYCOLOR,
//               child: Text("Proceed"),
//               onPressed: () {},
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }
