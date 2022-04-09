import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';
import 'package:money_manager_app/Splash Screen/screen_splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 255, 255, 255)));
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<ProfileDetails>(ProfileDetailsAdapter());
  Hive.registerAdapter<Categories>(CategoriesAdapter());
  Hive.registerAdapter<Transactions>(TransactionsAdapter());
  Hive.registerAdapter<RegularPayments>(RegularPaymentsAdapter());

  await Hive.openBox<ProfileDetails>('profiledetails');
  await Hive.openBox<Categories>('categories');
  await Hive.openBox<Transactions>('transactions');
  await Hive.openBox<RegularPayments>('regularPayments');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(400, 793),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () {
        return MaterialApp(
          localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],  
            theme: ThemeData(primarySwatch: Colors.grey),
            debugShowCheckedModeBanner: false,
            home: const ScreenSplash());
      },
    );
  }
}
