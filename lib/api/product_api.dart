import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/models/product.dart';
import 'package:shoppingapp/models/cart.dart';
import 'package:shoppingapp/models/order.dart';
import 'package:shoppingapp/notifier/auth_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:shoppingapp/models/userModel.dart';
import 'package:shoppingapp/models/orderItems.dart';
import 'package:shoppingapp/notifier/auth_notifier.dart';
import 'package:shoppingapp/notifier/product_notifier.dart';
import 'package:uuid/uuid.dart';

signout(AuthNotifier authNotifier) async {
  await FirebaseAuth.instance
      .signOut()
      .catchError((error) => print(error.code));

  authNotifier.setUser(null);
}

UserModel userFromFirebase(User user) {
  return user != null ? UserModel(uid: user.uid) : null;
}

Future<User> googleSignIn() async {
  try {
    //loading.add(true);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    User user = (await _auth.signInWithCredential(credential)).user;

    //updateUserData(user);
    print("user name: ${user.displayName}");

    //loading.add(false);
    return user;
  } catch (error) {
    return error;
  }
}

Future loginAnon(AuthNotifier authNotifier) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserCredential result = await _auth.signInAnonymously();

  if (result != null) {
    User firebaseUser = result.user;

    if (firebaseUser != null) {
      print("Log In: $firebaseUser");
      authNotifier.setUser(firebaseUser);
      return userFromFirebase(firebaseUser);
    }
  }
}

initializeCurrentUser(AuthNotifier authNotifier) async {
  User firebaseUser = await FirebaseAuth.instance.currentUser;

  if (firebaseUser != null) {
    print(firebaseUser);
    authNotifier.setUser(firebaseUser);
  } else {
    await loginAnon(authNotifier);
  }
}

getCarts(ProductNotifier productNotifier, String uid) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Cart')
      .where('uid', isEqualTo: uid)
      .orderBy("id", descending: false)
      .get();

  List<Cart> _cartList = [];
  snapshot.docs.forEach((document) {
    Cart cart = Cart.fromMap(document.data());
    _cartList.add(cart);

    //productNotifier.cartByUserList = _cartList;
  });
  print('cart items');

  //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  productNotifier.cartByUserList = _cartList;
  return productNotifier.cartByUserList;
}

getCartsCount(ProductNotifier productNotifier, String uid) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Cart')
      .where('uid', isEqualTo: uid)
      .orderBy("id", descending: false)
      .get();

  List<Cart> _cartList = [];
  snapshot.docs.forEach((document) {
    Cart cart = Cart.fromMap(document.data());
    _cartList.add(cart);

    //productNotifier.cartByUserList = _cartList;
  });
  print('cart items');

  //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  productNotifier.cartByUserList = _cartList;
  return productNotifier.cartByUserList;
}

getOrderByLocation(ProductNotifier productNotifier, String location) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Order')
      .where('location', isEqualTo: location)
      .orderBy("createdAt", descending: true)
      .get();

  List<Order> _orderList = [];
  productNotifier.orderByUserList = [];
  snapshot.docs.forEach((document) async {
    Order order = Order.fromMap(document.data());

    // QuerySnapshot snapshotch = await FirebaseFirestore.instance
    //     .collection('Order')
    //     .doc(document.id)
    //     .collection("orderItems")
    //     .get();
    order.orderItems = [];
    // snapshotch.docs.forEach((documentchild) {
    //   order.orderItems.add(OrderItem.fromMap(documentchild.data()));
    // });

    _orderList.add(order);

    productNotifier.orderByUserList = _orderList;
  });
  return productNotifier.orderByUserList;
  //return productNotifier.orderByUserList;

  //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
}

getOrderByUserId(ProductNotifier productNotifier, String uid) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Order')
      .where('uid', isEqualTo: uid)
      .orderBy("id", descending: false)
      .get();

  List<Order> _orderList = [];
  productNotifier.orderByUserList = [];
  snapshot.docs.forEach((document) async {
    Order order = Order.fromMap(document.data());

    // QuerySnapshot snapshotch = await FirebaseFirestore.instance
    //     .collection('Order')
    //     .doc(document.id)
    //     .collection("orderItems")
    //     .get();
    order.orderItems = [];
    // snapshotch.docs.forEach((documentchild) {
    //   order.orderItems.add(OrderItem.fromMap(documentchild.data()));
    // });

    _orderList.add(order);

    productNotifier.orderByUserList = _orderList;
  });
  return productNotifier.orderByUserList;
  //return productNotifier.orderByUserList;

  //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
}

getProducts(
    ProductNotifier productNotifier, String category, String section) async {
  if (section != "All") {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Product')
        .where('section', isEqualTo: section)
        .orderBy("id", descending: false)
        .get();

    if (section == "Offer") {
      List<Product> _offerProductList = [];
      snapshot.docs.forEach((document) {
        Product product = Product.fromMap(document.data());
        _offerProductList.add(product);

        productNotifier.offerProductList = _offerProductList;
      });
      print('Offer');
    }
  } else {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Product')
        .where('category', isEqualTo: category)
        .orderBy("id", descending: false)
        .get();

    List<Product> _productByCategoryList = [];
    productNotifier.productByCategoryList = [];
    snapshot.docs.forEach((document) {
      Product product = Product.fromMap(document.data());
      _productByCategoryList.add(product);
      print('category:' + category);
      productNotifier.productByCategoryList = _productByCategoryList;
    });
  }
}

getOrderItemByOrderId(Order order) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Order')
      .doc(order.id)
      .collection("orderItems")
      .get();
  List<OrderItem> _orderList = [];

  snapshot.docs.forEach((document) {
    OrderItem orderItem = OrderItem.fromMap(document.data());
    _orderList.add(orderItem);
  });
  order.orderItems = _orderList;

  return order;
}

getProductById(String productId) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Product')
      .where('id', isEqualTo: productId)
      .orderBy("createdAt", descending: true)
      .get();

  Product _product;

  snapshot.docs.forEach((document) {
    Product product = Product.fromMap(document.data());
    _product = product;
  });
  print('product by id::' + _product.name);
  //productNotifier.currentProductInfo =
  return _product;
}

getUserInfo(ProductNotifier productNotifier, User _puser) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Users')
      .orderBy("createdAt", descending: true)
      .get();

  UserModel _userModel;

  snapshot.docs.forEach((document) {
    UserModel userModel = UserModel.fromMap(document.data());
    if (userModel.uid == _puser.uid) {
      _userModel = userModel;
    }
  });
  print('users::');
  productNotifier.currentUserInfo = _userModel;
}

uploadProductAndImage(Product product, bool isUpdating, File localFile,
    Function productUploaded) async {
  if (localFile != null) {
    print("uploading image");

    var fileExtension = path.extension(localFile.path);
    print(fileExtension);

    var uuid = Uuid().v4();

    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('products/images/$uuid$fileExtension');

    await firebaseStorageRef
        .putFile(localFile)
        .onComplete
        .catchError((onError) {
      print(onError);
      return false;
    });

    String url = await firebaseStorageRef.getDownloadURL();
    print("download url: $url");
    _uploadProduct(product, isUpdating, productUploaded, imageUrl: url);
  } else {
    print('...skipping image upload');
    _uploadProduct(product, isUpdating, productUploaded);
  }
}

clearCart(String userId) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Cart')
      .where('uid', isEqualTo: userId)
      .get();

  snapshot.docs.forEach((document) async {
    for (DocumentSnapshot doc in snapshot.docs) {
      await doc.reference.delete();
    }
  });

  print("deleted cart: " + userId);
}

deleteCartById(String cartId) async {
  CollectionReference productRef =
      FirebaseFirestore.instance.collection('Cart');
  productRef.doc(cartId).delete();
  print("deleted cart: " + cartId);
}

updateOrder(Order order) async {
  CollectionReference productRef =
      FirebaseFirestore.instance.collection('Order');

  if (order.id != null) {
    order.updatedAt = Timestamp.now();
    order.orderItems = null;
    //order.
    await productRef.doc(order.id).update(order.toMap());

    print('updated order with id: ${order.id}');
  }
}

saveCart(Cart cart) async {
  CollectionReference productRef =
      FirebaseFirestore.instance.collection('Cart');

  if (cart.id != null) {
    cart.updatedAt = Timestamp.now();

    await productRef.doc(cart.id).update(cart.toMap());

    print('updated CART with id: ${cart.id}');
  } else {
    cart.createdAt = Timestamp.now();

    DocumentReference documentRef = await productRef.add(cart.toMap());

    cart.id = documentRef.id;

    print('saved cart successfully: ${cart.toString()}');

    await documentRef.set(cart.toMap());
  }
}

saveOrder(Order order, List<OrderItem> orderItems) async {
  CollectionReference orderRef = FirebaseFirestore.instance.collection('Order');

  if (order.id != null) {
    order.updatedAt = Timestamp.now();

    await orderRef.doc(order.id).update(order.toMap());

    print('updated order with id: ${order.id}');
  } else {
    order.createdAt = Timestamp.now();
    order.orderStatus = "Order Placed";

    DocumentReference documentRef = await orderRef.add(order.toMap());

    order.id = documentRef.id;

    print('saved order successfully: ${order.toString()}');

    await documentRef.set(order.toMap());

    for (var orderItem in orderItems) {
      orderItem.orderid = order.id;
      DocumentReference documentRefItems =
          await documentRef.collection('orderItems').add(orderItem.toMap());
      orderItem.id = documentRefItems.id;
      await documentRefItems.set(orderItem.toMap());
    }

    print('saved order item  successfully:');
  }
}

saveUser(UserModel userModel) async {
  CollectionReference productRef =
      FirebaseFirestore.instance.collection('Users');

  if (userModel.id != null) {
    userModel.updatedAt = Timestamp.now();

    await productRef.doc(userModel.id).update(userModel.toMap());

    print('updated user with id: ${userModel.id}');
  } else {
    userModel.createdAt = Timestamp.now();

    DocumentReference documentRef = await productRef.add(userModel.toMap());

    userModel.id = documentRef.id;

    print('saved user successfully: ${userModel.toString()}');

    await documentRef.set(userModel.toMap());
  }
}

_uploadProduct(Product product, bool isUpdating, Function productUploaded,
    {String imageUrl}) async {
  CollectionReference productRef =
      FirebaseFirestore.instance.collection('Product');

  if (imageUrl != null) {
    product.image = imageUrl;
  }

  if (isUpdating) {
    //product.updatedAt = Timestamp.now();

    await productRef.doc(product.id).update(product.toMap());

    productUploaded(product);
    print('updated product with id: ${product.id}');
  } else {
    //product.createdAt = Timestamp.now();

    DocumentReference documentRef = await productRef.add(product.toMap());

    product.id = documentRef.id;

    print('uploaded product successfully: ${product.toString()}');

    await documentRef.set(product.toMap());

    productUploaded(product);
  }
}

deleteProduct(Product product, Function productDeleted) async {
  if (product.image != null) {
    StorageReference storageReference =
        await FirebaseStorage.instance.getReferenceFromUrl(product.image);

    print(storageReference.path);

    await storageReference.delete();

    print('image deleted');
  }

  await FirebaseFirestore.instance
      .collection('Product')
      .doc(product.id)
      .delete();
  productDeleted(product);
}
