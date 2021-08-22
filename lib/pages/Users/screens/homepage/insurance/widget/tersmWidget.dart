// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:oya_mobile/spec/colors.dart';
// import 'package:oya_mobile/spec/strings.dart';
// import 'package:oya_mobile/spec/styles.dart';

// Widget termsWidgets({
//   @required BuildContext context,
//   @required String nameCtrl,
//   @required Function onAccept,
//   @required Function onCancel,
// }) {
//   return Scaffold(
//     // appBar: AppBar(
//     //   centerTitle: true,
//     //   elevation: 0,
//     //   // title: Text(
//     //   //   "Local Travel Insurance",
//     //   //   style: TextStyle(color: Colors.white),
//     //   // ),
//     // ),
//     body: SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 40,
//             ),
//             Container(
//               padding: EdgeInsets.all(8),
//               child: Text(
//                 "Welcome $nameCtrl to OYA Local Travel Insurance. This insurance costs ONLY Ghs1 and gives you Ghs500 or Ghs1000.",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Text(
//               "Conditions and I Accept.",
//               style: h3Black,
//             ),
//             Divider(),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text("$TERMSNCONDITION"),
//             ),
//             CupertinoButton(
//                 child: Text(
//                   "I Have Read The Terms And Conditions and I Accept.",
//                   style: TextStyle(color: PRIMARYCOLOR),
//                 ),
//                 onPressed: onAccept),
//             Center(
//               child: CupertinoButton(
//                 child: Text("Cancel"),
//                 onPressed: onCancel,
//               ),
//             ),
//             Row(
//               children: [],
//             )
//           ],
//         ),
//       ),
//     ),
//   );
// }
