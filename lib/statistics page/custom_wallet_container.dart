import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/Category%20page/custom_category_widget.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';

import 'package:money_manager_app/customs/custom_text_and_color.dart';
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
            return ValueListenableBuilder(
                valueListenable:
                    Hive.box<Transactions>('transactions').listenable(),
                builder: (context, Box<Transactions> box, _) {
                  List<Transactions> transactions = box.values.toList();
                  List<Transactions> incomeTransactionList =
                      incomeorExpense(box.values.toList())[0];
                  List<Transactions> expenseTransactionList =
                      incomeorExpense(box.values.toList())[1];

                  double getTotalExpense() {
                    double totalAmount = 0;
                    double incometotal = 0;
                    double expensetotal = 0;
                    for (int i = 0; i < incomeTransactionList.length; i++) {
                      incometotal += incomeTransactionList[i].amount;
                    }
                    for (int i = 0; i < expenseTransactionList.length; i++) {
                      expensetotal += expenseTransactionList[i].amount;
                    }

                    totalAmount = incometotal + expensetotal;

                    return totalAmount;
                  }

                  double getUpto(int index) {
                    double getUpto = 0;
                    for (int i = 0; i <= index; i++) {
                      getUpto += transactions[i].amount;
                    }
                    return getUpto;
                  }

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Divider(
                              thickness: 3.h,
                              indent: 160.w,
                              endIndent: 160.w,
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
                          transactions.isEmpty
                              ? Center(
                                  child: CustomTotalWalletContainer(
                                    titleColor:
                                        const Color.fromARGB(255, 0, 0, 0),
                                    totalWalletAmount:
                                        '₹${widget.initialWallletAmount}',
                                    lastTransactionAmount:
                                        '+₹${widget.initialWallletAmount}',
                                  ),
                                )
                              : CustomTotalWalletContainer(
                                  titleColor:
                                      const Color.fromARGB(255, 0, 0, 0),
                                  totalWalletAmount: widget
                                                  .initialWallletAmount +
                                              getTotalExpense() >=
                                          0
                                      ? '₹${widget.initialWallletAmount + getTotalExpense()}'
                                      : '-₹${-(widget.initialWallletAmount + getTotalExpense())}',
                                  lastTransactionAmount:
                                      transactions.last.amount >= 0
                                          ? '+₹${transactions.last.amount}'
                                          : '-₹${-transactions.last.amount}',
                                ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            'Transactions',
                            style: customTextStyleOneWithUnderLine(
                                fontSize: 20.sp),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          transactions.isEmpty
                              ? Center(
                                  child: Text(
                                    'No Transactions Found',
                                    style: customTextStyleOne(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                )
                              : ListView.separated(
                                  reverse: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return CustomWalletTransactionContainer(
                                      previousTransactionAmaount: transactions[
                                                      index]
                                                  .amount >=
                                              0
                                          ? '+₹${transactions[index].amount}'
                                          : '-₹${-transactions[index].amount}',
                                      transactionAmount: widget
                                                      .initialWallletAmount +
                                                  getUpto(index) >=
                                              0
                                          ? '₹${widget.initialWallletAmount + getUpto(index)}'
                                          : '-₹${-(widget.initialWallletAmount + getUpto(index))}',
                                      transactionDate:
                                          transactions[index].dateofTransaction,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                  itemCount: transactions.length),
                          SizedBox(
                            height: 100.h,
                          )
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}

class CustomWalletTransactionContainer extends StatelessWidget {
  String transactionAmount;
  DateTime transactionDate;
  String previousTransactionAmaount;

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
              transactionAmount,
              style: customTextStyleOne(fontSize: 25),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  getText(),
                  style: customTextStyleOne(color: secondGrey, fontSize: 15),
                ),
                Text(
                  previousTransactionAmaount,
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
    return '${transactionDate.day}-${transactionDate.month}-${transactionDate.year}';
  }
}
