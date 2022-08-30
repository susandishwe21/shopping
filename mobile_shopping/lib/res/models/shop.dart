import 'package:mobile_shopping/res/models/product.dart';

class Shop {
  String id;
  Product product;
  int qty;
  Shop({required this.product, required this.qty, required this.id});
}
