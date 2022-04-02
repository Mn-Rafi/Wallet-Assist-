import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'package:money_manager_app/customs/custom_text_and_color.dart';

// ignore: must_be_immutable
class CustomTextFieldOne extends StatelessWidget {
  String? labelText;
  Icon prefixIcon;

  CustomTextFieldOne({
    Key? key,
    this.labelText,
    required this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorWidth: 1,
      cursorColor: firstGrey,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: labelText,
        labelStyle: customTextStyleOne(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AddImageContainer extends StatelessWidget {
  Function onTapFunction;
  AddImageContainer({Key? key, required this.onTapFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      height: 120.w,
      decoration: customBoxDecoration,
      child: const Icon(
        Icons.add,
        size: 40,
      ),
    );
  }
}

class AddImageContainerOne extends StatelessWidget {
  String? imagePath;
  AddImageContainerOne({Key? key, this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      height: 120.w,
      decoration: customBoxDecoration,
      child: imagePath != null
          ? ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
                fit: BoxFit.cover,
                image: FileImage(
                  File(
                    imagePath!,
                  ),
                )),
          )
          : const Icon(
              Icons.add,
              size: 40,
            ),
    );
  }
}
