import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';

class CustomContainerForImage extends StatelessWidget {
  String? imagePath;

  CustomContainerForImage({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.w,
      height: 60.w,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: imagePath != null
              ? Image(
                  image: FileImage(File(imagePath!)),
                  fit: BoxFit.cover,
                )
              : Image(
                  image: Image.asset('images/incomeGreen.jpg').image,
                  fit: BoxFit.cover,
                )),
    );
  }
}

class CustomContainerForCatogories extends StatelessWidget {
  Color backgroundColor;
  String imagePath;
  String title;

  CustomContainerForCatogories(
      {Key? key,
      required this.backgroundColor,
      required this.imagePath,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165.w,
      height: 100.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor,
      ),
      child: Column(
        children: [
          Expanded(child: Image.asset(imagePath)),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 8),
            child: Text(
              title,
              style: customTextStyleOne(fontSize: 15.sp),
            ),
          )
        ],
      ),
    );
  }
}

Container customTextFieldContainer(String searchInput) {
  return Container(
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 233, 233, 233),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
      child: TextField(
        onChanged: (value) {
          searchInput = value;
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Search here...',
        ),
      ),
    ),
  );
}
