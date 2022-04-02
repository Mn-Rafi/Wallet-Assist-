import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';
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
  late Box<Categories> categories;

  @override
  void initState() {
    categories = Hive.box<Categories>('categories');
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
                    child: SingleChildScrollView(
                      child: ValueListenableBuilder(
                        valueListenable: categories.listenable(),
                        builder: (context, Box<Categories> box, _) {
                          List<Categories> incomeCategories =
                              type(box.values.toList())[0];

                          return incomeCategories.isEmpty
                              ? const Padding(
                                  padding: EdgeInsets.only(top: 300),
                                  child: Text('No categories found'),
                                )
                              : ListView.builder(
                                  reverse: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: incomeCategories.length,
                                  itemBuilder: (context, index) => ListTile(
                                        trailing: PopupMenuButton(
                                            itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    onTap: () {
                                                      Future.delayed(
                                                          const Duration(
                                                              seconds: 0),
                                                          () => showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        EditIncomeCategory(
                                                                  type: true,
                                                                  index: index,
                                                                  initialValue:
                                                                      incomeCategories[
                                                                              index]
                                                                          .category,
                                                                ),
                                                              ));
                                                    },
                                                    child: const Text('Edit'),
                                                  ),
                                                  PopupMenuItem(
                                                      onTap: () {
                                                        incomeCategories[index]
                                                            .delete();
                                                      },
                                                      child:
                                                          const Text('Delete')),
                                                ]),
                                        title: Text(
                                            incomeCategories[index].category),
                                      ));
                        },
                      ),
                    ),
                  ),
                  TextButton.icon(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(0))),
                      onPressed: () => showDialog(
                          context: context,
                          builder: (ctx) => const AddCategory()),
                      icon: const Icon(
                        Icons.add_box_outlined,
                        color: Colors.red,
                      ),
                      label: Text(
                        'add new category',
                        style: customTextStyleOne(
                            color: Colors.red, fontSize: 17.sp),
                      )),
                  SizedBox(
                    height: 70.h,
                  )
                ],
              ),
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                        child: ValueListenableBuilder(
                            valueListenable: categories.listenable(),
                            builder: (context, Box<Categories> box, _) {
                              List<Categories> expenseCategories =
                                  type(box.values.toList())[1];
                              return expenseCategories.isEmpty
                                  ? const Padding(
                                      padding: EdgeInsets.only(top: 300),
                                      child: Text('No categories found'),
                                    )
                                  : ListView.builder(
                                      reverse: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: expenseCategories.length,
                                      itemBuilder: (context, index) => ListTile(
                                            trailing: PopupMenuButton(
                                                itemBuilder: (context) => [
                                                      PopupMenuItem(
                                                        onTap: () {
                                                          Future.delayed(
                                                              const Duration(
                                                                  seconds: 0),
                                                              () => showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) =>
                                                                            EditIncomeCategory(
                                                                      type:
                                                                          false,
                                                                      index:
                                                                          index,
                                                                      initialValue:
                                                                          expenseCategories[index]
                                                                              .category,
                                                                    ),
                                                                  ));
                                                        },
                                                        child:
                                                            const Text('Edit'),
                                                      ),
                                                      PopupMenuItem(
                                                          onTap: () {
                                                            expenseCategories[
                                                                    index]
                                                                .delete();
                                                          },
                                                          child: const Text(
                                                              'Delete')),
                                                    ]),
                                            title: Text(expenseCategories[index]
                                                .category),
                                          ));
                            })),
                  ),
                  TextButton.icon(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(0))),
                      onPressed: () => showDialog(
                          context: context,
                          builder: (ctx) => const AddExpenseCategory()),
                      icon: const Icon(
                        Icons.add_box_outlined,
                        color: Colors.red,
                      ),
                      label: Text(
                        'add new category',
                        style: customTextStyleOne(
                            color: Colors.red, fontSize: 17.sp),
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

List<List<Categories>> type(List<Categories> list) {
  List<Categories> incomeList = [];
  List<Categories> expenseList = [];
  List<List<Categories>> categoriesList = [incomeList, expenseList];
  for (int i = 0; i < list.length; i++) {
    if (list[i].type == true) {
      incomeList.add(list[i]);
    } else {
      expenseList.add(list[i]);
    }
  }
  return categoriesList;
}
