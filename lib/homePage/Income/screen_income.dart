import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager_app/MainScreen/screen_home.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';
import 'package:money_manager_app/homePage/Income/income_detailed_page.dart';
import 'package:money_manager_app/homePage/Income/widgets%20and%20lists/widgets_lists.dart';

class ScreenIncome extends StatefulWidget {
  const ScreenIncome({Key? key}) : super(key: key);

  @override
  State<ScreenIncome> createState() => _ScreenIncomeState();
}

class _ScreenIncomeState extends State<ScreenIncome> {
  String dropdownvalue = 'Monthly';

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'income',
      child: Scaffold(
        backgroundColor: incomeGreen,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => ScreenHome(),
                  ),
                  (route) => false),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: firstBlack,
                size: 15,
              )),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Income',
            style: customTextStyleOne(fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton(
                      value: dropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: customTextStyleOne(),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                    dropdownvalue == items[0]
                        ? Row(
                            children: [
                              arrowPrev,
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                'March - 2022',
                                style: customTextStyleOne(
                                    color: const Color.fromARGB(255, 255, 0, 0),
                                    fontSize: 14),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              arrowNext,
                            ],
                          )
                        : dropdownvalue == items[1]
                            ? Row(
                                children: [
                                  arrowPrev,
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    '2022',
                                    style: customTextStyleOne(
                                        color: const Color.fromARGB(255, 255, 0, 0),
                                        fontSize: 14),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  arrowNext,
                                ],
                              )
                            : Row(
                                children: [
                                  Text(
                                    '01-04-2022 ',
                                    style: customTextStyleOne(
                                        color: Color.fromARGB(255, 255, 0, 0),
                                        fontSize: 14),
                                  ),
                                  Text(
                                    ' to ',
                                    style: customTextStyleOne(
                                        color: Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 14),
                                  ),
                                  Text(
                                    ' 20-04 2022',
                                    style: customTextStyleOne(
                                        color: Color.fromARGB(255, 255, 0, 0),
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTotalIncomeContainer(
                  headText: 'Your total income',
                  totalIncomeAmount: 44390,
                  lastIncomeAmount: 499,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text('Transactions',
                    style: customTextStyleOneWithUnderLine(fontSize: 17)),
                SizedBox(
                  height: 20.h,
                ),
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
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
                        child: CustomIncomeContainer(
                          headText: 'Salary',
                          totalIncomeAmount: 3452,
                          incomeDate: '14/03/2022',
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10.h,
                        ),
                    itemCount: 30)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
