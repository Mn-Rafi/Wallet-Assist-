import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:money_manager_app/First%20Profile/first_profile_widgets.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';

class CustomTextFieldTwo extends StatelessWidget {
  String? labelText;
  Icon prefixIcon;
  TextInputType keyboardType;
  Function(String) onChanged;
  String initialValue;

  CustomTextFieldTwo({
    Key? key,
    this.labelText,
    required this.prefixIcon,
    this.keyboardType = TextInputType.number,
    required this.onChanged,
    this.initialValue = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value != null && value.length < 3) {
          return 'Enter atleast 3 characters';
        } else {
          return null;
        }
      },
      textCapitalization: TextCapitalization.words,
      initialValue: initialValue,
      onChanged: onChanged,
      keyboardType: keyboardType,
      cursorWidth: 1,
      cursorColor: firstGrey,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: prefixIcon,
        labelText: labelText,
        labelStyle: customTextStyleOne(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

class CustomTextFieldForDate extends StatelessWidget {
  String? hint;
  Icon prefixIcon;
  Function() onTap;

  CustomTextFieldForDate({
    Key? key,
    this.hint,
    required this.prefixIcon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: true,
      cursorWidth: 1,
      cursorColor: firstGrey,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: prefixIcon,
        hintText: hint,
        labelStyle: customTextStyleOne(),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

RegExp numberReg = RegExp(r'^(?:[+0]9)?[0-9]{10}$');

class CustomTextFieldFour extends StatelessWidget {
  final String? labelText;
  final double initialValue;
  final Icon prefixIcon;
  final TextInputType keyboardType;
  final Function(String) onChanged;

  const CustomTextFieldFour({
    Key? key,
    this.initialValue = 0,
    this.labelText,
    required this.prefixIcon,
    this.keyboardType = TextInputType.number,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue !=0 ? '$initialValue' : '',
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
      ],
      validator: (value) {
        if (value != null && value.isEmpty) {
          return 'Enter a valid amount';
        } else {
          return null;
        }
      },
      maxLength: 9,
      onChanged: onChanged,
      keyboardType: keyboardType,
      cursorWidth: 1,
      cursorColor: firstGrey,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: prefixIcon,
        labelText: labelText,
        labelStyle: customTextStyleOne(),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

class CustomTextFieldThree extends StatelessWidget {
  final String? labelText;
  final Icon prefixIcon;
  final TextInputType keyboardType;
  final String initialValue;

  CustomTextFieldThree({
    Key? key,
    this.labelText,
    required this.prefixIcon,
    this.keyboardType = TextInputType.number,
    this.initialValue = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      maxLength: 30,
      keyboardType: keyboardType,
      cursorWidth: 1,
      cursorColor: firstGrey,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
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

class CustomOutlinedButton extends StatefulWidget {
  Function() onPressed;
  CustomOutlinedButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CustomOutlinedButton> createState() => _CustomOutlinedButtonState();
}

class _CustomOutlinedButtonState extends State<CustomOutlinedButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: widget.onPressed,
      child: Text(
        'Submit',
        style: customTextStyleOne(fontSize: 16),
      ),
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
    );
  }
}
