import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shopping/res/models/product.dart';
import 'package:mobile_shopping/res/models/shop.dart';
import 'package:mobile_shopping/res/services/api_services.dart';
import 'package:mobile_shopping/res/values.dart';
import 'package:mobile_shopping/screens/products/add_product_cart_screen.dart';
import 'package:mobile_shopping/screens/products/product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Rx<List<Product>> allProductsList = Rx<List<Product>>([]);
  int limit = 6;
  Rx<bool> xLoaded = false.obs;
  Rx<int> page = 1.obs;
  Rx<List<Shop>> shopList = Rx<List<Shop>>([]);
  Rx<bool> isChecked = false.obs;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await getRecords();
    xLoaded.value = true;
  }

  /*
    Call fetch all product api with limit and size
  */
  Future<void> getRecords() async {
    var allProducts = await getAllProducts(limit, page.value);
    allProducts.forEach((element) {
      allProductsList.value.add(element);
    });
    if (allProducts.isNotEmpty) {
      page.value += 1;
    }
    allProductsList.refresh();
  }

  Future<void> onRefresh() async {
    await getRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildHomeWidget(),
    );
  }

  Widget buildHomeWidget() {
    return Container(
      width: screenWidth(context),
      height: screenHeight(context),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        topPadding(context),
        appBarWidget(),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Recommended Combo",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Expanded(child: Obx(
          () {
            if (xLoaded.value) {
              return buildShowProducts();
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )),
      ]),
    );
  }

/*
 app bar for home page
*/
  Widget appBarWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.align_horizontal_left_rounded),
            Container(
              decoration: BoxDecoration(color: ShoppingColor().secondaryColor),
              child: Stack(
                children: [
                  Obx(
                    () => Transform.translate(
                      offset: Offset(30, 3),
                      child: !isChecked.value
                          ? Text(
                              shopList.value.length.toString(),
                              style: TextStyle(color: Colors.red),
                            )
                          : Text("0"),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.to(() => AddToCartScreen(
                            shop: shopList.value,
                          ));
                    },
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              'Hello Kante,',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              ' What fruit salad',
              softWrap: true,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ],
        ),
        const Text(
          'combo  do you want today?',
          softWrap: true,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: 55,
          child: TextFormField(
            autofocus: false,
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
              prefixIcon: const Icon(Icons.search),
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
              hintText: 'Search for fruit salad combos',
            ),
          ),
        ),
      ],
    );
  }

/*
  build products with pagination
*/
  Widget buildShowProducts() {
    return RefreshIndicator(
      onRefresh: () async {
        await getData();
      },
      child: Obx(
        () => GridView.builder(
            itemCount: allProductsList.value.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.80,
              mainAxisSpacing: 10,
              crossAxisSpacing: 15,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(() => ProductDetailScreen(
                        name: allProductsList.value[index].name,
                        image: allProductsList.value[index].image,
                        description: allProductsList.value[index].description,
                        qty: '0',
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: ShoppingColor().secondaryColor.withOpacity(0.06),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.topRight,
                        padding: EdgeInsets.only(right: 0, top: 5),
                        child: Icon(
                          Icons.favorite_outline,
                          size: 18,
                          color: ShoppingColor().secondaryColor,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Image.network(
                            allProductsList.value[index].image,
                            width: screenWidth(context),
                            height: screenHeight(context) / 2 * 0.3,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 10),
                            child: Text(
                              allProductsList.value[index].name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: ShoppingColor().homeTextColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(allProductsList.value[index].amount),
                                CircleAvatar(
                                  backgroundColor:
                                      ShoppingColor().secondaryColor,
                                  radius: 15,
                                  child: IconButton(
                                      onPressed: () {
                                        Shop shop = Shop(
                                            id: allProductsList.value[index].id,
                                            product:
                                                allProductsList.value[index],
                                            qty: 1);

                                        addProduct(shop);
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        size: 12,
                                        color: Colors.white,
                                      )),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

/*
Add Product To Cart
*/
  addProduct(Shop shop) {
    isChecked.value = true;
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
  }
}
