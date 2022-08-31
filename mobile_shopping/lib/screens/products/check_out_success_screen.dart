import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mobile_shopping/res/values.dart';
import 'package:mobile_shopping/screens/home.dart';

class CheckOutSuccessPage extends StatefulWidget {
  const CheckOutSuccessPage({Key? key}) : super(key: key);

  @override
  State<CheckOutSuccessPage> createState() => _CheckOutSuccessPageState();
}

class _CheckOutSuccessPageState extends State<CheckOutSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(() => HomeScreen());
        return true;
      },
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            Get.off(() => HomeScreen());
          },
          child: Container(
            width: screenWidth(context),
            height: screenHeight(context),
            child: Image.asset('assets/images/success.png'),
          ),
        ),
      ),
    );
  }
}
