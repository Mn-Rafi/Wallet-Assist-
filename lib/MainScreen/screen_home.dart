import 'package:flutter/material.dart';
import 'package:money_manager_app/Category%20page/screen_catogories.dart';
import 'package:money_manager_app/MainScreen/widgets/bottom_navigation.dart';
import 'package:money_manager_app/add%20transaction%20page/screen_addtransaction.dart';
import 'package:money_manager_app/homePage/screen_homepage.dart';
import 'package:money_manager_app/profile%20page/screen_profile.dart';
import 'package:money_manager_app/statistics%20page/screen_statistics.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _pages = [
    ScreenHomePage(),
    ScreenStatistics(),
    ScreenTransaction(),
    ScreenRemainder(),
    ScreenProfileDetails()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            ValueListenableBuilder(
              valueListenable: selectedIndexNotifier,
              builder: (BuildContext context, int updatedInddex, child) {
                return _pages[updatedInddex];
              },
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: CustomBottomNavigationBar(),
            ),
          ],
        ));
  }
}
