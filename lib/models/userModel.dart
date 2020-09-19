import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String uid;
  String name;
  String mob;
  String address;
  Timestamp createdAt;
  Timestamp updatedAt;

  UserModel({
    this.id,
    this.uid,
    this.name,
    this.mob,
    this.address,
  });

  UserModel.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    uid = data['uid'];
    name = data['name'];
    mob = data['mob'];
    address = data['address'];
    createdAt = data['createdAt'];
    updatedAt = data['updatedAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'name': name,
      'mob': mob,
      'address': address,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
