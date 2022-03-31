import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:money_manager_app/add%20transaction%20page/custom_textfield.dart';
import 'package:money_manager_app/customs/add_category.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';
import 'package:money_manager_app/customs/datepicker.dart';

var incomeCategories = [
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

var expenseCategories = [
  'Food',
  'Gift',
  'Movie',
  'Shopping',
  'Deposit',
  'Rent',
  'Subscription Charge',
  'Mobile Recharge',
  'GAS',
  'Travel',
  'Tour/Trip',
  'Other Expense',
];

class CustomAddCatogory extends StatefulWidget {
  String dropDownValue;
  List<String> categoryList;
  CustomAddCatogory({
    Key? key,
    required this.dropDownValue,
    required this.categoryList,
  }) : super(key: key);

  @override
  State<CustomAddCatogory> createState() => _CustomAddCatogoryState();
}

DateTime date = DateTime.now();

class _CustomAddCatogoryState extends State<CustomAddCatogory> {
  late String dropdownvalue = widget.dropDownValue;

  @override
  Widget build(BuildContext context) {
    String getText() {
      return '${date.day}-${date.month}-${date.year}';
    }

    return Form(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select category',
                style: customTextStyleOne(fontSize: 18.sp),
              ),
              SizedBox(
                height: 10.w,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                child: DropdownButton(
                  underline: const SizedBox(),
                  value: dropdownvalue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: widget.categoryList.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                        style: customTextStyleOne(),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),
              Row(
                children: [
                  Text(
                    'or ',
                    style: customTextStyleOne(fontSize: 20.sp),
                  ),
                  TextButton.icon(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(0))),
                      onPressed: () => showDialog(
                          context: context, builder: (ctx) => AddCategory()),
                      icon: const Icon(
                        Icons.add_box_outlined,
                        color: Colors.red,
                      ),
                      label: Text(
                        'add new category',
                        style: customTextStyleOne(
                            color: Colors.red, fontSize: 17.sp),
                      )),
                ],
              ),
              SizedBox(
                height: 20.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 160.w,
                      child: CustomTextFieldTwo(
                        onChanged: ((p0) {}),
                        prefixIcon: Icon(Icons.currency_rupee),
                        labelText: 'Amount',
                      )),
                  SizedBox(
                    width: 160.w,
                    child: CustomTextFieldForDate(
                      onTap: () {
                        pickdate(context);
                        print("HAI RAFI $date");
                      },
                      prefixIcon: const Icon(Icons.calendar_month),
                      hint: getText(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.w,
              ),
              Text(
                'Add Notes',
                style: customTextStyleOne(fontSize: 18.sp),
              ),
              SizedBox(
                height: 10.w,
              ),
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomOutlinedButton(onPressed: () => null),
                ],
              ),
              SizedBox(
                height: 20.w,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future pickdate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) {
      return;
    } else {
      setState(() {
        date = newDate;
      });
    }
  }
}
