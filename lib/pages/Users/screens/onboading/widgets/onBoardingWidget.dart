
import 'package:flutter/material.dart';
import 'package:oya_porter/spec/colors.dart';

class OnboardingWidget extends StatelessWidget {
  final String title, msg, image;
  final double sizedBoxTop, left;

  OnboardingWidget({
    @required this.image,
    @required this.msg,
    @required this.title,
    this.sizedBoxTop = 0,
    this.left = 0,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: WHITE,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Stack(
                children: [
                  // Image.asset(
                  //   PATHIMAGE,
                  //   width: size.width,
                  //   height: size.height * .55,
                  //   fit: BoxFit.cover,
                  // ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height > 700 ? 80 : 50,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        image,
                        width: size.width - 50,
                        height: size.height * .40,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height > 700 ? 30 : 0,
              ),
              Container(
                padding: EdgeInsets.only(right: 24, left: 24),
                width: MediaQuery.of(context).size.width,
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: sizedBoxTop),
                      Text("$title",
                          style: TextStyle(
                            fontSize: size.width > 600 ? 35 : 25,
                            fontWeight: FontWeight.w700,
                            color: PRIMARYCOLOR,
                          )),
                      SizedBox(height: 20),
                      Text(
                        "$msg",
                        style: TextStyle(
                          fontSize: size.width > 600 ? 30 : 16,
                          fontWeight: FontWeight.w400,
                          color: ASHDEEP,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
