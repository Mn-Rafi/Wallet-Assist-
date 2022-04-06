import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const headingFont = 'ReemKufi';
const subHeadingFont = 'RobotoCondensed';

SizedBox customSpaceOne = SizedBox(
  height: 5.w,
);

SizedBox customSpaceTwo = SizedBox(
  height: 20.w,
);

const incomeGreen = Colors.greenAccent;
const expenseBlue = Colors.redAccent;
const walletPink = Color.fromARGB(255,241,234,216);

const firstBlue = Color.fromARGB(255, 0, 8, 255);
const firstOrange = Color.fromARGB(255, 255, 77, 0);
const firstGrey = Color.fromARGB(255, 216, 216, 216);
const secondGrey = Color.fromARGB(255, 189, 189, 189);
const firstBlack = Color.fromARGB(255, 0, 0, 0);

TextStyle customTextStyleOne(
    {Color color = const Color.fromARGB(255, 0, 0, 0), double? fontSize}) {
  return TextStyle(
    fontFamily: headingFont,
    fontSize: fontSize,
    fontWeight: FontWeight.w500,
    color: color,
  );
}

TextStyle customTextStyleOneOne(
    {Color color = const Color.fromARGB(255, 0, 0, 0), double? fontSize}) {
  return TextStyle(
    fontFamily: headingFont,
    fontSize: fontSize,
    fontWeight: FontWeight.w600,
    color: color,
  );
}

TextStyle customTextStyleOneWithUnderLine(
    {Color color = const Color.fromARGB(255, 0, 0, 0), double? fontSize}) {
  return TextStyle(
    decoration: TextDecoration.underline,
    fontFamily: headingFont,
    fontSize: fontSize,
    fontWeight: FontWeight.w500,
    color: color,
  );
}

TextStyle customTextStyleTwo(
    {Color color = const Color.fromARGB(255, 0, 0, 0),
    double? fontSize,
    fontWeight = FontWeight.w600}) {
  return TextStyle(
      fontFamily: subHeadingFont,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color);
}

Icon arrowForwardIcon = Icon(
  Icons.arrow_forward,
  size: 30.w,
);

BoxDecoration customBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  color: firstGrey,
);

Text customHeading(String text) {
  return Text(
    text,
    style: customTextStyleOne(fontSize: 20.sp,),
  );
}
