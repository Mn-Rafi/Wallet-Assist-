import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:money_manager_app/Category%20page/custom_category_widget.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';
import 'package:money_manager_app/customs/add_category.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';
import 'package:money_manager_app/homePage/widgets/custom_widgets.dart';

class IncomeDisplay extends StatelessWidget {
  Categories nameofCatagory;
  String category;
  double incomeAmount;
  DateTime dateofIncome;
  String notesaboutIncome;
  int index;

  IncomeDisplay({
    Key? key,
    required this.nameofCatagory,
    required this.category,
    required this.incomeAmount,
    required this.dateofIncome,
    required this.notesaboutIncome,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CloseButton(
                  onPressed: () => Navigator.of(context).pop(),
                ),
                PopupMenuButton(
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            onTap: () {
                              Future.delayed(
                                  const Duration(seconds: 0),
                                  () => showDialog(
                                      context: context,
                                      builder: (ctx) => CustomEditTransaction(
                                        bgColor: incomeGreen,
                                            listHint: nameofCatagory.category,
                                            notes: notesaboutIncome,
                                            amount: incomeAmount,
                                            dropdownValue: nameofCatagory,
                                            dateOfTransaction: dateofIncome,
                                            dropInt: 0,
                                            type: true,
                                            addFunction: const AddCategory(),
                                            index: index,
                                          )));
                            },
                            child: const Text('Edit'),
                          ),
                          PopupMenuItem(
                              onTap: () {
                                Future.delayed(
                                    const Duration(seconds: 0),
                                    () => showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                              title: Text(
                                                'Your transaction details will be deleted permenently. Do you really want to continue?',
                                                style: customTextStyleOne(
                                                    fontSize: 15),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    List<Transactions>
                                                        transactionList =
                                                        incomeorExpense(Hive.box<
                                                                    Transactions>(
                                                                'transactions')
                                                            .values
                                                            .toList())[0];
                                                    transactionList[index]
                                                        .delete();
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Yes',
                                                    style: customTextStyleOne(),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'No',
                                                    style: customTextStyleOne(),
                                                  ),
                                                )
                                              ],
                                            )));
                              },
                              child: const Text('Delete')),
                        ]),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Income/$category',
              style: customTextStyleOne(color: secondGrey, fontSize: 17.sp),
            ),
            Text(
              '₹$incomeAmount',
              style: customTextStyleOne(fontSize: 30.sp),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Date',
              style: customTextStyleOne(color: secondGrey, fontSize: 17.sp),
            ),
            Text(
              getText(),
              style: customTextStyleOne(fontSize: 23.sp),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Notes',
              style: customTextStyleOne(color: secondGrey, fontSize: 17.sp),
            ),
            Text(
              notesaboutIncome,
              style: customTextStyleOne(fontSize: 15.sp),
            ),
          ],
        ),
      ),
    );
  }

  String getText() {
    return '${dateofIncome.day}-${dateofIncome.month}-${dateofIncome.year}';
  }
}
