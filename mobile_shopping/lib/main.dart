import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_shopping/screens/home.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarColor: Colors.transparent, // status bar color
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MediaQueryData windowData =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    windowData = windowData.copyWith(
      textScaleFactor: 1.0,
    );
    return MediaQuery(
      data: windowData,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: Colors.white,
          primaryColor: Colors.white,
        ),
        //home: const LoginScreen(),
        home: const HomeScreen(),
      ),
    );
  }
}
