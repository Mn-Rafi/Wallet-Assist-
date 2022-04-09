import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:money_manager_app/Category%20page/custom_category_widget.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';
import 'package:money_manager_app/customs/add_category.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';
import 'package:money_manager_app/homePage/expense/expense_widgets.dart';
import 'package:money_manager_app/homePage/widgets/custom_widgets.dart';

class ExpenseDisplay extends StatelessWidget {
  String category;
  Categories nameofCatagory;
  double expenseAmount;
  DateTime dateofExpense;
  String notesaboutExpense;
  int index;

  ExpenseDisplay({
    Key? key,
    required this.category,
    required this.nameofCatagory,
    required this.expenseAmount,
    required this.dateofExpense,
    required this.notesaboutExpense,
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
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            onTap: () {
                              Future.delayed(
                                  const Duration(seconds: 0),
                                  () => showDialog(
                                      context: context,
                                      builder: (ctx) => CustomEditTransaction(
                                            amount: -expenseAmount,
                                            notes: notesaboutExpense,
                                            dropdownValue: nameofCatagory,
                                            dateOfTransaction: dateofExpense,
                                            dropInt: 1,
                                            type: false,
                                            addFunction:
                                                const AddExpenseCategory(),
                                            index: index,
                                            listHint: nameofCatagory.category,
                                          )));
                            },
                            child: Text('Edit', style: customTextStyleOne(),),
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
                                                            .toList())[1];
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
                              child: Text('Delete', style: customTextStyleOne(),)),
                        ]),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Expense/$category',
              style: customTextStyleOne(color: secondGrey, fontSize: 17.sp),
            ),
            Text(
              '₹${-expenseAmount}',
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
              notesaboutExpense,
              style: customTextStyleOne(fontSize: 15.sp),
            ),
          ],
        ),
      ),
    );
  }

  String getText() {
    return '${dateofExpense.day}-${dateofExpense.month}-${dateofExpense.year}';
  }
}
