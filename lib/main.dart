import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';
import 'package:money_manager_app/Splash Screen/screen_splash.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(87, 124, 124, 124)));
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<ProfileDetails>(ProfileDetailsAdapter());
  Hive.registerAdapter<Categories>(CategoriesAdapter());
  await Hive.openBox<ProfileDetails>('profiledetails');
  await Hive.openBox<Categories>('categories');
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
            theme: ThemeData(primarySwatch: Colors.pink),
            debugShowCheckedModeBanner: false,
            home: const ScreenSplash());
      },
    );
  }
}
