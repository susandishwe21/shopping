import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_shopping/res/models/product.dart';
import 'package:mobile_shopping/res/values.dart';
import 'package:mobile_shopping/screens/home.dart';

String baseUrl = 'https://assessment-api.hivestage.com/api/';

/*
  Post Login Data 
*/
Future<void> verifyLogin(String email, String password) async {
  var client = http.Client();
  try {
    var response = await client.post(
        Uri.parse(
          '${baseUrl}auth/login',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': email,
          'password': password,
        }));
    print(response.statusCode);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body)['token'];
      apiToken = result;

      Get.to(() => HomeScreen());
    } else {}
  } catch (e) {}
}

/*
  Fetch all products with pagination
*/
Future<List<Product>> getAllProducts(int limit, int page) async {
  List<Product> productList = [];
  var client = http.Client();
  print('${baseUrl}products?page=$page&size=$limit');
  try {
    var response = await client.get(
        Uri.parse(
          '${baseUrl}products?page=$page&size=$limit',
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          //'Authorization': 'Bearer $apiToken',
          'Authorization':
              'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzdSIsImF1dGgiOiJST0xFX1VTRVIiLCJpYXQiOjE2NjE3OTM3MDQsImV4cCI6MTY2MjM5ODUwNH0.KHEr7eEBG1YUHoZTwM2hGQhbvFXH_aTna_fcnAx0AgXPuMn88bmj_JX34odsKUok1QZooZszyra1oCKvl_uaFw'
        });
    print(response.statusCode);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      Iterable list = result['content'];
      for (var element in list) {
        var p = Product.fromJson(element);
        productList.add(p);
      }
    } else {}
  } catch (error) {
    Get.showSnackbar(GetSnackBar(
      title: 'Error Message',
      message: error.toString(),
      duration: const Duration(seconds: 1),
    ));
  }

  return productList;
}
