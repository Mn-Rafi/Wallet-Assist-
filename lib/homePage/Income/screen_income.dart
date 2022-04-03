import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/Category%20page/custom_category_widget.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';
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
        body: ValueListenableBuilder(
            valueListenable:
                Hive.box<Transactions>('transactions').listenable(),
            builder: (context, Box<Transactions> box, _) {
              List<Transactions> transactionList =
                  incomeorExpense(box.values.toList())[0];

              double getTotalExpense() {
                double totalAmount = 0;
                for (int i = 0; i < transactionList.length; i++) {
                  totalAmount += transactionList[i].amount;
                }
                return totalAmount;
              }

              return SingleChildScrollView(
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
                                          color: const Color.fromARGB(
                                              255, 255, 0, 0),
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
                                              color: const Color.fromARGB(
                                                  255, 255, 0, 0),
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
                                              color: Color.fromARGB(
                                                  255, 255, 0, 0),
                                              fontSize: 14),
                                        ),
                                        Text(
                                          ' to ',
                                          style: customTextStyleOne(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontSize: 14),
                                        ),
                                        Text(
                                          ' 20-04 2022',
                                          style: customTextStyleOne(
                                              color: Color.fromARGB(
                                                  255, 255, 0, 0),
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      transactionList.isEmpty
                          ? CustomTotalIncomeContainer(
                              headText: 'Your total income',
                              totalIncomeAmount: 0,
                              lastIncomeAmount: 0,
                            )
                          : CustomTotalIncomeContainer(
                              headText: 'Your total income',
                              totalIncomeAmount: getTotalExpense(),
                              lastIncomeAmount: transactionList.last.amount,
                            ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text('Transactions',
                          style: customTextStyleOneWithUnderLine(fontSize: 17)),
                      SizedBox(
                        height: 20.h,
                      ),
                      transactionList.isEmpty
                          ? Center(
                              child: Text(
                                'No Income Transactions Found',
                                style: customTextStyleOne(
                                    fontSize: 18, color: Colors.white),
                              ),
                            )
                          : ListView.separated(
                              reverse: true,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (ctx) => IncomeDisplay(
                                          category:
                                              transactionList[index].amount >= 0
                                                  ? 'Income'
                                                  : 'Expense',
                                          incomeAmount:
                                              transactionList[index].amount,
                                          nameofCatagory: transactionList[index]
                                              .categoryName,
                                          dateofIncome: transactionList[index]
                                              .dateofTransaction,
                                          notesaboutIncome:
                                              transactionList[index].notes)),
                                  child: CustomIncomeContainer(
                                    headText:
                                        transactionList[index].categoryName,
                                    totalIncomeAmount:
                                        transactionList[index].amount,
                                    incomeDate: transactionList[index]
                                        .dateofTransaction,
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 10.h,
                                  ),
                              itemCount: transactionList.length)
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
