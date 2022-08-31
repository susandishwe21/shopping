import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shopping/res/services/api_services.dart';
import 'package:mobile_shopping/res/values.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController txtEmailController = TextEditingController();
  TextEditingController txtPasswordController = TextEditingController();

  bool obscureText = true;
  String password = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: buildLoginForm()),
    );
  }

  /*
  Build Login Form
  */
  Widget buildLoginForm() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Welcome!",
              style: TextStyle(
                  color: ShoppingColor().primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Email"),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: txtEmailController,
            cursorColor: ShoppingColor().primaryColor,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ShoppingColor().primaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.grey.withOpacity(0.3),
                ),
              ),
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
              hintText: '',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Password"),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: txtPasswordController,
            cursorColor: ShoppingColor().primaryColor,
            obscureText: obscureText,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: ShoppingColor().primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ),
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                hintText: '',
                suffixIcon: IconButton(
                    onPressed: () {
                      visibleToggle();
                    },
                    icon: !obscureText
                        ? Icon(
                            Icons.visibility,
                            color: ShoppingColor().secondaryColor,
                          )
                        : Icon(
                            Icons.visibility_off,
                            color: ShoppingColor().secondaryColor,
                          ))),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            width: screenWidth(context),
            height: 55,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    primary: ShoppingColor().primaryColor),
                onPressed: () async {
                  if (txtEmailController.text.isEmpty &&
                      txtPasswordController.text.isEmpty) {
                    showCustomSnack(context, 'Please Fill Email and Password',
                        bgColor: Colors.red);
                  } else {
                    await verifyLogin(context, txtEmailController.text,
                        txtPasswordController.text);
                  }
                },
                child: Text("Login")),
          )
        ],
      ),
    );
  }

  void visibleToggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
