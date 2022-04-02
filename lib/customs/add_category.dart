import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:money_manager_app/Hive/HiveClass/database.dart';
import 'package:money_manager_app/add%20transaction%20page/custom_textfield.dart';
import 'package:money_manager_app/add%20transaction%20page/transaction_custom_widgets.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final formKey = GlobalKey<FormState>();
  String newCategory = 'Other';

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
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                validator: (value) {
                  if (value != null && value.length < 3) {
                    return 'Enter valid category name';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  setState(() {
                    newCategory = value;
                  });
                },
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    FontAwesomeIcons.tableList,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.w,
            ),
            CustomOutlinedButton(onPressed: () {
              if (formKey.currentState!.validate()) {
                Hive.box<Categories>('categories')
                    .add(Categories(category: newCategory, type: true));

                Navigator.pop(context);
              }
            })
          ],
        ),
      ),
    );
  }
}

class EditIncomeCategory extends StatefulWidget {
  final int index;
  final String initialValue;
  final bool type;
  const EditIncomeCategory({
    Key? key,
    required this.index,
    required this.initialValue,
    required this.type,
  }) : super(key: key);

  @override
  State<EditIncomeCategory> createState() => _EditIncomeCategory();
}

class _EditIncomeCategory extends State<EditIncomeCategory> {
  final formKey = GlobalKey<FormState>();
  String newCategory = 'Other';

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
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                initialValue: widget.initialValue,
                validator: (value) {
                  if (value != null && value.length < 3) {
                    return 'Enter valid category name';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  setState(() {
                    newCategory = value;
                  });
                },
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    FontAwesomeIcons.tableList,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.w,
            ),
            CustomOutlinedButton(onPressed: () async {
              if (formKey.currentState!.validate()) {
                await Hive.box<Categories>('categories').putAt(widget.index,
                    Categories(category: newCategory, type: widget.type));
                Navigator.pop(context);
              }
            })
          ],
        ),
      ),
    );
  }
}

class AddExpenseCategory extends StatefulWidget {
  const AddExpenseCategory({Key? key}) : super(key: key);

  @override
  State<AddExpenseCategory> createState() => _AddExpenseCategory();
}

class _AddExpenseCategory extends State<AddExpenseCategory> {
  final formKey = GlobalKey<FormState>();
  String newCategory = 'Other';

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
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                validator: (value) {
                  if (value != null && value.length < 3) {
                    return 'Enter valid category name';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  setState(() {
                    newCategory = value;
                  });
                },
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    FontAwesomeIcons.tableList,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.w,
            ),
            CustomOutlinedButton(onPressed: () async {
              if (formKey.currentState!.validate()) {
                await Hive.box<Categories>('categories')
                    .add(Categories(category: newCategory, type: false));
                expenseCategories.add(newCategory);
                Navigator.pop(context);
              }
            })
          ],
        ),
      ),
    );
  }
}
