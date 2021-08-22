import 'package:flutter/material.dart';
import 'package:oya_porter/pages/Users/screens/auth/authenticationPage.dart';
import 'package:oya_porter/pages/Users/screens/auth/register/register.dart';
import 'package:oya_porter/pages/Users/screens/homepage/homeMap/bookingHome.dart';
import 'package:oya_porter/pages/Users/screens/homepage/homeMap/newHome.dart';
import 'package:oya_porter/pages/Users/screens/homepage/insurance/insuranceTermsCheck.dart';
import 'package:oya_porter/pages/Users/screens/homepage/more/more.dart';
import 'package:oya_porter/pages/Users/screens/homepage/rentBus/rentBus.dart';
import 'package:oya_porter/pages/Users/screens/homepage/rentBus/rentBusForms/rentBusForm.dart';
import 'package:oya_porter/pages/Users/screens/homepage/ticket/myTickets.dart';
import 'package:oya_porter/pages/Users/screens/homepage/ticket/ticketing.dart';
import 'package:oya_porter/pages/Users/screens/homepage/trips/myTrips.dart';
import 'package:oya_porter/pages/Users/screens/secreteQuestion/secreteQuestion.dart';
import 'package:oya_porter/pages/auth/login/login.dart';

void navigation({
  @required BuildContext context,
  @required String pageName,
  Map<String, dynamic> meta,
}) {
  switch (pageName.toLowerCase()) {
    case "back":
      Navigator.of(context).pop();
      break;
    case "registration":
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Register()));
      break;
    case "loginpage":
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginPage()));
      break;
    case "home":
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => ItemMenu1(isStaff: isStaff)),
          (Route<dynamic> route) => false);
      break;
    // case "busfeatures":
    //   Navigator.of(context)
    //       .push(MaterialPageRoute(builder: (context) => BusFeatures()));
    //   break;
    case "secrete":
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SecreteQuestion()));
      break;
    case "rentbusfrom":
      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => RentBusForm()));
      break;
    // case "itenary":
    //   Navigator.of(context)
    //       .push(MaterialPageRoute(builder: (context) => Itenary()));
    //   break;
    case "ticketing":
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Ticketing()));
      break;
    case "more":
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => More()));
      break;
    case "trips":
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MyTrips()));
      break;
    case "rentbus":
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => RentBus()));
      break;
    // case "insurance":
    //   Navigator.of(context).push(
    //       MaterialPageRoute(builder: (context) => InsuranceTermsCondition()));
    //   break;
    case "tickets":
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MyTickets()));
      break;
    case "authenticationpage":
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => AuthenticationPage()),
          (Route<dynamic> route) => false);
      break;
    case "rentals":
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MapView()));
      break;
    default:
      print("$pageName do not exit");
  }
}
