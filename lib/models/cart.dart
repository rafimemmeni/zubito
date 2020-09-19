import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  String id;
  String uid;
  String productId;
  int quantity;
  String image;
  Timestamp createdAt;
  Timestamp updatedAt;
  bool isDeleted;

  Cart(
      {this.id,
      this.uid,
      this.productId,
      this.createdAt,
      this.updatedAt,
      this.quantity,
      this.isDeleted,
      this.image});

  Cart.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    uid = data['uid'];
    productId = data['productId'];
    createdAt = data['createdAt'];
    updatedAt = data['updatedAt'];
    quantity = data['quantity'];
    isDeleted = data['isDeleted'];
    image = data['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'productId': productId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'quantity': quantity,
      'isDeleted': isDeleted,
      'image': image
    };
  }
}
