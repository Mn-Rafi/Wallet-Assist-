import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager_app/Category%20page/custom_category_widget.dart';
import 'package:money_manager_app/add%20transaction%20page/transaction_custom_widgets.dart';
import 'package:money_manager_app/customs/add_category.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';

class ScreenRemainder extends StatefulWidget {
  const ScreenRemainder({Key? key}) : super(key: key);

  @override
  State<ScreenRemainder> createState() => _ScreenRemainderState();
}

class _ScreenRemainderState extends State<ScreenRemainder>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Catogories',
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
              Column(
                children: [
                  Expanded(
                    child: CustomCatogoryList(
                        nameofCategories: incomeCategories),
                  ),
                  TextButton.icon(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(0))),
                    onPressed: ()=> showDialog(
                            context: context,
                            builder: (ctx) => const AddCategory()),
                    icon: const Icon(
                      Icons.add_box_outlined,
                      color: Colors.red,
                    ),
                    label: Text(
                      'add new category',
                      style:
                          customTextStyleOne(color: Colors.red, fontSize: 17.sp),
                    )),
                  SizedBox(
                    height: 70.h,
                  )
                ],
              ),
              Column(
                children: [
                  Expanded(
                    child: CustomCatogoryList(
                        nameofCategories: expenseCategories),
                  ),
                  TextButton.icon(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(0))),
                    onPressed: ()=> showDialog(
                            context: context,
                            builder: (ctx) => AddCategory()),
                    icon: const Icon(
                      Icons.add_box_outlined,
                      color: Colors.red,
                    ),
                    label: Text(
                      'add new category',
                      style:
                          customTextStyleOne(color: Colors.red, fontSize: 17.sp),
                    )), 
                  SizedBox(
                    height: 70.h, 
                  )
                ],
              ),
            ]),
          )
        ],
      ),
    ));
  }
}
