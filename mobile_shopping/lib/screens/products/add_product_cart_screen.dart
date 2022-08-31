import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shopping/res/models/shop.dart';
import 'package:mobile_shopping/res/services/api_services.dart';
import 'package:mobile_shopping/res/system_data.dart';
import 'package:mobile_shopping/res/values.dart';
import 'package:mobile_shopping/screens/products/check_out_success_screen.dart';

class AddToCartScreen extends StatefulWidget {
  final List<Shop> shop;
  const AddToCartScreen({Key? key, required this.shop}) : super(key: key);

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        topPadding(context),
        appBarCheckOut(),
        const SizedBox(
          height: 8,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Your Order",
            style: TextStyle(fontSize: 18),
          ),
        ),
        buildCartItemPage(),
        buildCheckOut(),
      ],
    ));
  }

  Widget buildCartItemPage() {
    return Expanded(
      child: Container(
        width: screenWidth(context),
        height: screenHeight(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: widget.shop.length,
                  itemBuilder: (context, index) {
                    price.value =
                        double.parse(widget.shop[index].qty.toString()) *
                            double.parse(widget.shop[index].product.amount);
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 100,
                              height: 50,
                              child: Image.network(
                                  widget.shop[index].product.image)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text("Product Code : 122477"),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${widget.shop[index].qty}x ${widget.shop[index].product.name}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${price.value} \$",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    totalCost.value.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget appBarCheckOut() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: const BoxDecoration(color: Colors.white),
      height: screenHeight(context) * 0.08,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              alignment: Alignment.center,
              width: screenWidth(context) * 0.2,
              height: double.infinity,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: const Icon(
                Icons.arrow_back_ios,
              ),
            ),
          ),
          const Center(
            child: Text(
              'Cart',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /*
  Build checkout
  */

  Widget buildCheckOut() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      width: screenWidth(context),
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            primary: ShoppingColor().primaryColor),
        onPressed: () async {
          if (widget.shop.isNotEmpty) {
            await postCheckOut(widget.shop);
          } else {
            showCustomSnack(context, "Please add product to cart");
          }
        },
        child: Text("CheckOut"),
      ),
    );
  }
}
