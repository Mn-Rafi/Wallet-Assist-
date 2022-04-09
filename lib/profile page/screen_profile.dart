import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/Category%20page/screen_catogories.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';
import 'package:money_manager_app/profile%20page/wifgets_of_profile.dart';

class ScreenProfileDetails extends StatefulWidget {
  const ScreenProfileDetails({Key? key}) : super(key: key);

  @override
  State<ScreenProfileDetails> createState() => _ScreenProfileDetailsState();
}

class _ScreenProfileDetailsState extends State<ScreenProfileDetails> {
  final snackBarOne = SnackBar(
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
          'Transactions cleared successfully',
          textAlign: TextAlign.center,
          style: customTextStyleOne(color: firstBlack),
        ),
      ),
    ),
    backgroundColor: Colors.transparent,
    elevation: 10000,
    behavior: SnackBarBehavior.floating,
  );

  bool notificationValue = false;
  DateTime? timeBackButton;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (timeBackButton == null ||
            now.difference(timeBackButton!) >= const Duration(seconds: 2)) {
          timeBackButton = now;

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return false;
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
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
          padding: const EdgeInsets.all(25),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomContainerForImageProfile(
                              imagePath:
                                  profileDetails[0].imageUrl?.toString()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            profileDetails[0].nameofUser.toString(),
                            style: customTextStyleOne(fontSize: 22),
                          ),
                        ],
                      ),
                      GestureDetector(
                          onTap: () => showDialog(
                              context: context,
                              builder: (ctx) => EditProfileDetails(
                                    initialBalance:
                                        profileDetails[0].initialWalletBalance,
                                    initialName: profileDetails[0].nameofUser,
                                    initialUrl:
                                        profileDetails[0].imageUrl?.toString(),
                                  )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.edit,
                                color: Colors.red,
                              ),
                              Text(
                                'edit profile',
                                style: customTextStyleOne(
                                    color: Colors.red, fontSize: 14.sp),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 20.h,
                      ),
                      SwitchListTile(
                          contentPadding: const EdgeInsets.all(0),
                          secondary: Icon(
                            Icons.notifications,
                            size: 22.w,
                            color: firstBlack,
                          ),
                          title: Text(
                            'Notification',
                            style: customTextStyleOne(fontSize: 17.sp),
                          ),
                          value: notificationValue,
                          onChanged: (value) {
                            setState(() {
                              notificationValue = value;
                            });
                          }),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => const ScreenCategories())),
                        child: CustomRowofprofile(
                          leadingIcon: Icon(Icons.category, size: 22.w),
                          title: 'Edit Categories',
                        ),
                      ),
                      GestureDetector(
                        onTap: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text(
                                    'All transactions will be removed permenantly. Continue?',
                                    style: customTextStyleOne(),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () async {
                                          await Hive.box<Transactions>(
                                                  'transactions')
                                              .clear();
                                          await Hive.box<Categories>(
                                                  'categories')
                                              .clear();
                                          for (int i = 0;
                                              i < listIncomeCategories.length;
                                              i++) {
                                            Hive.box<Categories>('categories')
                                                .add(Categories(
                                                    category:
                                                        listIncomeCategories[i],
                                                    type: true));
                                          }
                                          for (int i = 0;
                                              i < listExpenseCategories.length;
                                              i++) {
                                            Hive.box<Categories>('categories')
                                                .add(Categories(
                                                    category:
                                                        listExpenseCategories[
                                                            i],
                                                    type: false));
                                          }
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBarOne);
                                        },
                                        child: Text(
                                          'Yes',
                                          style: customTextStyleOne(),
                                        )),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(
                                        'No',
                                        style: customTextStyleOne(),
                                      ),
                                    ),
                                  ],
                                )),
                        child: CustomRowofprofile(
                          leadingIcon: Icon(Icons.remove_circle, size: 22.w),
                          title: 'Clear All',
                        ),
                      ),
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
                      SizedBox(
                        height: 70.h,
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
