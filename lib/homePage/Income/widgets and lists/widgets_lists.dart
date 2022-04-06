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
    return Hero(
      tag: 'incomeHero',
      child: Container(
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                headText,
                style: customTextStyleOne(color: Colors.white, fontSize: 15),
              ),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Text(
                    '₹$totalIncomeAmount',
                    style:
                        customTextStyleOne(fontSize: 25, color: Colors.white),
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
      ),
    );
  }
}

class CustomTotalWalletContainer extends StatelessWidget {
  final String totalWalletAmount;
  final String lastTransactionAmount;
  final Color titleColor;
  final Color bgColor;

  const CustomTotalWalletContainer({
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
              style: customTextStyleOne(fontSize: 15, color: titleColor),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  totalWalletAmount,
                  style: customTextStyleOne(fontSize: 25, color: titleColor),
                ),
                Text(
                  lastTransactionAmount,
                  style: customTextStyleOne(
                    fontSize: 16,
                  ),
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
  final String headText;
  final double totalIncomeAmount;
  final DateTime incomeDate;

  const CustomIncomeContainer({
    Key? key,
    required this.headText,
    required this.totalIncomeAmount,
    required this.incomeDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: incomeGreen,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              headText,
              style: customTextStyleOne(color: Colors.white, fontSize: 15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹$totalIncomeAmount',
                  style: customTextStyleOne(fontSize: 25, color: Colors.white),
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
