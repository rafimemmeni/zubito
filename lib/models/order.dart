import 'package:cloud_firestore/cloud_firestore.dart';

import 'orderItems.dart';

class Order {
  String id;
  String uid;
  int quantity;
  String location;
  String address;
  String orderStatus;
  Timestamp createdAt;
  Timestamp updatedAt;
  List<OrderItem> orderItems;
  int totalPrice;

  Order(
      {this.id,
      this.uid,
      this.location,
      this.orderStatus,
      this.createdAt,
      this.updatedAt,
      this.quantity,
      this.orderItems,
      this.totalPrice,
      this.address});

  Order.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    uid = data['uid'];
    location = data['location'];
    orderStatus = data['orderStatus'];
    createdAt = data['createdAt'];
    updatedAt = data['updatedAt'];
    quantity = data['quantity'];
    orderItems = data['orderItems'];
    totalPrice = data['totalPrice'];
    address = data['address'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'location': location,
      'orderStatus': orderStatus,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'quantity': quantity,
      'orderItems': orderItems,
      'totalPrice': totalPrice,
      'address': address
    };
  }
}
