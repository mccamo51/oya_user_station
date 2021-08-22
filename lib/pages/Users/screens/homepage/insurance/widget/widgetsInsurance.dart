// import 'package:flutter/material.dart';
// import 'package:oya_mobile/components/textField.dart';
// import 'package:oya_mobile/screens/homepage/insurance/buyForOthersOnly.dart';
// import 'package:oya_mobile/screens/homepage/insurance/buyInsuranceForSelfOthers.dart';
// import 'package:oya_mobile/screens/homepage/insurance/localInsurance.dart';
// import 'package:oya_mobile/spec/colors.dart';
// import 'package:oya_mobile/spec/styles.dart';

// Future<void> insurancePopUp({
//   BuildContext context,
//   Function onSet,
//   TextEditingController nameCtrl,
//   TextEditingController phoneNumberCtrl,
// }) async {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return Dialog(
//         child: Container(
//           padding: EdgeInsets.all(15),
//           height: 220,
//           child: Column(
//             children: [
//               textFormField2(
//                 hintText: "Please enter full name",
//                 controller: nameCtrl,
//                 focusNode: null,
//                 inputType: TextInputType.text,
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               textFormField2(
//                 hintText: "Please enter ypur phone number",
//                 controller: phoneNumberCtrl,
//                 focusNode: null,
//                 inputType: TextInputType.number,
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   OutlineButton(
//                     color: PRIMARYCOLOR,
//                     textColor: PRIMARYCOLOR,
//                     borderSide: BorderSide(color: PRIMARYCOLOR),
//                     child: Text("Cancel"),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                   FlatButton(
//                     color: PRIMARYCOLOR,
//                     textColor: WHITE,
//                     child: Text("Okay"),
//                     onPressed: onSet,
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

// void onBuyInsurance(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (context) => SimpleDialog(
//       title: Text('Buy Insurance'),
//       children: [
//         Divider(),
//         ListTile(
//           title: Text('Buy for self ONLY', style: h3Black),
//           trailing: Icon(
//             Icons.arrow_forward_ios,
//             size: 14,
//           ),
//           onTap: () => Navigator.push(
//               context, MaterialPageRoute(builder: (context) => Insurance())),
//         ),
//         ListTile(
//           title: Text('Buy for Self and Others', style: h3Black),
//           trailing: Icon(
//             Icons.arrow_forward_ios,
//             size: 14,
//           ),
//           onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => BuyInsuranceForSelfOthers())),
//         ),
//         ListTile(
//           title: Text('Buy for Others ONLY', style: h3Black),
//           trailing: Icon(
//             Icons.arrow_forward_ios,
//             size: 14,
//           ),
//           onTap: () => Navigator.push(context,
//               MaterialPageRoute(builder: (context) => BuyInsuranceForOthers())),
//         ),
//       ],
//     ),
//   );
// }
