import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final String name;
  final String image;
  final String description;
  final String qty;
  const ProductDetailScreen(
      {Key? key,
      required this.name,
      required this.image,
      required this.description,
      required this.qty})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.description),
      ),
    );
  }
}
