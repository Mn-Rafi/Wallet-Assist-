import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';
import 'package:money_manager_app/MainScreen/screen_home.dart';
import 'package:money_manager_app/Regular%20Payment/regular_payment_widget.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';

class RegularPayment extends StatefulWidget {
  const RegularPayment({Key? key}) : super(key: key);

  @override
  State<RegularPayment> createState() => _RegularPaymentState();
}

class _RegularPaymentState extends State<RegularPayment> {
  String getText(DateTime date) {
    return '${date.day}-${date.month}-${date.year}';
  }

  late Box<RegularPayments> regHive;
  @override
  void initState() {
    regHive = Hive.box<RegularPayments>('regularPayments');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const ScreenHome(),
                ),
                (route) => false),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: firstBlack,
              size: 15,
            )),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Regular Payments',
          style: customTextStyleOne(fontSize: 20.w),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
          valueListenable: regHive.listenable(),
          builder: (context, Box<RegularPayments> box, _) {
            List<RegularPayments> regList = regHive.values.toList();
            return regHive.isEmpty
                ? Center(
                    child: Text(
                    'No Regular Payments Found',
                    style: customTextStyleOne(),
                  ))
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    reverse: true,
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        leading: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(width: 0.2),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              getText(regList[index].upcomingDate),
                              style: customTextStyleOne(),
                            )),
                        title: Text(
                          regList[index].title,
                          style: customTextStyleOne(),
                        ),
                        trailing: PopupMenuButton(
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                    onTap: () {
                                      Future.delayed(
                                          const Duration(seconds: 0),
                                          () => showDialog(
                                              context: context,
                                              builder: (ctx) =>
                                                  RegularPaymentEdit(
                                                    index: index,
                                                    initialdate: regList[index]
                                                        .upcomingDate,
                                                    intialName:
                                                        regList[index].title,
                                                  )));
                                    },
                                    child: const Text('Edit'),
                                  ),
                                  PopupMenuItem(
                                      onTap: () {
                                        Future.delayed(
                                            const Duration(seconds: 0),
                                            () => showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                      title: Text(
                                                        'Notification for this payment will not be available. Continue?',
                                                        style:
                                                            customTextStyleOne(
                                                                fontSize: 15),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            regList[index]
                                                                .delete();
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            'Yes',
                                                            style:
                                                                customTextStyleOne(),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            'No',
                                                            style:
                                                                customTextStyleOne(),
                                                          ),
                                                        )
                                                      ],
                                                    )));
                                      },
                                      child: const Text('Delete')),
                                ]),
                      );
                    }),
                    itemCount: regList.length,
                  );
          }),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        foregroundColor: firstBlack,
        label: Row(
          children: [
            Text(
              'Add New  ',
              style: customTextStyleOne(),
            ),
            const Icon(
              FontAwesomeIcons.calendarPlus,
              size: 18,
            ),
          ],
        ),
        onPressed: () => showDialog(
            context: context, builder: (ctx) => const RegularPaymentAdd()),
      ),
    );
  }
}
