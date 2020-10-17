import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/getflutter.dart';
import 'package:getflutter/types/gf_button_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/models/product.dart';
import 'package:shoppingapp/notifier/auth_notifier.dart';
import 'package:shoppingapp/notifier/product_notifier.dart';
import 'package:shoppingapp/pages/order_page.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/commons/loaderdialog.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/widgets/homepage/search_box.dart';
import 'package:shoppingapp/widgets/shopping_cart/shopping_cart_item.dart';
import 'package:shoppingapp/api/product_api.dart';

import '../main.dart';
import 'edit_user_info_page.dart';

class ShoppingCartPage extends StatefulWidget {
  ShoppingCartPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new HomeWidgetState();
  }
}

class HomeWidgetState extends State<ShoppingCartPage>
    with SingleTickerProviderStateMixin {
  Product _product;
  int total = 0;
  int totalCartAmount = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  gettotalCartAmount(
      ProductNotifier productNotifier, AuthNotifier authNotifier) async {
    totalCartAmount = 0;
    //int totalCartAmountTemp = 0;
    await getCarts(productNotifier, authNotifier.user.uid);
    for (var cart in productNotifier.cartByUserList) {
      //final product = await getProductById(cart.productId);
      //if (cart.unit == product.unit1) {
      totalCartAmount = totalCartAmount + (cart.price * cart.quantity);
      // } else if (cart.unit == product.unit2) {
      //   totalCartAmountTemp =
      //       totalCartAmountTemp + (product.price2 * cart.quantity);
      // }
    }
    //Navigator.of(_drawerKey.currentContext, rootNavigator: true).pop();
    // setState(() {
    // totalCartAmount = totalCartAmountTemp;
    // });

    //authNotifier.totalCart = totalCartAmount;
    return totalCartAmount;
  }

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  @override
  Widget build(BuildContext context) {
    setState(() => context = context);

    final themeColor = Provider.of<ThemeNotifier>(context);
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          return Nav.routeReplacement(context, InitPage());
        },
        child: FutureBuilder<dynamic>(
            future: gettotalCartAmount(productNotifier, authNotifier),
            // ignore: missing_return
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              // if (snapshot.connectionState == ConnectionState.waiting) {
              //   return Stack(children: <Widget>[
              //     Text(
              //       "    Loading your cart...",
              //       style: GoogleFonts.poppins(
              //           fontWeight: FontWeight.w600,
              //           fontSize: 12,
              //           color: Color(0xFF5D6A78)),
              //     )
              //   ]);
              // }
              if (!snapshot.hasData) {
                // LoaderDialog.showLoadingDialog(context, _keyLoader);
                return SafeArea(
                  child: Scaffold(
                    bottomSheet: shoppingCartBottomSummary(themeColor),
                    backgroundColor: whiteColor,
                    body: Stack(
                      children: <Widget>[
                        SingleChildScrollView(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SearchBox(),
                            SizedBox(
                              height: 26,
                            ),
                            shoppingCartInfo(
                                productNotifier.cartByUserList.length),
                            SizedBox(
                              height: 12,
                            ),
                            ListView(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: <Widget>[
                                for (var cart in productNotifier.cartByUserList)
                                  ShoppingCartItem(
                                      themeColor: themeColor,
                                      imageUrl: cart.image,
                                      cart: cart),
                                SizedBox(
                                  height: 50,
                                ),
                                //_product = await getProductById(productId);
                              ],
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasData) {
                //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                return SafeArea(
                  child: Scaffold(
                    bottomSheet: shoppingCartBottomSummary(themeColor),
                    backgroundColor: whiteColor,
                    body: Stack(
                      children: <Widget>[
                        SingleChildScrollView(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SearchBox(),
                            SizedBox(
                              height: 26,
                            ),
                            shoppingCartInfo(
                                productNotifier.cartByUserList.length),
                            SizedBox(
                              height: 12,
                            ),
                            ListView(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: <Widget>[
                                for (var cart in productNotifier.cartByUserList)
                                  ShoppingCartItem(
                                      themeColor: themeColor,
                                      imageUrl: cart.image,
                                      cart: cart)

                                //_product = await getProductById(productId);
                                ,
                              ],
                            )
                          ],
                        )),
                      ],
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }

  Widget shoppingCartInfo(int cartCount) {
    return Container(
      margin: EdgeInsets.only(left: 24),
      child: Row(
        children: <Widget>[
          Text(
            "My Shopping Cart",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Color(0xFF5D6A78)),
          ),
          SizedBox(
            width: 16,
          ),
          Text(cartCount != null ? cartCount.toString() : "",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color(0xFF5D6A78))),
        ],
      ),
    );
  }

  Widget getCartButtonState(ThemeNotifier themeColor) {
    //bool isCartAdded = false;

    if (totalCartAmount == -1 || totalCartAmount == 0) {
      return Container(
          child: GFButton(
        color: themeColor.getColor(),
        child: Text(
          "Continue",
          style: GoogleFonts.poppins(color: whiteColor, fontSize: 10),
        ),
        onPressed: null,
        type: GFButtonType.solid,
        shape: GFButtonShape.pills,
      ));
    } else {
      return Container(
          child: GFButton(
        color: themeColor.getColor(),
        child: Text(
          "Continue",
          style: GoogleFonts.poppins(color: whiteColor, fontSize: 10),
        ),
        onPressed: () {
          if (totalCartAmount != 0) {
            Nav.route(
                context,
                EditUserInfoPage(
                    userSaveButtonCaption: "Confirm & Order",
                    totalCartAmount: totalCartAmount));
          }
        },
        type: GFButtonType.solid,
        shape: GFButtonShape.pills,
      ));
    }
  }

  Widget shoppingCartBottomSummary(ThemeNotifier themeColor) {
    final authNotifier = Provider.of<AuthNotifier>(context);
    //final String total = productNotifier.totalCart.toString();
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.3),
              blurRadius: 9.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: Offset(
                0.0, // Move to right 10  horizontally
                0.0, // Move to bottom 10 Vertically
              ),
            )
          ]),
      height: 75,
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Total",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, color: themeColor.getColor()),
              ),
              Text(
                //"3",
                totalCartAmount != 0 ? totalCartAmount.toString() : "...",
                style: GoogleFonts.poppins(color: themeColor.getColor()),
              ),
            ],
          ),
          getCartButtonState(themeColor)
        ],
      ),
    );
  }
}
