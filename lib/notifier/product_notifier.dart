import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:shoppingapp/models/order.dart';
import 'package:shoppingapp/models/product.dart';
import 'package:shoppingapp/models/userModel.dart';
import 'package:shoppingapp/models/cart.dart';

class ProductNotifier with ChangeNotifier {
  List<Product> _productList = [];
  List<Product> _offerProductList = [];
  List<Product> __productByCategoryList = [];
  List<Cart> _cartByUserList = [];
  List<Order> _orderByUserList = [];

  UserModel _currentUser;
  String _currentLocationInfo;
  Product _currentFood;
  Product _currentProduct;
  String _selectedCategory;
  int _totalCart;
  int _currentPageIndex;
  UnmodifiableListView<Product> get productList =>
      UnmodifiableListView(_productList);

  UnmodifiableListView<Product> get offerProductList =>
      UnmodifiableListView(_offerProductList);

  UnmodifiableListView<Product> get productByCategoryList =>
      UnmodifiableListView(__productByCategoryList);

  UnmodifiableListView<Cart> get cartByUserList =>
      UnmodifiableListView(_cartByUserList);

  UnmodifiableListView<Order> get orderByUserList =>
      UnmodifiableListView(_orderByUserList);

  UserModel get currentUserInfo => _currentUser;
  String get currentLocationInfo => _currentLocationInfo;
  Product get currentFood => _currentFood;
  Product get currentProduct => _currentProduct;
  String get currentCategory => _selectedCategory;
  int get totalCart => _totalCart;
  int get currentPageIndex => _currentPageIndex;

 set currentPageIndex(int currentPageIndex) {
    _currentPageIndex = currentPageIndex;
    notifyListeners();
  }

  set totalCart(int totalCart) {
    _totalCart = totalCart;
    notifyListeners();
  }

  set productList(List<Product> productList) {
    _productList = productList;
    notifyListeners();
  }

  set productByCategoryList(List<Product> productByCategoryList) {
    __productByCategoryList = productByCategoryList;
    notifyListeners();
  }

  set cartByUserList(List<Cart> cartByUserList) {
    _cartByUserList = cartByUserList;
    notifyListeners();
  }

  set orderByUserList(List<Order> orderByUserList) {
    _orderByUserList = orderByUserList;
    notifyListeners();
  }

  set offerProductList(List<Product> offerProductList) {
    _offerProductList = offerProductList;
    notifyListeners();
  }

  set currentProductInfo(Product product) {
    _currentProduct = product;
    notifyListeners();
  }

  set currentUserInfo(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }

  set currentLocationInfo(String location) {
    _currentLocationInfo = location;
    notifyListeners();
  }

  set currentCategory(String selectedCategory) {
    _selectedCategory = selectedCategory;
    notifyListeners();
  }

  set currentFood(Product product) {
    _currentFood = product;
    notifyListeners();
  }

  addFood(Product product) {
    _productList.insert(0, product);
    notifyListeners();
  }

  deleteFood(Product product) {
    _productList.removeWhere((_product) => _product.id == product.id);
    notifyListeners();
  }
}
