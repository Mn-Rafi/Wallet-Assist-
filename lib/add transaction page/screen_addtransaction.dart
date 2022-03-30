import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager_app/add%20transaction%20page/transaction_custom_widgets.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';

class ScreenTransaction extends StatefulWidget {
  const ScreenTransaction({Key? key}) : super(key: key);

  @override
  State<ScreenTransaction> createState() => _ScreenTransactionState();
}

class _ScreenTransactionState extends State<ScreenTransaction>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;


  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Add Transaction',
          style: customTextStyleOne(fontSize: 20.w),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TabBar(
            labelStyle: customTextStyleOne(),
            labelColor: firstBlack,
            unselectedLabelColor: firstGrey,
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'INCOME',
              ),
              Tab(
                text: 'EXPENSE',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              Container(
                color: incomeGreen,
                child: CustomAddCatogory(categoryList: incomeCategories, dropDownValue: 'Salary',),
              ),
              Container(
                color: expenseBlue,
                child: CustomAddCatogory(categoryList: expenseCategories, dropDownValue: 'Food',),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
