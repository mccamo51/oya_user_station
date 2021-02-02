// import 'package:flutter/material.dart';
// import 'package:oya_mobile/config/navigation.dart';
// import 'package:oya_mobile/spec/colors.dart';
// import 'package:oya_mobile/spec/images.dart';
// import 'package:oya_mobile/spec/strings.dart';

// class AuthenticationPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Center(
//                   child: Image.asset(
//                 MAINLOGO,
//                 width: 100,
//                 height: 100,
//               )),
//               SizedBox(height: 20),
//               Text(
//                 "Get Started",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
//               ),
//               SizedBox(height: 20),
//               Container(
//                 padding: EdgeInsets.all(10),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 20.0, right: 20),
//                   child: Text(
//                     MAINSCREENTEXT,
//                     style: TextStyle(fontSize: 17),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Container(
//             height: 120,
//             child: Column(
//               children: [
//                 SizedBox(
//                   width: double.infinity,
//                   height: 45,
//                   child: FlatButton(
//                     color: PRIMARYCOLOR,
//                     onPressed: ()=> navigation(context: context, pageName: "registration",),
//                     child: Text("Sign up",
//                         style: TextStyle(color: WHITE, fontSize: 16)),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 SizedBox(
//                   width: double.infinity,
//                   height: 45,
//                   child: OutlineButton(
//                     highlightedBorderColor: PRIMARYCOLOR,
//                     borderSide: BorderSide(width: 0.5, color: PRIMARYCOLOR),
//                     onPressed: () =>navigation(context: context, pageName: "loginpage",),
//                     child: Text("Log In",
//                         style: TextStyle(color: PRIMARYCOLOR, fontSize: 16)),
//                   ),
//                 )
//               ],
//             )),
//       ),
//     );
//   }
// }
