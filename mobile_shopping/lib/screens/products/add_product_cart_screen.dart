import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobile_shopping/res/models/shop.dart';

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
      body: ListView.builder(
          itemCount: widget.shop.length,
          itemBuilder: (context, index) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.shop[index].product.name),
                  Text(widget.shop[index].qty.toString()),
                ],
              ),
            );
          }),
    );
  }
}
