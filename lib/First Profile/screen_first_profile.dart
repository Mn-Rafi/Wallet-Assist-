import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_manager_app/Hive/profileHiveClass/profilehiveclass.dart';
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
  XFile? _imageFile;

  String initialBalance = '0';
  String userName = '';

  chooseImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);

    setState(() {
      _imageFile = image;
    });
  }

  _storeOnboardingInfo() async {
    int isViewedFirstProfile = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onFirstProfile', isViewedFirstProfile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                              chooseImage(ImageSource.gallery);
                                              Navigator.pop(ctx);
                                            },
                                            icon:
                                                const Icon(Icons.filter_sharp),
                                            label: const Text(
                                                'Choose from device')),
                                      ],
                                    ),
                                  ],
                                )),
                        child: AddImageContainerOne(
                          imagePath: _imageFile,
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
                              imageUrl: _imageFile?.path));
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => ScreenHome(),
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
    );
  }
}
