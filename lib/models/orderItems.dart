import 'package:cloud_firestore/cloud_firestore.dart';

class OrderItem {
  String id;
  String orderid;
  String name;
  int quantity;
  int price;
  Timestamp createdAt;
  Timestamp updatedAt;

  OrderItem({
    this.id,
    this.orderid,
    this.name,
    this.quantity,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  OrderItem.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    orderid = data['orderid'];
    name = data['name'];
    quantity = data['quantity'];
    price = data['price'];
    createdAt = data['createdAt'];
    updatedAt = data['updatedAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderid': orderid,
      'name': name,
      'quantity': quantity,
      'price': price,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
