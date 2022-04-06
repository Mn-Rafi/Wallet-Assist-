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
Icon arrowNextOne = Icon(
  Icons.arrow_forward_ios_rounded,
  size: 18.w,
  color: Color.fromARGB(255, 0, 0, 0),
);
Icon arrowPrev =
    Icon(Icons.arrow_back_ios_new_rounded, size: 18.w, color: Colors.white);
Icon arrowPrevOne = Icon(Icons.arrow_back_ios_new_rounded,
    size: 18.w, color: Color.fromARGB(255, 0, 0, 0));

class CustomTotalIncomeContainer extends StatelessWidget {
  String headText;
  double totalIncomeAmount;
  double lastIncomeAmount;
  Color containerColor;
  Color titleColor;

  CustomTotalIncomeContainer({
    Key? key,
    required this.headText,
    required this.totalIncomeAmount,
    required this.lastIncomeAmount,
    this.containerColor = Colors.white,
    this.titleColor = secondGrey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              headText,
              style: customTextStyleOne(color: titleColor, fontSize: 15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹$totalIncomeAmount',
                  style: customTextStyleOne(fontSize: 25),
                ),
                Text(
                  '+₹$lastIncomeAmount',
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

class CustomTotalWalletContainer extends StatelessWidget {
  String totalWalletAmount;
  String lastTransactionAmount;
  Color titleColor;
  Color bgColor;

  CustomTotalWalletContainer({
    Key? key,
    required this.totalWalletAmount,
    required this.lastTransactionAmount,
    this.titleColor = secondGrey,
    required this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your wallet balance',
              style: customTextStyleOne(color: Colors.white, fontSize: 15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  totalWalletAmount,
                  style: customTextStyleOne(fontSize: 25,color: Colors.white),
                ),
                Text(
                  lastTransactionAmount,
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

class CustomIncomeContainer extends StatelessWidget {
  String headText;
  double totalIncomeAmount;
  DateTime incomeDate;

  CustomIncomeContainer({
    Key? key,
    required this.headText,
    required this.totalIncomeAmount,
    required this.incomeDate,
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
                  '₹$totalIncomeAmount',
                  style: customTextStyleOne(fontSize: 25),
                ),
                Text(
                  getText(),
                  style: customTextStyleOne(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getText() {
    return '${incomeDate.day}-${incomeDate.month}-${incomeDate.year}';
  }
}

List<PopupMenuEntry<dynamic>> popUpMenuActions = [
  PopupMenuItem(
    onTap: () {},
    child: GestureDetector(child: Text('Edit')),
  ),
  PopupMenuItem(child: Text('Delete')),
];
