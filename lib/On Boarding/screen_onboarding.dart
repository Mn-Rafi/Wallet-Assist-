import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager_app/First%20Profile/screen_first_profile.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenOnboarding extends StatelessWidget {
  const ScreenOnboarding({Key? key}) : super(key: key);

  _storeOnboardingInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'Manage ',
                            style: customTextStyleOne(
                                color: firstBlue, fontSize: 32)),
                        TextSpan(
                          text: 'your income and expence ',
                          style: customTextStyleOne(fontSize: 32),
                        ),
                        TextSpan(
                            text: 'quickly ',
                            style: customTextStyleOne(
                                color: firstOrange, fontSize: 32)),
                      ])),
                      Image.asset(
                        'images/financial-management-statistics-vector-22868355.png',
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                // width: 275.w,
                height: 48.h,
                decoration: customBoxDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Let\'s Get Started',
                      style: customTextStyleOne(fontSize: 20),
                    ),
                    GestureDetector(
                        onTap: () async{
                          await _storeOnboardingInfo();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => const ScreenProfile(),
                            ),
                          );
                        },
                        child: arrowForwardIcon)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
