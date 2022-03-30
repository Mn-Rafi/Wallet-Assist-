import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:money_manager_app/customs/custom_text_and_color.dart';
import 'package:money_manager_app/homePage/expense/expense_widgets.dart';

class ExpenseDisplay extends StatelessWidget {
  String nameofCatagory;
  double expenseAmount;
  String dateofExpense;
  String notesaboutExpense;

  ExpenseDisplay({
    Key? key,
    required this.nameofCatagory,
    required this.expenseAmount,
    required this.dateofExpense,
    required this.notesaboutExpense,
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
                PopupMenuButton(itemBuilder: (context) => popUpMenuActions),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Expense/$nameofCatagory',
              style: customTextStyleOne(color: secondGrey, fontSize: 17.sp),
            ),
            Text(
              '₹$expenseAmount',
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
              dateofExpense,
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
}
