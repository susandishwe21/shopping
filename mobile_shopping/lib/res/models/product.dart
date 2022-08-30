class Product {
  String id;
  String name;
  String image;
  String amount;
  String description;
  String date;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.amount,
    required this.date,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"].toString(),
      name: json["name"].toString(),
      image: json["image"].toString(),
      amount: json["amount"].toString(),
      description: json['description'].toString(),
      date: json['createdDate'].toString(),
    );
  }
}
