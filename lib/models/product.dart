import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String name;

  String category;

  String section;

  String image;
  String unit1;
  String unit2;
  int price1;
  int mrpPrice1;
  int price2;
  int mrpPrice2;

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
      this.unit1,
      this.unit2,
      this.price1,
      this.mrpPrice1,
      this.price2,
      this.mrpPrice2,
      this.isliked,
      this.isSelected = false,
      this.image});

  Product.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    category = data['category'];
    section = data['section'];
    image = data['image'];
    unit1 = data['unit1'];
    unit2 = data['unit2'];
    price1 = data['price1'];
    price2 = data['price2'];
    mrpPrice1 = data['mrpPrice1'];
    mrpPrice2 = data['mrpPrice2'];
    //createdAt = data['createdAt'];
    //updatedAt = data['updatedAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'image': image,
      'unit1': unit1,
      'unit2': unit2,
      'price1': price1,
      'price2': price2,
      'mrpPrice1': mrpPrice1,
      'mrpPrice2': mrpPrice2,
    };
  }
}
