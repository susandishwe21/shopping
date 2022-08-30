import 'package:flutter/material.dart';

/*
  Declare for api token
*/
String apiToken = "";

/*
Responsive screen height
*/
double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

/*
Responsive screen width
*/
double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

/*
Customized for Show snackbar
*/
void showCustomSnack(BuildContext context, String text,
    {Color bgColor = Colors.red}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: bgColor.withOpacity(0.7),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    content: Text(text),
    duration: const Duration(milliseconds: 1500),
  ));
}

/*
  Top Padding
*/
Widget topPadding(BuildContext context, {Color color = Colors.white}) {
  return Container(
    color: color,
    height: MediaQuery.of(context).viewPadding.top,
  );
}

/*
  Bottom Padding
*/
Widget botPadding(BuildContext context, {Color color = Colors.white}) {
  return Container(
    color: color,
    height: MediaQuery.of(context).viewPadding.bottom,
  );
}

class ShoppingColor {
  Color primaryColor = const Color(0xffff6962E7);
  Color secondaryColor = const Color(0xffffA9A6EB);
  Color homeTextColor = const Color(0xffff27214D);
}
