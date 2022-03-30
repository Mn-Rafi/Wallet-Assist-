import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';

var items = [
  'Monthly',
  'Yearly',
  'Period',
];

Icon arrowNext = Icon(
  Icons.arrow_forward_ios_rounded,
  size: 18.w,
  color: Colors.white,
);
Icon arrowPrev =
    Icon(Icons.arrow_back_ios_new_rounded, size: 18.w, color: Colors.white);

class CustomTotalExpenseContainer extends StatelessWidget {
  String headText;
  double totalExpenseAmount;
  double lastExpenseAmount;

  CustomTotalExpenseContainer({
    Key? key,
    required this.headText,
    required this.totalExpenseAmount,
    required this.lastExpenseAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              headText,
              style: customTextStyleOne(color: secondGrey, fontSize: 15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹$totalExpenseAmount',
                  style: customTextStyleOne(fontSize: 25),
                ),
                Text(
                  '+₹$lastExpenseAmount',
                  style: customTextStyleOne(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomExpenseContainer extends StatelessWidget {
  String headText;
  double totalExpenseAmount;
  String expenseDate;

  CustomExpenseContainer({
    Key? key,
    required this.headText,
    required this.totalExpenseAmount,
    required this.expenseDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              headText,
              style: customTextStyleOne(color: secondGrey, fontSize: 15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹$totalExpenseAmount',
                  style: customTextStyleOne(fontSize: 25),
                ),
                Text(
                  expenseDate,
                  style: customTextStyleOne(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

List<PopupMenuEntry<dynamic>> popUpMenuActions = [
  PopupMenuItem(
    onTap: (){},
    child: GestureDetector(child: Text('Edit')),
  ),
  PopupMenuItem(child: Text('Delete')),
];
