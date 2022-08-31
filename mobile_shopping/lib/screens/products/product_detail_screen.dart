import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shopping/res/models/product.dart';
import 'package:mobile_shopping/res/models/shop.dart';
import 'package:mobile_shopping/res/system_data.dart';
import 'package:mobile_shopping/res/values.dart';
import 'package:mobile_shopping/screens/products/add_product_cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int qty = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          topPadding(context),
          Expanded(child: buildProductDetailWidget()),
          botPadding(context),
        ],
      ),
    );
  }

  Widget buildProductDetailWidget() {
    return Obx(() {
      Rx<int> index = shopList.value
          .indexWhere((element) => element.id == widget.product.id)
          .obs;
      if (index > -1) {
        print(shopList.value[index.value].qty.toString());
        price.value = double.parse(shopList.value[index.value].qty.toString()) *
            double.parse(widget.product.amount);
      }

      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: screenWidth(context),
          height: screenHeight(context),
          child: Column(
            children: [
              Expanded(flex: 5, child: Image.network(widget.product.image)),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.product.name,
                      style: TextStyle(
                          color: ShoppingColor().homeTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 8.0),
                      child: SizedBox(
                        height: screenHeight(context) * 0.06,
                        width: screenWidth(context) * 0.3,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          color: ShoppingColor().secondaryColor,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Shop shop = Shop(
                                      id: widget.product.id,
                                      product: widget.product,
                                      qty: 1);
                                  removeCartItem(shop,
                                      isMinus: false, isChecked: isChecked);
                                  shopList.refresh();
                                },
                                icon: const Icon(Icons.remove,
                                    size: 15, color: Colors.white),
                              ),
                              index > -1
                                  ? !isChecked.value
                                      ? Obx(
                                          () => Text(
                                            shopList.value[index.value].qty
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        )
                                      : Text('0')
                                  : const Text(
                                      "0",
                                      style: TextStyle(color: Colors.white),
                                    ),
                              IconButton(
                                onPressed: () {
                                  Shop shop = Shop(
                                      id: widget.product.id,
                                      product: widget.product,
                                      qty: 1);
                                  addProduct(shop, isChecked: isChecked);
                                  shopList.refresh();
                                },
                                icon: const Icon(Icons.add,
                                    size: 15, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  flex: 5,
                  child: Text(
                    widget.product.description,
                    style: TextStyle(fontSize: 16),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    width: screenWidth(context),
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          index > -1
                              ? Text(
                                  "${price.value}" + " \$",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(widget.product.amount + " \$"),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  primary: ShoppingColor().primaryColor),
                              onPressed: () {
                                Shop shop = Shop(
                                    id: widget.product.id,
                                    product: widget.product,
                                    qty: 1);
                                addProduct(shop, isChecked: isChecked);
                                shopList.refresh();
                              },
                              child: const Text("Add to Cart"))
                        ],
                      ),
                    ),
                  )),
            ],
          ));
    });
  }
}
