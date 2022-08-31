import 'package:get/get.dart';
import 'package:mobile_shopping/res/models/shop.dart';

/*
Declare for global variable
*/
Rx<List<Shop>> shopList = Rx<List<Shop>>([]);
Rx<double> totalCost = 0.0.obs;
Rx<bool> isChecked = false.obs;
Rx<double> price = 0.0.obs;

/*
Add Product To Cart
*/
addProduct(Shop shop, {Rx<bool>? isChecked}) {
  isChecked!.value = true;

  Rx<int> index =
      shopList.value.indexWhere((element) => element.id == shop.id).obs;

  if (index.value > -1) {
    shopList.value[index.value].qty += 1;
    isChecked.value = false;
    print("Already Exit");
  } else {
    shopList.value.add(shop);
    isChecked.value = false;
    print("New...........");
  }
  calculateCost();
}

/*
Decrement Product To Cart
*/
removeCartItem(Shop shop, {bool? isMinus, Rx<bool>? isChecked}) {
  isChecked!.value = true;
  Rx<int> index =
      shopList.value.indexWhere((element) => element.id == shop.id).obs;

  if (index >= 0) {
    if (isMinus == null) {
      shopList.value.remove(shop);
      isChecked.value = false;
    } else {
      if (shopList.value[index.value].qty == 1) {
        shopList.value.remove(shop);
        isChecked.value = false;
      } else {
        shopList.value[index.value].qty -= 1;
        isChecked.value = false;
      }
    }
  }

  calculateCost();
}

/*
Calculate Total Cost
*/
calculateCost() {
  // Reset to zero
  totalCost.value = 0.0;

  shopList.value.forEach((element) {
    totalCost.value += double.parse(element.qty.toString()) *
        double.parse(element.product.amount);
  });
}
