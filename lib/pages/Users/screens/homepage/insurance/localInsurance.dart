// import 'package:flutter/material.dart';
// import 'package:oya_mobile/spec/styles.dart';
// import 'widget/localInsuranceWidget.dart';

// class Insurance extends StatefulWidget {
//   @override
//   _InsuranceState createState() => _InsuranceState();
// }

// class _InsuranceState extends State<Insurance> {
//   final fullNameController = TextEditingController();
//   final icephoneController = TextEditingController();
//   final stationController = TextEditingController();
//   final paymentTypeController = TextEditingController();
//   final paymentModeController = TextEditingController();
//   final destinationController = TextEditingController();
//   final busNumberController = TextEditingController();
//   bool _showMomo = false;
//   String network = "", payType = "";
//   @override
//   Widget build(BuildContext context) {
//     return localInsuranceWidget(
//       context: context,
//       busNumberController: busNumberController,
//       destinationController: destinationController,
//       fullnameController: fullNameController,
//       iceController: icephoneController,
//       onDestination: null,
//       onSelectPaymentMode: () => _onNetwork(context),
//       onSelectPaymentType: () => _onPaymentType(context),
//       paymentModeController: paymentModeController,
//       paymentTypeController: paymentTypeController,
//       showMomo: _showMomo,
//       stationController: stationController,
//     );
//   }

//   _onPaymentType(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => SimpleDialog(
//         title: Text('Select Payment Type'),
//         children: [
//           ListTile(
//             title: Text('Cash', style: h3Black),
//             trailing: Icon(Icons.arrow_forward_ios),
//             onTap: () {
//               Navigator.of(context).pop();
//               setState(() {
//                 paymentTypeController.text = 'Cash';
//                 payType = "cash";
//                 _showMomo = false;
//               });
//             },
//           ),
//           ListTile(
//             title: Text('Momo', style: h3Black),
//             trailing: Icon(Icons.arrow_forward_ios),
//             onTap: () {
//               Navigator.of(context).pop();
//               setState(() {
//                 paymentTypeController.text = 'Momo';
//                 payType = "momo";
//                 _showMomo = true;
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   void _onNetwork(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => SimpleDialog(
//         title: Text('Select network'),
//         children: [
//           ListTile(
//             title: Text('AirtelTigo Money', style: h3Black),
//             trailing: Icon(Icons.arrow_forward_ios),
//             onTap: () {
//               Navigator.of(context).pop();
//               setState(() {
//                 paymentModeController.text = 'AirtelTigo Money';
//                 network = "at";
//               });
//             },
//           ),
//           ListTile(
//             title: Text('MTN Mobile Money', style: h3Black),
//             trailing: Icon(Icons.arrow_forward_ios),
//             onTap: () {
//               Navigator.of(context).pop();
//               setState(() {
//                 paymentModeController.text = 'MTN Mobile Money';
//                 network = "mtn";
//               });
//             },
//           ),
//           ListTile(
//             title: Text('Vodafone Cash', style: h3Black),
//             trailing: Icon(Icons.arrow_forward_ios),
//             onTap: () {
//               Navigator.of(context).pop();
//               setState(() {
//                 paymentModeController.text = 'Vodafone Cash';
//                 network = "vfc";
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
