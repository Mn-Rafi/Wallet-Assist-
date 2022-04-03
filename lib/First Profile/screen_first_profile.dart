import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';
import 'package:money_manager_app/MainScreen/screen_home.dart';
import 'package:money_manager_app/add%20transaction%20page/custom_textfield.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager_app/customs/custom_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({Key? key}) : super(key: key);

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  final formKey = GlobalKey<FormState>();
  String? imagePath;

  String initialBalance = '0';
  String userName = '';

  chooseImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      File? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'crop',
          toolbarColor: walletPink,
          toolbarWidgetColor: Colors.white,
          activeControlsWidgetColor: walletPink,
        ),
        iosUiSettings: const IOSUiSettings(
            minimumAspectRatio: 1.0, aspectRatioLockEnabled: true),
      );
      if (croppedFile != null) {
        setState(() {
          imagePath = croppedFile.path;
        });
      }
    }
  }

  _storeOnboardingInfo() async {
    int isViewedFirstProfile = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onFirstProfile', isViewedFirstProfile);
  }

  DateTime? timeBackButton;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (timeBackButton == null ||
            now.difference(timeBackButton!) > const Duration(seconds: 2)) {
          timeBackButton = now;
          final snackBar = SnackBar(
            duration: const Duration(seconds: 1),
            content: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 0.2, color: Colors.black),
                  borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 60),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'double tap to exit',
                  textAlign: TextAlign.center,
                  style: customTextStyleOne(color: firstBlack),
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 10000,
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return Future.value(false);
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Create Profile',
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
                            onChanged: (value) {
                              setState(() {
                                userName = value;
                              });
                            },
                            keyboardType: TextInputType.name,
                            labelText: 'Enter your name',
                            prefixIcon: const Icon(Icons.person_pin_outlined)),
                        customSpaceTwo,
                        CustomTextFieldFour(
                            onChanged: (value) {
                              setState(() {
                                initialBalance = value;
                              });
                            },
                            labelText: 'Current Wallet Balance',
                            prefixIcon: const Icon(Icons.currency_rupee)),
                        customSpaceTwo,
                        Text(
                          'Add a profile photo',
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          TextButton.icon(
                                              onPressed: () {
                                                chooseImage(ImageSource.camera);
                                                Navigator.pop(ctx);
                                              },
                                              icon: const Icon(Icons.camera),
                                              label: const Text('Take Photo')),
                                          TextButton.icon(
                                              onPressed: () {
                                                chooseImage(
                                                    ImageSource.gallery);
                                                Navigator.pop(ctx);
                                              },
                                              icon: const Icon(
                                                  Icons.filter_sharp),
                                              label: const Text(
                                                  'Choose from device')),
                                        ],
                                      ),
                                    ],
                                  )),
                          child: AddImageContainerOne(
                            imagePath: imagePath,
                          ),
                        )
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
                        _storeOnboardingInfo();
                        Hive.box<ProfileDetails>('profiledetails').add(
                            ProfileDetails(
                                nameofUser: userName,
                                initialWalletBalance: initialBalance,
                                imageUrl: imagePath));
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => const ScreenHome(),
                          ),
                        );
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
      ),
    );
  }
}
