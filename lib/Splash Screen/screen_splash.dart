import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager_app/First%20Profile/screen_first_profile.dart';
import 'package:money_manager_app/MainScreen/screen_home.dart';
import 'package:money_manager_app/On%20Boarding/screen_onboarding.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';
import 'package:money_manager_app/homePage/screen_homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

int? isViewd;
int? isViewdFirstProfile;

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  _navigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(milliseconds: 3000));
    isViewd = prefs.getInt('onBoard');
    isViewdFirstProfile = prefs.getInt('onFirstProfile');
    isFirstTime = prefs.getInt('isFirstTime');

    if (isFirstTime == 0) {
      welcome = 'Welcome back!';
    }

    if (isViewd != 0 && isViewdFirstProfile != 0) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ScreenOnboarding()));
    } else if (isViewd == 0 && isViewdFirstProfile != 0) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ScreenProfile()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ScreenHome()));
    }
  }

  DateTime? timeBackButton;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (timeBackButton == null ||
            now.difference(timeBackButton!) > const Duration(seconds: 2)) {
          timeBackButton = now;
          final snackBar = SnackBar(
            duration: const Duration(seconds: 1),
            content: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 0.2, color: Colors.black),
                  borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 60),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'double tap to exit',
                  textAlign: TextAlign.center,
                  style: customTextStyleOne(color: firstBlack),
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 10000,
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return Future.value(false);
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/App_Logo.gif',
                width: 100.w,
              ),
              const Text(
                'Wallet Assist',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
