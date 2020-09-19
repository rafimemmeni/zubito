import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String name;

  String category;

  String section;

  String image;

  int price;

  int mrpPrice;

  bool isliked;

  bool isSelected;
  List subIngredients = [];
  // Timestamp createdAt;
  //Timestamp updatedAt;

  Product(
      {this.id,
      this.name,
      this.category,
      this.section,
      this.price,
      this.mrpPrice,
      this.isliked,
      this.isSelected = false,
      this.image});

  Product.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    category = data['category'];
    section = data['section'];
    image = data['image'];
    price = data['price'];
    mrpPrice = data['mrpPrice'];
    //createdAt = data['createdAt'];
    //updatedAt = data['updatedAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'image': image,
      'price': price,

      ///'createdAt': createdAt,
      //'updatedAt': updatedAt,
      'mrpPrice': mrpPrice
    };
  }
}
