import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingapp/api/product_api.dart';
import 'package:shoppingapp/models/userModel.dart';
import 'package:shoppingapp/models/order.dart';
import 'package:shoppingapp/models/orderItems.dart';
import 'package:shoppingapp/notifier/auth_notifier.dart';
import 'package:shoppingapp/notifier/product_notifier.dart';
import 'package:shoppingapp/pages/orders_detail_page.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/commons/loaderdialog.dart';
import 'package:shoppingapp/utils/drop_down_menu/find_dropdown.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/widgets/commons/shadow_button.dart';
import 'package:shoppingapp/widgets/new_adress_input.dart';

import '../config.dart';
import '../main.dart';

class EditUserInfoPage extends StatefulWidget {
  final String userSaveButtonCaption;
  final int totalCartAmount;
  EditUserInfoPage({Key key, this.userSaveButtonCaption, this.totalCartAmount})
      : super(key: key);
  @override
  _EditUserInfoPageState createState() => _EditUserInfoPageState(
      userSaveButtonCaption: userSaveButtonCaption,
      totalCartAmount: totalCartAmount);
}

class _EditUserInfoPageState extends State<EditUserInfoPage> {
  final String userSaveButtonCaption;
  final int totalCartAmount;
  _EditUserInfoPageState(
      {Key key, this.userSaveButtonCaption, this.totalCartAmount});
  bool asTabs = false;
  String selectedValue;
  String preselectedValue = "dolor sit";
  List<int> selectedItems = [];
  final List<DropdownMenuItem> items = [];
  UserModel userInfo;

  final String loremIpsum =
      "FREE premium organic milk. Get recharge coupon of 100";

  getUser(AuthNotifier authNotifier, ProductNotifier productNotifier) async {
    await getUserInfo(productNotifier, authNotifier.user);
  }

  @override
  void initState() {
    @override
    String wordPair = "";
    loremIpsum
        .toLowerCase()
        .replaceAll(",", "")
        .replaceAll(".", "")
        .split(" ")
        .forEach((word) {
      if (wordPair.isEmpty) {
        wordPair = word + " ";
      } else {
        wordPair += word;
        if (items.indexWhere((item) {
              return (item.value == wordPair);
            }) ==
            -1) {
          items.add(DropdownMenuItem(
            child: Text("sfsdf"),
            value: "sdfsdfsdf",
          ));
        }
        wordPair = "";
      }
    });
    super.initState();

    super.initState();
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);

    getUser(authNotifier, productNotifier);
  }

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    final _formKey = GlobalKey<FormState>();
    userInfo = UserModel();

    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    if (productNotifier.currentUserInfo != null) {
      userInfo = productNotifier.currentUserInfo;
    }
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Color(0xFFFCFCFC),
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          return Nav.routeReplacement(context, InitPage());
        },
        child: Scaffold(
          backgroundColor: Color(0xFFFCFCFC),
          body: Builder(
            // Create an inner BuildContext so that the onPressed methods
            // can refer to the Scaffold with Scaffold.of().
            builder: (BuildContext context) {
              return Container(
                padding: EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "User information",
                          style: GoogleFonts.poppins(
                              fontSize: 18, color: Color(0xFF5D6A78)),
                        ),
                        Container(
                            width: 28,
                            child: Divider(
                              color: themeColor.getColor(),
                              height: 3,
                              thickness: 2,
                            )),
                        SizedBox(
                          height: 16,
                        ),
                        Column(
                          children: <Widget>[
                            NewAddressInput(
                                labelText: "Name",
                                hintText: 'Name',
                                isEmail: true,
                                validator: (String value) {
                                  if (value.length < 1) {
                                    return 'Please enter the Name';
                                  }
                                  _formKey.currentState.save();
                                  return null;
                                },
                                onSaved: (String value) {
                                  //model.email = value;
                                  userInfo.name = value;
                                },
                                value:
                                    userInfo.name != null ? userInfo.name : ""),
                            SizedBox(
                              height: 16,
                            ),
                            NewAddressInput(
                                labelText: "Mobile",
                                hintText: 'xxxxxxxxxx',
                                keyboardType: TextInputType.phone,
                                validator: (String value) {
                                  if (value.length < 1) {
                                    return 'Please enter a valid Mobile No.';
                                  }
                                  if (value.length < 10 || value.length > 10) {
                                    return 'Please enter a valid Mobile No.';
                                  }
                                  _formKey.currentState.save();
                                  return null;
                                },
                                onSaved: (String value) {
                                  userInfo.mob = value;
                                },
                                value:
                                    userInfo.mob != null ? userInfo.mob : ""),
                            SizedBox(
                              height: 16,
                            ),
                            NewAddressInput(
                                keyboardType: TextInputType.multiline,
                                labelText: "Address",
                                hintText: 'Enter Address here',
                                isEmail: true,
                                validator: (String value) {
                                  if (value.length < 1) {
                                    return 'Please enter the Address.';
                                  }
                                  _formKey.currentState.save();
                                  return null;
                                },
                                onSaved: (String value) {
                                  userInfo.address = value;
                                },
                                value: userInfo.address != null
                                    ? userInfo.address
                                    : ""),
                            NewAddressInput(
                                labelText: "Pin Code",
                                hintText: 'xxxxxx',
                                keyboardType: TextInputType.phone,
                                validator: (String value) {
                                  if (value.length < 1) {
                                    return 'Please enter a valid Pin Code.';
                                  }
                                  if (value.length < 6 || value.length > 6) {
                                    return 'Please enter a valid Pin code.';
                                  }
                                  _formKey.currentState.save();
                                  return null;
                                },
                                onSaved: (String value) {
                                  userInfo.pinCode = value;
                                },
                                value: userInfo.pinCode != null
                                    ? userInfo.pinCode
                                    : ""),
                            Container(
                              height: 42,
                              width: ScreenUtil.getWidth(context),
                              margin: EdgeInsets.only(top: 32, bottom: 12),
                              child: ShadowButton(
                                borderRadius: 12,
                                height: 40,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                  ),
                                  color: themeColor.getColor(),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      userInfo.uid = authNotifier.user.uid;
                                      userInfo.role = "Customer";
                                      await saveUserHandle(userInfo);

                                      if (userSaveButtonCaption != "Save") {
                                        Order order = Order();
                                        order.uid = userInfo.uid;

                                        order.address = userInfo.address;
                                        order.location =
                                            productNotifier.currentLocationInfo;
                                        order.totalPrice = totalCartAmount;
                                        await saveOrderHandle(
                                            order, productNotifier);
                                        // SharedPreferences.getInstance()
                                        //     .then((prefs) async {
                                        //   order.location = productNotifier
                                        //       .currentLocationInfo;

                                        openAlertBox(context, themeColor);
                                        // });
                                      } else {
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          backgroundColor: mainColor,
                                          content: Text(
                                              'Your Profile is successfully Saved'),
                                        ));
                                      }
                                    }
                                  },
                                  child: Text(
                                    userSaveButtonCaption,
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  openAlertBox(context, themeColor) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    width: 180,
                    child: Text("Your order has been successfully completed.",
                        style: GoogleFonts.poppins(color: Color(0xFF5D6A78))),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: 220,
                    child: RaisedButton(
                      onPressed: () {
                        Nav.routeReplacement(context, InitPage());
                      },
                      color: themeColor.getColor(),
                      child: Text(
                        "OKEY",
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Container buildAddressItem(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.2),
              blurRadius: 6.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: Offset(
                0.0, // Move to right 10  horizontally
                1.0, // Move to bottom 10 Vertically
              ),
            )
          ]),
      height: ScreenUtil.getHeight(context) / 3.1,
      width: ScreenUtil.getWidth(context),
      margin: EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "My Home Address",
            style: GoogleFonts.poppins(
                fontSize: 16, fontWeight: FontWeight.w300, color: textColor),
          ),
          Container(width: 64, child: Divider()),
          Expanded(
              child: Text(
            "Salvus devatios ducunt ad apolloniates. ducunt ad apolloniates.",
            style: GoogleFonts.poppins(
                fontSize: 14, fontWeight: FontWeight.w300, color: textColor),
          )),
          Container(width: 64, child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Invoice",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: textColor),
                  ),
                  Text(
                    "ID No",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: textColor),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Individual",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: textColor),
                  ),
                  Text(
                    "xxx xxxxdd x ddux  xx",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: textColor),
                  ),
                ],
              )
            ],
          )
        ],
      ),
      padding: EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 24),
    );
  }

  Future<void> saveUserHandle(UserModel userInfo) async {
    try {
      LoaderDialog.showLoadingDialog(context, _keyLoader, "Processing..");
      await saveUser(userInfo);

     // Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    } catch (error) {
      print(error);
    }
  }

  Future<void> saveOrderHandle(
      Order order, ProductNotifier productNotifier) async {
    try {
      LoaderDialog.showLoadingDialog(
          context, _keyLoader, "Processing..");

      List<OrderItem> _orderItems = [];
      for (var cart in productNotifier.cartByUserList) {
        final product = await getProductById(cart.productId);
        OrderItem orderItem = OrderItem();
        if (cart.unit == product.unit1) {
          orderItem.price = product.price1;
          orderItem.unit = product.unit1;
        } else if (cart.unit == product.unit2) {
          orderItem.price = product.price2;
          orderItem.unit = product.unit2;
        }

        orderItem.name = product.name;
        orderItem.quantity = cart.quantity;
        orderItem.createdAt = Timestamp.now();
        _orderItems.add(orderItem);
      }

      await saveOrder(order, _orderItems);
      await clearCart(order.uid);

      Navigator.of(_keyLoader.currentContext, rootNavigator: true)
          .pop(); //close the dialoge
      //Navigator.pushReplacementNamed(context, "/home");
    } catch (error) {
      print(error);
    }
  }
}
