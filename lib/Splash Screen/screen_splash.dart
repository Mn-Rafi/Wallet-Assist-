import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager_app/First%20Profile/screen_first_profile.dart';
import 'package:money_manager_app/MainScreen/screen_home.dart';
import 'package:money_manager_app/On%20Boarding/screen_onboarding.dart';
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
          MaterialPageRoute(builder: (context) => ScreenOnboarding()));
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
          const snackBar = SnackBar(
            content: Text('Double tap to exit'),
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
