//checking internet connection
import 'dart:io';
import 'package:connectivity/connectivity.dart';

Future<bool> checkConnection() async {
  bool check;
  if (Platform.isAndroid) {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      check = true;
    } else {
      check = false;
    }
  } else {
    check = true;
  }
  return check;
}
