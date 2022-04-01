import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:money_manager_app/customs/custom_text_and_color.dart';
import 'package:money_manager_app/homePage/Income/income_detailed_page.dart';
import 'package:money_manager_app/homePage/Income/widgets%20and%20lists/widgets_lists.dart';

class CustomWalletContainer extends StatefulWidget {
  final ScrollController controller;
  final double initialWallletAmount;
  const CustomWalletContainer({
    Key? key,
    required this.controller,
    required this.initialWallletAmount,
  }) : super(key: key);

  @override
  State<CustomWalletContainer> createState() => _CustomWalletContainerState();
}

class _CustomWalletContainerState extends State<CustomWalletContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: walletPink,
      ),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          controller: widget.controller,
          itemCount: 1,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Divider(
                          thickness: 3.h,
                          indent: 160.w,
                          endIndent: 160.w,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Wallet',
                          style: customTextStyleOne(fontSize: 20.sp),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTotalWalletContainer(
                      titleColor: const Color.fromARGB(255, 0, 0, 0),
                      totalWalletAmount: widget.initialWallletAmount,
                      lastTransactionAmount: 499,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Transactions',
                      style: customTextStyleOneWithUnderLine(fontSize: 20.sp),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CustomWalletTransactionContainer(
                            previousTransactionAmaount: 499,
                            transactionAmount: 3452,
                            transactionDate: '14/03/2022',
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10.h,
                            ),
                        itemCount: 30),
                    SizedBox(
                      height: 100.h,
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class CustomWalletTransactionContainer extends StatelessWidget {
  double transactionAmount;
  String transactionDate;
  double previousTransactionAmaount;

  CustomWalletTransactionContainer({
    Key? key,
    required this.transactionAmount,
    required this.transactionDate,
    required this.previousTransactionAmaount,
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
              '₹$transactionAmount',
              style: customTextStyleOne(fontSize: 25),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  transactionDate,
                  style: customTextStyleOne(color: secondGrey, fontSize: 15),
                ),
                Text(
                  '+₹$previousTransactionAmaount',
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
