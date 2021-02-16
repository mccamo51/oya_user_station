import 'package:flutter/material.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/navigation.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/colors.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Future<void> initState() {

    super.initState();
    checkSession().then((status) {
      if (status != null && status == "auth") {
        navigation(context: context, pageName: "home");
      } else {
        print("Splash");
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false);

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Image.asset(
                "assets/images/admin/mainlogo.png",
                width: 100,
                height: 100,
              )),
              SizedBox(height: 20),
              Text(
                "Get Started",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Text(
                    "MAINSCREENTEXT",
                    style: TextStyle(fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
            height: 120,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: OutlineButton(
                    highlightedBorderColor: PRIMARYCOLOR,
                    borderSide: BorderSide(width: 0.5, color: PRIMARYCOLOR),
                    onPressed: () => navigation(
                      context: context,
                      pageName: "loginpage",
                    ),
                    child: Text("Log In",
                        style: TextStyle(color: PRIMARYCOLOR, fontSize: 16)),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
