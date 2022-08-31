class Order {
  String productId;
  String productName;
  String amount;
  String quantity;
  String lineTotal;

  Order(
      {required this.productId,
      required this.productName,
      required this.amount,
      required this.quantity,
      required this.lineTotal});
}
