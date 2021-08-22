import 'dart:math';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/strings.dart';
import 'package:sensors/sensors.dart';

import 'speedometer.dart';

class SpeedometerContainer extends StatefulWidget {
  final String busScheduleId;
  SpeedometerContainer({@required this.busScheduleId});
  @override
  _SpeedometerContainerState createState() => _SpeedometerContainerState();
}

class _SpeedometerContainerState extends State<SpeedometerContainer> {
  double velocity = 0;
  double highestVelocity = 0.0;
  bool _isLoading = false;
  bool _serviceEnabled;
  Location location = new Location();
  LocationData currentLocation, currentLocations;
  double currentLong, curentLat;

  PermissionStatus _permissionGranted;

  Future<void> _getCurrentLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // _currentLoc();
  }

  @override
  void initState() {
    _getCurrentLocation();
    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      _onAccelerate(event);
    });

    if (highestVelocity > 120.0) {
      FlutterBeep.beep();
    }

    super.initState();
  }

  void _onAccelerate(UserAccelerometerEvent event) {
    double newVelocity =
        sqrt(event.x * event.x + event.y * event.y + event.z * event.z);

    if ((newVelocity - velocity).abs() < 1) {
      return;
    }

    setState(() {
      velocity = newVelocity;

      if (velocity > highestVelocity) {
        highestVelocity = velocity;
      }
      if (highestVelocity > 100.0) {
        FlutterBeep.playSysSound(AndroidSoundIDs.TONE_CDMA_ABBR_ALERT);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 104),
              alignment: Alignment.bottomCenter,
              child: Text(
                'Highest speed:\n${highestVelocity.toStringAsFixed(2)} km/h',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 24),
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  // color: WHITE,
                  onPressed: () => _isLoading
                      ? null
                      : {
                          _onSpeedReport(
                            widget.busScheduleId,
                            highestVelocity.toDouble(),
                            curentLat,
                            currentLong,
                          )
                        },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _isLoading
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14),
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.red,
                                ),
                              ),
                            )
                          : Container(),
                      Text(
                        "Report Speed",
                        style: TextStyle(color: BLACK, fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Speedometer(
                speed: velocity,
                speedRecord: highestVelocity,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _onSpeedReport(
      scheduleId, double speed, latitude, longitude) async {
    setState(() {
      _isLoading = true;
    });
    // print(speed);
    final url = Uri.parse("$BASE_URL/schedules/$scheduleId/report_speed");
    try {
      final response = await http
          .post(url,
              headers: {
                "Authorization": "Bearer $accessToken",
                'Content-Type': 'application/json'
              },
              body: json.encode({
                'speed': speed.toString(),
                'latitude': latitude.toString(),
                'longitude': longitude.toString()

                // 'latitude': "",
                // 'longitude': ""
              }))
          .timeout(
            Duration(seconds: 15),
          );
      if (response.statusCode == 200) {
        final dataResponse = json.decode(response.body);
        print(dataResponse);
        if (dataResponse["status"] == 200) {
          setState(() {
            _isLoading = false;
            toastContainer(
              text: "Speed reported successfully!",
              backgroundColor: PRIMARYCOLOR,
            );
          });
        } else {
          setState(() {
            _isLoading = false;
            toastContainer(
              text: dataResponse["message"],
              backgroundColor: RED,
            );
          });
        }
      } else if (response.statusCode == 401) {
        sessionExpired(context);
      } else {
        setState(() {
          _isLoading = false;
        });
        toastContainer(text: "Error has occured");
      }
    } on TimeoutException catch (t) {
      print("${t.message}");
      setState(() => _isLoading = false);
      toastContainer(
        text: CONNECTIONTIMEOUT,
        backgroundColor: RED,
      );
    } on SocketException catch (s) {
      print("${s.message}");
      setState(() => _isLoading = false);
      toastContainer(
        text: INTERNETCONNECTIONPROBLEM,
        backgroundColor: RED,
      );
    } catch (e) {
      print("$e");
      setState(() => _isLoading = false);
      toastContainer(
        text: "Error occured. Please try again...$e",
        backgroundColor: RED,
      );
    }
  }

  // Future<void> _currentLoc() async {
  //   currentLocations = await location.getLocation();
  //   setState(() {
  //     currentLong = currentLocations.longitude;
  //     curentLat = currentLocations.latitude;
  //   });
  //   print(currentLong);
  //   print(curentLat);
  // }
}
