import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/Category%20page/custom_category_widget.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';
import 'package:money_manager_app/MainScreen/screen_home.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';
import 'package:money_manager_app/homePage/expense/expense_details.dart';
import 'package:money_manager_app/homePage/expense/expense_widgets.dart';

class ScreenExpense extends StatefulWidget {
  const ScreenExpense({Key? key}) : super(key: key);

  @override
  State<ScreenExpense> createState() => _ScreenExpenseState();
}

class _ScreenExpenseState extends State<ScreenExpense> {
  String dropdownvalue = 'Monthly';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const ScreenHome(),
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
          'Expense',
          style: customTextStyleOne(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
          valueListenable:
              Hive.box<Transactions>('transactions').listenable(),
          builder: (context, Box<Transactions> box, _) {
            List<Transactions> transactionList =
                incomeorExpense(box.values.toList())[1];

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
                        ? CustomTotalExpenseContainer(
                            headText: 'Your total Expense',
                            lastExpenseAmount: 0,
                            totalExpenseAmount: 0,
                          )
                        : CustomTotalExpenseContainer(
                            headText: 'Your total Expense',
                            lastExpenseAmount: -(transactionList.last.amount),
                            totalExpenseAmount: -getTotalExpense(),
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
                              'No Expense Transactions Found',
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
                                    builder: (ctx) => ExpenseDisplay(
                                        category: transactionList[index]
                                            .categoryName,
                                        index: transactionList[index].key,
                                        dateofExpense: transactionList[index]
                                            .dateofTransaction,
                                        expenseAmount:
                                            transactionList[index].amount,
                                        nameofCatagory: transactionList[index]
                                            .categoryCat,
                                        notesaboutExpense:
                                            transactionList[index].notes)),
                                child: CustomExpenseContainer(
                                    expenseDate: transactionList[index]
                                        .dateofTransaction,
                                    totalExpenseAmount:
                                        transactionList[index].amount,
                                    headText:
                                        transactionList[index].categoryName),
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
    );
  }
}
