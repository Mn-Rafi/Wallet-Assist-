import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:money_manager_app/customs/custom_text_and_color.dart';
import 'package:money_manager_app/homePage/Income/widgets%20and%20lists/widgets_lists.dart';

class IncomeDisplay extends StatelessWidget {
  String nameofCatagory;
  double incomeAmount;
  String dateofIncome;
  String notesaboutIncome;

  IncomeDisplay({
    Key? key,
    required this.nameofCatagory,
    required this.incomeAmount,
    required this.dateofIncome,
    required this.notesaboutIncome,
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
              'Income/$nameofCatagory',
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
              dateofIncome,
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
}
