import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/Hive/profileHiveClass/profilehiveclass.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:money_manager_app/MainScreen/widgets/grid_container.dart';
import 'package:money_manager_app/Regular%20Payment/screen_regularpayments.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';
import 'package:money_manager_app/homePage/Income/income_detailed_page.dart';
import 'package:money_manager_app/homePage/Income/screen_income.dart';
import 'package:money_manager_app/homePage/expense/screen_expense.dart';
import 'package:money_manager_app/homePage/widgets/custom_widgets.dart';

class ScreenHomePage extends StatefulWidget {
  const ScreenHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ScreenHomePage> createState() => _ScreenHomePageState();
}

String welcome = 'Welcome!';
int? isFirstTime;

class _ScreenHomePageState extends State<ScreenHomePage> {
  Icon myIcon = const Icon(Icons.search);
  Widget myField = customHeading('Latest Transactions');
  String searchInput = '';

  _storeFirstApperInfo() async {
    int isFirstTime = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('isFirstTime', isFirstTime);
  }

  @override
  void initState() {
    _storeFirstApperInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: firstBlack,
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 25),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const RegularPayment(),
            )),
            icon: const Icon(FontAwesomeIcons.calendarPlus),
            color: firstBlack,
          )
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Home',
          style: customTextStyleOne(fontSize: 20.w),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
          valueListenable:
              Hive.box<ProfileDetails>('profiledetails').listenable(),
          builder: (context, Box<ProfileDetails> box, widget) {
            List<ProfileDetails> profileDetails = box.values.toList();
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 25.0.w, top: 30.w, right: 25.0.w, bottom: 100.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi ${profileDetails[0].nameofUser.toString()} 👋',
                              style: customTextStyleOne(fontSize: 22.sp),
                            ),
                            Text(
                              welcome,
                              style: TextStyle(fontSize: 18.sp),
                            ),
                          ],
                        ),
                        CustomContainerForImage(
                            imagePath: profileDetails[0].imageUrl.toString()),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text('Catogories',
                        style: customTextStyleOne(fontSize: 20.sp)),
                    SizedBox(
                      height: 17.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ScreenIncome())),
                          child: Hero(
                            tag: 'income',
                            child: CustomContainerForCatogories(
                                backgroundColor: incomeGreen,
                                imagePath: 'images/income.png',
                                title: 'Income'),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ScreenExpense())),
                          child: Hero(
                            tag: 'expense',
                            child: CustomContainerForCatogories(
                                backgroundColor: expenseBlue,
                                imagePath: 'images/expense.png',
                                title: 'Expense'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: myField,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (myIcon.icon == Icons.search) {
                                myIcon = const Icon(Icons.clear);
                                myField = customTextFieldContainer(searchInput);
                              } else {
                                setState(() {
                                  searchInput = '';
                                });
                                myIcon = const Icon(Icons.search);
                                myField = customHeading('Latest Transactions');
                              }
                            });
                          },
                          child: myIcon,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 2.8.h,
                          crossAxisCount: 2,
                          mainAxisSpacing: 10.w,
                          crossAxisSpacing: 10.w),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => showDialog(
                              context: context,
                              builder: (ctx) => IncomeDisplay(
                                    incomeAmount: 60000,
                                    nameofCatagory: 'Salary',
                                    dateofIncome: '14/03/2022',
                                    notesaboutIncome:
                                        'Today, we went outside for our dinner. It was my Birthday party. So me and my friends ate CHicken Manthi from Hotel Raaz Edachira.',
                                  )),
                          child: CustomGridContainer(index: index),
                        );
                      },
                      itemCount: 50,
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
