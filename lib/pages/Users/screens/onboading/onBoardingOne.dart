import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oya_porter/pages/Users/config/navigation.dart';
import 'package:oya_porter/pages/Users/screens/auth/authenticationPage.dart';
import 'package:oya_porter/pages/Users/screens/onboading/widgets/onBoardingWidget.dart';
import 'package:oya_porter/pages/Users/screens/onboading/widgets/pageBalls.dart';
import 'package:oya_porter/spec/colors.dart';

const _kDuration = const Duration(milliseconds: 300);
const _kCurve = Curves.ease;
final _controller = new PageController();
int pageNum = 0;

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  List<Widget> _onboardPage = [
    OnboardingWidget(
      image: "assets/images/admin/peoples.png",
      msg:
          '''With the Oya! app, you can buy an electronic ticket from the comfort of your home. Pay with any of our local mobile payment platform.
''',
      title: "Travel with Ease",
      sizedBoxTop: 10,
      left: 20,
    ),
    OnboardingWidget(
      image: "assets/images/admin/travelling.png",
      msg:
          '''Travel with peace of mind with our local travel insurance package. Buy policy for your travels, hirings and your parcels.
''',
      title: "Insure you trip",
      sizedBoxTop: 37,
    ),
    OnboardingWidget(
      image: "assets/images/admin/passenger.jpeg",
      msg:
          '''With midroute feature, you can buy a ticket and join the bus midway. No need to go to the station. Reduce your hustle.
''',
      title: "Midroute",
      sizedBoxTop: 10,
      left: 20,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final sizes = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: WHITE,
      body: Stack(
        children: <Widget>[
          PageView.builder(
            controller: _controller,
            itemCount: _onboardPage.length,
            itemBuilder: (BuildContext context, int index) {
              return _onboardPage[index % _onboardPage.length];
            },
            onPageChanged: (index) {
              setState(() {
                pageNum = index;
              });
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: sizes.height > 700 ? 80.0 : 70),
              child: _ballsContainer(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: _customBottomNavigation(),
            ),
          ),

          // _ballsContainer()
        ],
      ),
    );
  }

  Widget _customBottomNavigation() {
    final size = MediaQuery.of(context).size;
    print(size.height);
    print(size.width);
    return Container(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CupertinoButton(
            onPressed: () {
              navigation(context: context, pageName: "loginpage");
            },
            child: Text("SKIP",
                style: TextStyle(
                  fontSize: size.width > 600 ? 22 : 16,
                  color: PRIMARYCOLOR,
                )),
          ),
          CupertinoButton(
            onPressed: () {
              if (pageNum == 2) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AuthenticationPage()),
                );
              } else {
                _controller.nextPage(duration: _kDuration, curve: _kCurve);
              }
            },
            child: Row(
              children: [
                Text("NEXT",
                    style: TextStyle(
                      fontSize: size.width > 600 ? 22 : 16,
                      color: PRIMARYCOLOR,
                    )),
                SizedBox(
                  width: 2,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ballsContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        pageNum == 0 ? ball(selected: true) : ball(),
        pageNum == 1 ? ball(selected: true) : ball(),
        pageNum == 2 ? ball(selected: true) : ball(),
      ],
    );
  }
}
