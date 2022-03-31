import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:money_manager_app/Hive/profileHiveClass/profilehiveclass.dart';
import 'package:money_manager_app/add%20transaction%20page/custom_textfield.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';
import 'package:money_manager_app/customs/custom_widgets.dart';

class CustomContainerForImageProfile extends StatelessWidget {
  String? imagePath;

  CustomContainerForImageProfile({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 150.w,
        height: 170.w,
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
                ),
        ));
  }
}

class CustomRowofprofile extends StatelessWidget {
  Icon leadingIcon;

  String title;

  CustomRowofprofile({
    Key? key,
    required this.leadingIcon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          leadingIcon,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(title, style: customTextStyleOne(fontSize: 17.w)),
          )
        ],
      ),
    );
  }
}

class EditProfile extends StatelessWidget {
  String intialName;
  String imagePath;
  EditProfile({
    Key? key,
    required this.intialName,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Name',
              style: customTextStyleOne(),
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomTextFieldThree(
              initialValue: intialName,
              keyboardType: TextInputType.name,
              prefixIcon: const Icon(
                Icons.person_pin_outlined,
              ),
            ),
            Text(
              'Edit profile photo',
              style: customTextStyleOne(),
            ),
            SizedBox(
              height: 10.h,
            ),
            GestureDetector(
              child: CustomContainerForImageProfile(imagePath: imagePath),
            ),
            SizedBox(
              height: 20.h,
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

class EditProfileDetails extends StatefulWidget {
  String initialName;
  String? initialUrl;
  String initialBalance;

  EditProfileDetails({
    Key? key,
    required this.initialName,
    required this.initialUrl,
    required this.initialBalance,
  }) : super(key: key);

  @override
  State<EditProfileDetails> createState() => _EditProfileDetailsState();
}

class _EditProfileDetailsState extends State<EditProfileDetails> {
  final formKey = GlobalKey<FormState>();
  XFile? _imageFile;
  String? userName;

  chooseImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);

    setState(() {
      _imageFile = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Edit Profile',
          style: customTextStyleOne(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customSpaceTwo,
                      CustomTextFieldTwo(
                          initialValue: widget.initialName.toString(),
                          onChanged: (value) {
                            setState(() {
                              userName = value;
                            });
                          },
                          keyboardType: TextInputType.name,
                          labelText: 'Enter your name',
                          prefixIcon: const Icon(Icons.person_pin_outlined)),
                      customSpaceTwo,
                      Text(
                        'Tap to change photo',
                        style: customTextStyleOne(
                          fontSize: 18,
                        ),
                      ),
                      customSpaceOne,
                      GestureDetector(
                        onTap: () => showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        TextButton.icon(
                                            onPressed: () {
                                                chooseImage(ImageSource.camera);
                                                Navigator.pop(ctx);},
                                            icon: const Icon(Icons.camera),
                                            label: const Text('Take Photo')),
                                        TextButton.icon(
                                            onPressed: () {
                                                chooseImage(ImageSource.gallery);
                                                Navigator.pop(ctx);},
                                            icon: const Icon(Icons.filter_sharp),
                                            label:
                                                const Text('Choose from device')),
                                      ],
                                    ),
                                  ],
                                )),
                        child: _imageFile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image(
                                    height: 150.h,
                                    width: 120.w,
                                    fit: BoxFit.cover,
                                    image: FileImage(
                                      File(
                                        _imageFile!.path,
                                      ),
                                    )),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: widget.initialUrl != null
                                    ? Image(
                                        height: 150.h,
                                        width: 120.w,
                                        fit: BoxFit.cover,
                                        image: FileImage(
                                          File(
                                            widget.initialUrl!,
                                          ),
                                        ))
                                    : Image(
                                        image: Image.asset(
                                                'images/incomeGreen.jpg')
                                            .image,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    final isValidForm = formKey.currentState!.validate();
                    if (isValidForm) {
                      Hive.box<ProfileDetails>('profiledetails').putAt(
                        0,
                        ProfileDetails(
                            nameofUser: userName == null
                                ? widget.initialName
                                : userName!,
                            initialWalletBalance: widget.initialBalance,
                            imageUrl: _imageFile == null
                                ? widget.initialUrl
                                : _imageFile?.path),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 48.h,
                    decoration: customBoxDecoration,
                    child: arrowForwardIcon,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
