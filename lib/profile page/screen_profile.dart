import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:money_manager_app/Category%20page/screen_catogories.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';
import 'package:money_manager_app/MainScreen/screen_home.dart';
import 'package:money_manager_app/Notification/notifications.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';
import 'package:money_manager_app/profile%20page/wifgets_of_profile.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenProfileDetails extends StatefulWidget {
  const ScreenProfileDetails({Key? key}) : super(key: key);

  @override
  State<ScreenProfileDetails> createState() => _ScreenProfileDetailsState();
}

const String _url = 'https://mn-rafi.github.io/My-Personal-Website/';

class _ScreenProfileDetailsState extends State<ScreenProfileDetails> {
  bool notificationValue =
      Hive.box<LockAuthentication>('lockAuth').values.toList()[0].enableAuth;
  bool notiValue =
      Hive.box<LockAuthentication>('lockAuth').values.toList()[0].enableNoti;
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
  }

  void _launchURL() async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

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

  DateTime? timeBackButton;
  @override
  Widget build(BuildContext context) {
    bool? _canCheckBiometrics;
    Future<void> _checkBiometrics() async {
      late bool canCheckBiometrics;
      try {
        canCheckBiometrics = await auth.canCheckBiometrics;
      } on PlatformException catch (e) {
        canCheckBiometrics = false;
        print(canCheckBiometrics);
      }
      if (!mounted) {
        return;
      }

      setState(() {
        _canCheckBiometrics = canCheckBiometrics;
      });
    }

    Future<bool> _authenticate() async {
      bool authenticated = false;
      try {
        authenticated = await auth.authenticate(
          localizedReason: ' ',
          stickyAuth: true,
          useErrorDialogs: true,
        );
        if (authenticated) {}
        return authenticated;
      } on PlatformException catch (e) {
        print(e);
        return authenticated;
      }
    }

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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Settings',
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 10.w),
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
                            style: customTextStyleOne(
                                fontSize: 22,
                                color:
                                    MediaQuery.of(context).platformBrightness ==
                                            Brightness.dark
                                        ? firstWhite
                                        : firstBlack),
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
                          activeColor:
                              MediaQuery.of(context).platformBrightness ==
                                      Brightness.dark
                                  ? walletDark
                                  : walletPink,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 16.0),
                          dense: true,
                          secondary: Icon(
                            Icons.lock,
                            size: 22.w,
                            color: MediaQuery.of(context).platformBrightness ==
                                    Brightness.dark
                                ? firstWhite
                                : firstBlack,
                          ),
                          title: Text(
                            'Enable app lock',
                            style: customTextStyleOne(
                                fontSize: 17.sp,
                                color:
                                    MediaQuery.of(context).platformBrightness ==
                                            Brightness.dark
                                        ? firstWhite
                                        : firstBlack),
                          ),
                          value: notificationValue,
                          onChanged: (value) async {
                            await _checkBiometrics();

                            if (_canCheckBiometrics!) {
                              if (await _authenticate()) {
                                Hive.box<LockAuthentication>('lockAuth').putAt(
                                    0,
                                    LockAuthentication(
                                        enableAuth: value, enableNoti: true));
                                setState(() {
                                  notificationValue =
                                      Hive.box<LockAuthentication>('lockAuth')
                                          .values
                                          .toList()[0]
                                          .enableAuth;
                                });
                              }
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBarError);
                            }
                          }),
                      SwitchListTile(
                        activeColor:
                            MediaQuery.of(context).platformBrightness ==
                                    Brightness.dark
                                ? walletDark
                                : walletPink,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 16.0),
                        dense: true,
                        secondary: Icon(
                          Icons.lock,
                          size: 22.w,
                          color: MediaQuery.of(context).platformBrightness ==
                                  Brightness.dark
                              ? firstWhite
                              : firstBlack,
                        ),
                        title: Text(
                          'Notifications',
                          style: customTextStyleOne(
                              fontSize: 17.sp,
                              color:
                                  MediaQuery.of(context).platformBrightness ==
                                          Brightness.dark
                                      ? firstWhite
                                      : firstBlack),
                        ),
                        value: notiValue,
                        onChanged: (value) {
                          Hive.box<LockAuthentication>('lockAuth').putAt(
                              0,
                              LockAuthentication(
                                  enableAuth: notificationValue, enableNoti: value));
                          setState(() {
                            notiValue = Hive.box<LockAuthentication>('lockAuth')
                                .values
                                .toList()[0]
                                .enableNoti;
                          });
                          if (notiValue) {
                            scheduledNotificationEveryday(
                                Hive.box<ProfileDetails>('profiledetails')
                                    .values
                                    .toList()[0]
                                    .nameofUser);
                          } else {
                            cancelScheduledNotificationsOne(10111);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBarNoti);
                          }
                        },
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => const ScreenCategories())),
                        child: CustomRowofprofile(
                          leadingIcon: Icon(Icons.category, size: 22.w),
                          title: 'Edit categories',
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
                                          if (notificationValue == true) {
                                            if (await _authenticate()) {
                                              await Hive.box<Transactions>(
                                                      'transactions')
                                                  .clear();
                                              await Hive.box<Categories>(
                                                      'categories')
                                                  .clear();
                                              await Hive.box<RegularPayments>(
                                                      'regularPayments')
                                                  .clear();
                                              await Hive.box<
                                                          LockAuthentication>(
                                                      'lockAuth')
                                                  .clear();
                                              for (int i = 0;
                                                  i <
                                                      listIncomeCategories
                                                          .length;
                                                  i++) {
                                                Hive.box<Categories>(
                                                        'categories')
                                                    .add(Categories(
                                                        category:
                                                            listIncomeCategories[
                                                                i],
                                                        type: true));
                                              }
                                              for (int i = 0;
                                                  i <
                                                      listExpenseCategories
                                                          .length;
                                                  i++) {
                                                Hive.box<Categories>(
                                                        'categories')
                                                    .add(Categories(
                                                        category:
                                                            listExpenseCategories[
                                                                i],
                                                        type: false));
                                              }
                                              Hive.box<LockAuthentication>(
                                                      'lockAuth')
                                                  .add(LockAuthentication(
                                                      enableAuth: false,
                                                      enableNoti: true));
                                              cancelScheduledNotifications();
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const ScreenHome()),
                                                      (route) => false);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBarOne);
                                            }
                                          } else {
                                            await Hive.box<Transactions>(
                                                    'transactions')
                                                .clear();
                                            await Hive.box<Categories>(
                                                    'categories')
                                                .clear();
                                            await Hive.box<RegularPayments>(
                                                    'regularPayments')
                                                .clear();
                                            await Hive.box<LockAuthentication>(
                                                    'lockAuth')
                                                .clear();
                                            for (int i = 0;
                                                i < listIncomeCategories.length;
                                                i++) {
                                              Hive.box<Categories>('categories')
                                                  .add(Categories(
                                                      category:
                                                          listIncomeCategories[
                                                              i],
                                                      type: true));
                                            }
                                            for (int i = 0;
                                                i <
                                                    listExpenseCategories
                                                        .length;
                                                i++) {
                                              Hive.box<Categories>('categories')
                                                  .add(Categories(
                                                      category:
                                                          listExpenseCategories[
                                                              i],
                                                      type: false));
                                            }
                                            Hive.box<LockAuthentication>(
                                                    'lockAuth')
                                                .add(LockAuthentication(
                                                    enableNoti: true,
                                                    enableAuth: false));
                                            cancelScheduledNotifications();
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const ScreenHome()),
                                                    (route) => false);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBarOne);
                                          }
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
                          title: 'Clear all',
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Share.share(
                            'MONZUMA, your smart ledger - Hai.. 👋👋 As this is the first update of the app in playstore, I can\'t provide you the shareable link. It will be fixed in few days. Thank you in advance. 💖',
                            subject: 'Look what I made!'),
                        child: CustomRowofprofile(
                          leadingIcon: Icon(
                            Icons.share,
                            size: 22.w,
                          ),
                          title: 'Share with friends',
                        ),
                      ),
                      CustomRowofprofile(
                        leadingIcon: Icon(Icons.star_outlined, size: 22.w),
                        title: 'Rate this app',
                      ),
                      GestureDetector(
                        onTap: () => Utils.openEmail(
                            toEmail: 'moideenrafihpa@gmail.com',
                            subject:
                                'Feedback about Monzuma, your smart ledger app'),
                        child: CustomRowofprofile(
                          leadingIcon: Icon(Icons.feedback, size: 22.w),
                          title: 'Feedback',
                        ),
                      ),
                      GestureDetector(
                        onTap: _launchURL,
                        child: CustomRowofprofile(
                          leadingIcon: Icon(Icons.info, size: 22.w),
                          title: 'About',
                        ),
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

final snackBarError = SnackBar(
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
        'Your device do not support biometric authentication ${Emojis.emotion_broken_heart}',
        textAlign: TextAlign.center,
        style: customTextStyleOne(color: firstBlack),
      ),
    ),
  ),
  backgroundColor: Colors.transparent,
  elevation: 10000,
  behavior: SnackBarBehavior.floating,
);

final snackBarNoti = SnackBar(
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
        'Daily notifications are removed ',
        textAlign: TextAlign.center,
        style: customTextStyleOne(color: firstBlack),
      ),
    ),
  ),
  backgroundColor: Colors.transparent,
  elevation: 10000,
  behavior: SnackBarBehavior.floating,
);

class Utils {
  static Future _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  static openEmail({
    required String toEmail,
    required String subject,
  }) async {
    final url = 'mailto:$toEmail?subject=${Uri.encodeFull(subject)}';
    await _launchUrl(url);
  }

  static Future openLink({required String url}) => _launchUrl(url);
}
