import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';
import 'package:money_manager_app/homePage/Income/widgets%20and%20lists/widgets_lists.dart';
import 'package:money_manager_app/statistics%20page/custom_wallet_container.dart';
import 'package:money_manager_app/statistics%20page/widgets_and_classes.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';

class ScreenStatistics extends StatefulWidget {
  const ScreenStatistics({Key? key}) : super(key: key);

  @override
  State<ScreenStatistics> createState() => _ScreenStatisticsState();
}

class _ScreenStatisticsState extends State<ScreenStatistics>
    with SingleTickerProviderStateMixin {
  late List<IncomeData> _chartIncomeData;
  late List<ExpenseData> _chartExpenseData;
  late TabController _tabController;
  late TooltipBehavior _tooltipBehavior;
  String dropdownvalue = 'Monthly';
  double childSize = 0.3;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _chartIncomeData = getIncomeDate();
    _chartExpenseData = getExpenseDate();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  DateTime? timeBackButton;
  @override
  Widget build(BuildContext context) {
    List<Transactions> transactionList =
        Hive.box<Transactions>('transactions').values.toList();
    bool isCategoryEmpty(bool val) {
      int count = 0;
      for (int i = 0; i < transactionList.length; i++) {
        if (transactionList[i].type == val) {
          count++;
        }
      }
      if (count > 0) {
        return true;
      } else {
        return false;
      }
    }

    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (timeBackButton == null ||
            now.difference(timeBackButton!) > const Duration(seconds: 2)) {
          timeBackButton = now;
          final snackBar = SnackBar(
            duration: const Duration(seconds: 1),
            content: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 0.2, color: Colors.black),
                  borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 60),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'double tap to exit',
                  textAlign: TextAlign.center,
                  style: customTextStyleOne(color: firstBlack),
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 10000,
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return Future.value(false);
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Statistics',
            style: customTextStyleOne(fontSize: 20.w),
          ),
          centerTitle: true,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Column(
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DropdownButton(
                            value: dropdownvalue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(
                                  items,
                                  style: customTextStyleOne(),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                      dropdownvalue == items[0]
                          ? Row(
                              children: [
                                arrowPrevOne,
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  'March - 2022',
                                  style: customTextStyleOne(
                                      color:
                                          const Color.fromARGB(255, 255, 0, 0),
                                      fontSize: 14),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                arrowNextOne,
                              ],
                            )
                          : dropdownvalue == items[1]
                              ? Row(
                                  children: [
                                    arrowPrevOne,
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      '2022',
                                      style: customTextStyleOne(
                                          color: const Color.fromARGB(
                                              255, 255, 0, 0),
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    arrowNextOne,
                                  ],
                                )
                              : Row(
                                  children: [
                                    Text(
                                      '01-04-2022 ',
                                      style: customTextStyleOne(
                                          color: const Color.fromARGB(
                                              255, 255, 0, 0),
                                          fontSize: 14),
                                    ),
                                    Text(
                                      ' to ',
                                      style: customTextStyleOne(fontSize: 14),
                                    ),
                                    Text(
                                      ' 20-04 2022',
                                      style: customTextStyleOne(
                                          color: Color.fromARGB(255, 255, 0, 0),
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(controller: _tabController, children: [
                    transactionList.isEmpty || !isCategoryEmpty(true)
                        ? Center(
                            child: Text(
                              'No Income Transactions Found',
                              style: customTextStyleOne(),
                            ),
                          )
                        : SfCircularChart(
                            legend: Legend(
                                textStyle: customTextStyleOne(),
                                isVisible: true,
                                overflowMode: LegendItemOverflowMode.wrap),
                            tooltipBehavior: _tooltipBehavior,
                            series: <CircularSeries>[
                                PieSeries<IncomeData, String>(
                                  explode: true,
                                  dataSource: _chartIncomeData,
                                  xValueMapper: (IncomeData data, _) =>
                                      data.catogory,
                                  yValueMapper: (IncomeData data, _) =>
                                      data.amount,
                                  dataLabelSettings: DataLabelSettings(
                                      textStyle: customTextStyleOne(),
                                      showZeroValue: false,
                                      isVisible: true,
                                      labelPosition:
                                          ChartDataLabelPosition.outside),
                                  enableTooltip: true,
                                )
                              ]),
                    transactionList.isEmpty || !isCategoryEmpty(false)
                        ? Center(
                            child: Text(
                              'No Expense Transactions Found',
                              style: customTextStyleOne(),
                            ),
                          )
                        : SfCircularChart(
                            legend: Legend(
                                textStyle: customTextStyleOne(),
                                isVisible: true,
                                overflowMode: LegendItemOverflowMode.wrap),
                            tooltipBehavior: _tooltipBehavior,
                            series: <CircularSeries>[
                                PieSeries<ExpenseData, String>(
                                  explode: true,
                                  dataSource: _chartExpenseData,
                                  xValueMapper: (ExpenseData data, _) =>
                                      data.catogory,
                                  yValueMapper: (ExpenseData data, _) =>
                                      data.amount,
                                  dataLabelSettings: DataLabelSettings(
                                      showZeroValue: false,
                                      textStyle: customTextStyleOne(),
                                      isVisible: true,
                                      labelPosition:
                                          ChartDataLabelPosition.outside),
                                  enableTooltip: true,
                                )
                              ]),
                  ]),
                ),
                SizedBox(
                  height: 230.h,
                )
              ],
            ),
            ValueListenableBuilder(
                valueListenable:
                    Hive.box<ProfileDetails>('profiledetails').listenable(),
                builder: (context, Box<ProfileDetails> box, widget) {
                  List<ProfileDetails> profileDetails = box.values.toList();
                  return DraggableScrollableSheet(
                      initialChildSize: childSize,
                      maxChildSize: 0.8,
                      minChildSize: 0.2,
                      builder: (context, controller) => CustomWalletContainer(
                            initialWallletAmount: double.parse(
                                profileDetails[0].initialWalletBalance),
                            controller: controller,
                          ));
                })
          ],
        ),
      ),
    );
  }
}
