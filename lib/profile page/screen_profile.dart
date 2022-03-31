import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/Hive/profileHiveClass/profilehiveclass.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';
import 'package:money_manager_app/profile%20page/wifgets_of_profile.dart';

class ScreenProfileDetails extends StatefulWidget {
  const ScreenProfileDetails({Key? key}) : super(key: key);

  @override
  State<ScreenProfileDetails> createState() => _ScreenProfileDetailsState();
}

class _ScreenProfileDetailsState extends State<ScreenProfileDetails> {
  bool notificationValue = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Profile',
            style: customTextStyleOne(fontSize: 20.w),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(25),
          child: ValueListenableBuilder(
              valueListenable:
                  Hive.box<ProfileDetails>('profiledetails').listenable(),
              builder: (context, Box<ProfileDetails> box, widget) {
                List<ProfileDetails> profileDetails = box.values.toList();

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomContainerForImageProfile(
                          imagePath: profileDetails[0].imageUrl.toString()),
                      Text(
                        profileDetails[0].nameofUser.toString(),
                        style: customTextStyleOne(fontSize: 22),
                      ),
                      GestureDetector(
                          excludeFromSemantics: true,
                          onTap: () => showDialog(
                              context: context,
                              builder: (ctx) => EditProfileDetails(
                                    initialBalance:
                                        profileDetails[0].initialWalletBalance,
                                    initialName: profileDetails[0].nameofUser,
                                    initialUrl:
                                        profileDetails[0].imageUrl.toString(),
                                  )),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.edit,
                                color: Colors.red,
                              ),
                              Text(
                                'edit profile',
                                style: customTextStyleOne(
                                    color: Colors.red, fontSize: 14.w),
                              ),
                            ],
                          )),
                      SwitchListTile(
                          contentPadding: const EdgeInsets.all(0),
                          secondary: Icon(
                            Icons.notifications,
                            size: 22.w,
                            color: firstBlack,
                          ),
                          title: Text(
                            'Notification',
                            style: customTextStyleOne(fontSize: 17.w),
                          ),
                          value: notificationValue,
                          onChanged: (value) {
                            setState(() {
                              notificationValue = value;
                            });
                          }),
                      CustomRowofprofile(
                        leadingIcon: Icon(
                          Icons.share,
                          size: 22.w,
                        ),
                        title: 'Share with friends',
                      ),
                      CustomRowofprofile(
                        leadingIcon: Icon(Icons.star_outlined, size: 22.w),
                        title: 'Rate this app',
                      ),
                      CustomRowofprofile(
                        leadingIcon: Icon(Icons.feedback, size: 22.w),
                        title: 'Feedback',
                      ),
                      CustomRowofprofile(
                        leadingIcon: Icon(Icons.info, size: 22.w),
                        title: 'About me',
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}