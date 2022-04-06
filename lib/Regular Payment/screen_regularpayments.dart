import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager_app/MainScreen/screen_home.dart';
import 'package:money_manager_app/Regular%20Payment/regular_payment_widget.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';

class RegularPayment extends StatelessWidget {
  const RegularPayment({Key? key}) : super(key: key);

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
      body: const Center(child: Text('No Regular Payments Found')),
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
        onPressed: () =>
            showDialog(context: context, builder: (ctx) => RegularPaymentAdd()),
      ),
    );
  }
}
