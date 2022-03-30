import 'package:flutter/material.dart';

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
    this.initialValue='',
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

class CustomTextFieldFour extends StatelessWidget {
  String? labelText;
  Icon prefixIcon;
  TextInputType keyboardType;
  Function(String) onChanged;

  CustomTextFieldFour({
    Key? key,
    this.labelText,
    required this.prefixIcon,
    this.keyboardType = TextInputType.number,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value != null && value.isEmpty) {
          return 'Enter a valid amount';
        } else {
          return null;
        }
      },
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
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
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

  const CustomTextFieldThree({
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
