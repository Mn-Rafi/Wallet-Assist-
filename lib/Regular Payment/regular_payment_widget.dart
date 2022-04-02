import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager_app/add%20transaction%20page/custom_textfield.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';

class RegularPaymentAdd extends StatelessWidget {
  String intialName;
  RegularPaymentAdd({
    Key? key,
    this.intialName = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFieldThree(
              labelText: 'Title of the payment',
              keyboardType: TextInputType.name,
              prefixIcon: Icon(
                Icons.upcoming,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomTextFieldThree(
              labelText: 'Upcoming date',
              keyboardType: TextInputType.datetime,
              prefixIcon: Icon(
                Icons.calendar_month,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomOutlinedButton(
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }
}
