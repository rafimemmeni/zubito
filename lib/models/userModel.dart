import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String uid;
  String name;
  String mob;
  String pinCode;
  String address;
  String location;
  String role;
  Timestamp createdAt;
  Timestamp updatedAt;

  UserModel({
    this.id,
    this.uid,
    this.name,
    this.mob,
    this.pinCode,
    this.address,
    this.location,
    this.role
  });

  UserModel.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    uid = data['uid'];
    name = data['name'];
    mob = data['mob'];
    pinCode = data['pinCode'];
    address = data['address'];
    createdAt = data['createdAt'];
    updatedAt = data['updatedAt'];
    location = data['location'];
    role = data['role'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'name': name,
      'mob': mob,
      'pinCode': pinCode,
      'address': address,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'location': location,
      'role': role
    };
  }
}
