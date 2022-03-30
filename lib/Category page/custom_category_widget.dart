import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';
import 'package:money_manager_app/homePage/Income/widgets%20and%20lists/widgets_lists.dart';

class CustomCatogoryList extends StatelessWidget {
  List<String> nameofCategories;
  CustomCatogoryList({
    Key? key,
    required this.nameofCategories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => Container(
          color: Colors.white,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.arrow_right_outlined, size: 30, ),
            title: Text(nameofCategories[index], style: customTextStyleOne(fontSize: 18.sp),),
            trailing: PopupMenuButton(itemBuilder: (context) => popUpMenuActions),
          ),
        ),
        separatorBuilder: (context, index) => SizedBox(
          height: 1.h,
        ),
        itemCount: nameofCategories.length,
      ),
    );
  }
}
