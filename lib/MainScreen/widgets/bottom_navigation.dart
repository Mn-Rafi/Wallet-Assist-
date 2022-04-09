import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager_app/MainScreen/screen_home.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.w,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25), topLeft: Radius.circular(25)),
        boxShadow: [
          BoxShadow(color: firstBlack, blurRadius: 0.01),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
        child: ValueListenableBuilder(
          valueListenable: ScreenHome.selectedIndexNotifier,
          builder: (BuildContext ctx, int updatedIndex, _) {
            return BottomNavigationBar(
              elevation: 0,
              currentIndex: updatedIndex,
              onTap: (newIndex) {
                ScreenHome.selectedIndexNotifier.value = newIndex;
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: firstBlack,
              selectedLabelStyle: TextStyle(
                fontSize: 10.sp,
              ),
              unselectedItemColor: firstGrey,
              showUnselectedLabels: false,
              items: [
                const BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.house),
                  label: '⦿',
                  activeIcon: FaIcon(FontAwesomeIcons.houseChimney, size: 20),
                ),
                const BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.chartGantt),
                  activeIcon: FaIcon(FontAwesomeIcons.chartPie, size: 20),
                  label: '⦿',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    height: 45.w,
                    width: 45.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: firstGrey, width: 2)),
                    child: const FaIcon(
                      FontAwesomeIcons.plus,
                      size: 30,
                    ),
                  ),
                  label: '',
                  activeIcon: const FaIcon(FontAwesomeIcons.plus, size: 30),
                ),
                const BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.solidBell),
                  label: '⦿',
                  activeIcon: FaIcon(FontAwesomeIcons.calendarPlus, size: 20),
                ),
                const BottomNavigationBarItem(
                  icon: FaIcon(
                    FontAwesomeIcons.screwdriverWrench,
                    size: 24,
                  ),
                  label: '⦿',
                  activeIcon: FaIcon(
                    FontAwesomeIcons.solidPenToSquare,
                    size: 20,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
