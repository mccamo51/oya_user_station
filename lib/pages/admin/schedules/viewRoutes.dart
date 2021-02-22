// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:oya_porter/bloc/myRouteBloc.dart';
// import 'package:oya_porter/components/appBar.dart';
// import 'package:oya_porter/components/emptyBox.dart';
// import 'package:oya_porter/config/offlineData.dart';
// import 'package:oya_porter/models/myRouteModel.dart';
// import 'package:oya_porter/pages/admin/schedules/schedules.dart';
// import 'package:oya_porter/pages/admin/schedules/viewSchedules.dart';

// class RoutesPage extends StatefulWidget {
//   final statiionId;
//   RoutesPage({@required this.statiionId});

//   @override
//   _RoutesPageState createState() => _RoutesPageState();
// }

// class _RoutesPageState extends State<RoutesPage> {
//   void initState() {
//     myRouteBloc.fetchAllStaffs(widget.statiionId);
//     loadMyRouteOffline();
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBar(title: "Routes"),
//       body: StreamBuilder(
//         stream: myRouteBloc.myroutes,
//         initialData: myRouteMapOffline == null
//             ? null
//             : MyRouteModel.fromJson(myRouteMapOffline),
//         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//           print("snapshot: ${snapshot.data}");
//           if (snapshot.hasData) {
//             return _mainContent(snapshot.data, context);
//           } else if (snapshot.hasError) {
//             return Scaffold(body: emptyBox(context));
//           }
//           return Center(
//             child: CupertinoActivityIndicator(),
//           );
//         },
//       ),
//     );
//   }

//   Widget _mainContent(MyRouteModel model, BuildContext context) {
//     // print(bussModel.data);
//     if (model.data != null && model.data.length > 0)
//       return SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               child: Column(
//                 children: [
//                   for (var x in model.data)
//                     _itemTile(
//                         from: x.from.name,
//                         to: x.to.name,
//                         context: context,
//                         stId: widget.statiionId,
//                         routId: x.id.toString())
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     else
//       return emptyBox(context);
//   }
// }

// _itemTile({String stId, String routId, BuildContext context, from, to}) {
//   return Column(
//     children: [
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListTile(
//           leading: Icon(FeatherIcons.mapPin),
//           title: Text("From: $from   -   $to"),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ViewSchedules(
//                   routeId: routId,
//                   statiionId: stId,
//                 ),
//               ),
//             );
//           },
//           trailing: Icon(
//             Icons.arrow_forward_ios,
//             size: 15,
//           ),
//         ),
//       ),
//       Padding(
//         padding: const EdgeInsets.only(left: 25.0),
//         child: Divider(),
//       )
//     ],
//   );
// }
