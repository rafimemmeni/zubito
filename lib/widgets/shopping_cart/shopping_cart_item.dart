import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/api/product_api.dart';
import 'package:shoppingapp/models/cart.dart';
import 'package:shoppingapp/models/product.dart';
import 'package:shoppingapp/notifier/auth_notifier.dart';
import 'package:shoppingapp/notifier/product_notifier.dart';
import 'package:shoppingapp/pages/shopping_cart_page.dart';
import 'package:shoppingapp/utils/commons/loaderdialog.dart';
import 'package:shoppingapp/utils/drop_down_menu/find_dropdown.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';

class ShoppingCartItem extends StatelessWidget {
  final Cart cart;
  Product product;
  ShoppingCartItem(
      {Key key, @required this.themeColor, this.imageUrl, this.cart})
      : super(key: key);

  final ThemeNotifier themeColor;
  final String imageUrl;
  static Future<dynamic> loadFromStorage(
      BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }

  Future<Widget> _getImage(BuildContext context, String image) async {
    Image m;
    await loadFromStorage(context, image).then((downloadUrl) {
      m = Image.network(
        downloadUrl.toString(),
        fit: BoxFit.scaleDown,
      );
    });

    return m;
  }

  gettotalCartAmount(
      ProductNotifier productNotifier, AuthNotifier authNotifier) async {
    int totalCartAmount = 0;
    await getCarts(productNotifier, authNotifier.user.uid);
    for (var cart in productNotifier.cartByUserList) {
      totalCartAmount = totalCartAmount + (cart.price * cart.quantity);
    }
    authNotifier.totalCart = totalCartAmount;
  }

  getCurrentProductById(String productId) async {
    //return getProductById(productId);
    product = await getProductById(productId);

    return product;
  }

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  @override
  Widget build(BuildContext context) {
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return FutureBuilder<dynamic>(
        future: getCurrentProductById(cart.productId),
        // ignore: missing_return
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            //print('project snapshot data is: ${projectSnap.data}');
            return Stack(children: <Widget>[
              Text(
                "",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Color(0xFF5D6A78)),
              )
            ]);
          } else if (snapshot.hasData) {
            //print(snapshot.data);
            return Stack(
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.only(top: 8, left: 24, bottom: 8, right: 24),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[200],
                            blurRadius: 5.0,
                            spreadRadius: 1,
                            offset: Offset(0.0, 1)),
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: FutureBuilder(
                          future: _getImage(context, imageUrl),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                // fit: BoxFit.cover,
                                width: ScreenUtil.getWidth(context) * 0.30,
                                child: snapshot.data,
                              );
                            }
                            // if (snapshot.connectionState ==
                            //     ConnectionState.waiting)
                            //   return Container(
                            //       height:
                            //           MediaQuery.of(context).size.height /
                            //               1.25,
                            //       width:
                            //           MediaQuery.of(context).size.width /
                            //               1.25,
                            //       child: CircularProgressIndicator());

                            return Container();
                          },
                        ),
                        // child: ClipRRect(
                        //     borderRadius: BorderRadius.circular(8),
                        //     child: Image.asset(
                        //       "assets/images/$imageUrl",
                        //       fit: BoxFit.cover,
                        //       width: ScreenUtil.getWidth(context) * 0.30,
                        //     )),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: 160,
                        padding: EdgeInsets.all(10),
                      ),
                      Container(
                        width: ScreenUtil.getWidth(context) / 2,
                        margin: EdgeInsets.only(top: 8, bottom: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            AutoSizeText(
                              product != null ? product.name : "",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Color(0xFF5D6A78),
                                fontWeight: FontWeight.w300,
                              ),
                              maxLines: 2,
                              minFontSize: 11,
                            ),
                            Row(
                              children: <Widget>[
                                // RatingBar(
                                //   initialRating: 3,
                                //   itemSize: 14.0,
                                //   minRating: 1,
                                //   direction: Axis.horizontal,
                                //   allowHalfRating: true,
                                //   itemCount: 5,
                                //   itemBuilder: (context, _) => Container(
                                //     height: 12,
                                //     child: SvgPicture.asset(
                                //       "assets/icons/ic_star.svg",
                                //       color: themeColor.getColor(),
                                //       width: 9,
                                //     ),
                                //   ),
                                //   onRatingUpdate: (rating) {
                                //     print(rating);
                                //   },
                                // ),
                                SizedBox(
                                  width: 8,
                                ),
                                // Text(
                                //   "(395)",
                                //   style: GoogleFonts.poppins(
                                //       fontSize: 9, fontWeight: FontWeight.w400),
                                // )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 8,
                                ),
                                getCartPrice(cart)
                              ],
                            ),
                            Text(
                              cart.unit,
                              style: GoogleFonts.poppins(
                                  color: Colors.green,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 12,
                  child: IconButton(
                    icon: Icon(
                      Feather.trash,
                      size: 18,
                      color: Color(0xFF5D6A78),
                    ),
                    onPressed: () async {
                      LoaderDialog.showLoadingDialog(
                          context, _keyLoader, "Removing product from cart...");
                      await deleteCartById(cart.id);
                      await gettotalCartAmount(productNotifier, authNotifier);
                      Navigator.of(_keyLoader.currentContext,
                              rootNavigator: true)
                          .pop();
                    },
                  ),
                ),
                Positioned(
                  bottom: 24,
                  right: 32,
                  child: Container(
                    width: 55,
                    margin: EdgeInsets.only(top: 26),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: FindDropdown(
                        items: [
                          "1",
                          "2",
                          "3",
                          "4",
                          "5",
                          "6",
                          "7",
                          "8",
                          "9",
                          "10"
                        ],
                        onChanged: (String item) async {
                          cart.quantity = int.parse(item);

                          await saveCart(cart);
                          //return ShoppingCartPage();
                          LoaderDialog.showLoadingDialog(
                              context, _keyLoader, "Refreshing cart...");
                          await gettotalCartAmount(
                              productNotifier, authNotifier);

                          Navigator.of(_keyLoader.currentContext,
                                  rootNavigator: true)
                              .pop();
                          //Nav.route(context, ShoppingCartPage());
                        },
                        selectedItem: cart.quantity.toString(),
                        isUnderLine: false,
                      ),
                    ),
                  ),
                )
              ],
            );
          }
        });
  }

  Widget getCartPrice(Cart cart) {
    //bool isCartAdded = false;

    if (cart.unit.toLowerCase() == "500g") {
      return Row(
        children: <Widget>[
          Text(
            product != null ? product.mrpPrice1.toString() : "",
            style: GoogleFonts.poppins(
                decoration: TextDecoration.lineThrough,
                fontSize: 14,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            product != null ? product.price1.toString() : "",
            style: GoogleFonts.poppins(
                color: themeColor.getColor(),
                fontSize: 18,
                fontWeight: FontWeight.w300),
          ),
        ],
      );
    } else if (cart.unit.toLowerCase() == "1 kg") {
      return Row(
        children: <Widget>[
          Text(
            product != null ? product.mrpPrice2.toString() : "",
            style: GoogleFonts.poppins(
                decoration: TextDecoration.lineThrough,
                fontSize: 14,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            product != null ? product.price2.toString() : "",
            style: GoogleFonts.poppins(
                color: themeColor.getColor(),
                fontSize: 18,
                fontWeight: FontWeight.w300),
          ),
        ],
      );
    }
  }
}
