import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager_app/add%20transaction%20page/custom_textfield.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Name of catogory',
              style: customTextStyleOne(),
            ),
            SizedBox(
              height: 10.w,
            ),
            const CustomTextFieldThree(
              keyboardType: TextInputType.name,
              prefixIcon: Icon(
                FontAwesomeIcons.tableList,
              ),
            ),
            SizedBox(
              height: 10.w,
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
