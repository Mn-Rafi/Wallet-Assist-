import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:money_manager_app/customs/custom_text_and_color.dart';

class CustomGridContainer extends StatefulWidget {
  int index;
  CustomGridContainer({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<CustomGridContainer> createState() => _CustomGridContainerState();
}

class _CustomGridContainerState extends State<CustomGridContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.w,
      height: 50.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: firstGrey,
        ),
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 7.0),
            child: Container(
              width: 30.w,
              height: 30.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.w),
                image: const DecorationImage(
                  image: AssetImage(
                    'images/incomeGreen.jpg',
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 110.w,
                  child: Text(
                    listohCatoDemo[widget.index],
                    overflow: TextOverflow.ellipsis,
                    style: customTextStyleOne(
                      color: secondGrey,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width:110.w,
                    child: Text(
                  "₹50000.00",
                  overflow: TextOverflow.ellipsis,
                  style: customTextStyleOne(fontSize: 18.sp),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}


List<String> listohCatoDemo =[
  'Salary',
  'Gift',
  'Share Profit',
  'Interest',
  'Allowance/Pocket Money',
  'Government Payment',
  'Scholorship',
  'Rental Income',
  'Divident income',
  'Others'
  'Salary',
  'Gift',
  'Share Profit',
  'Interest',
  'Allowance/Pocket Money',
  'Government Payment',
  'Scholorship',
  'Rental Income',
  'Divident income',
  'Others'
  'Salary',
  'Gift',
  'Share Profit',
  'Interest',
  'Allowance/Pocket Money',
  'Government Payment',
  'Scholorship',
  'Rental Income',
  'Divident income',
  'Others'
  'Salary',
  'Gift',
  'Share Profit',
  'Interest',
  'Allowance/Pocket Money',
  'Government Payment',
  'Scholorship',
  'Rental Income',
  'Divident income',
  'Others'
  'Salary',
  'Gift',
  'Share Profit',
  'Interest',
  'Allowance/Pocket Money',
  'Government Payment',
  'Scholorship',
  'Rental Income',
  'Divident income',
  'Others'
  'Salary',
  'Gift',
  'Share Profit',
  'Interest',
  'Allowance/Pocket Money',
  'Government Payment',
  'Scholorship',
  'Rental Income',
  'Divident income',
  'Others'
  'Salary',
  'Gift',
  'Share Profit',
  'Interest',
  'Allowance/Pocket Money',
  'Government Payment',
  'Scholorship',
  'Rental Income',
  'Divident income',
  'Others'

];