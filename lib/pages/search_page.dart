import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/shape/gf_button_shape.dart';
import 'package:getflutter/types/gf_button_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/api/product_api.dart';
import 'package:shoppingapp/models/product.dart';
import 'package:shoppingapp/models/cart.dart';
import 'package:shoppingapp/pages/filter_page.dart';
import 'package:shoppingapp/pages/product_detail.dart';
import 'package:shoppingapp/pages/shopping_cart_page.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/commons/loaderdialog.dart';
import 'package:shoppingapp/utils/drop_down_menu/find_dropdown.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/notifier/product_notifier.dart';
import 'package:shoppingapp/notifier/auth_notifier.dart';

import 'edit_user_info_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key key,
    this.categoryName,
  }) : super(key: key);
  final String categoryName;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int piece = 1;
  String deneme = "Dursun";
  Cart cart;
  int totalCartAmount = 0;
  bool enableCart = false;
  int price = 0;
  int mrpPrice = 0;
  String selectedProductId;
  Future _getCategories;

  @override
  void initState() {
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    //getCarts(productNotifier, authNotifier.user.uid);
    _getCategories = gettotalCartAmount(productNotifier, authNotifier);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  gettotalCartAmount(
      ProductNotifier productNotifier, AuthNotifier authNotifier) async {
    totalCartAmount = -1;
    int totalCartAmountTemp = 0;
    await getProducts(productNotifier, widget.categoryName, "All");
    await getCarts(productNotifier, authNotifier.user.uid);

    // await getCarts(productNotifier, authNotifier.user.uid);
    for (var cart in productNotifier.cartByUserList) {
      //final product = await getProductById(cart.productId);
      //if (cart.unit == product.unit1) {
      totalCartAmountTemp = totalCartAmountTemp + (cart.price * cart.quantity);
      // } else if (cart.unit == product.unit2) {
      //   totalCartAmountTemp =
      //       totalCartAmountTemp + (product.price2 * cart.quantity);
      // }
    }
    setState(() {
      totalCartAmount = totalCartAmountTemp;
    });

    return totalCartAmount;
  }

  static Future<dynamic> loadFromStorage(
      BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }

  Future<void> saveCartHandle(Cart cart) async {
    LoaderDialog.showLoadingDialog(
        context, _drawerKey, "Adding product to cart...");
    await saveCart(cart);
    Navigator.of(_drawerKey.currentContext, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    final productNotifier = Provider.of<ProductNotifier>(context);
    final authNotifier = Provider.of<AuthNotifier>(context);

    GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 252, 252, 252),
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));
    List<String> prodcutListType = [
      'Bestsellers',
      'Favourites',
      'The best',
      'The most recent',
      'Bestsellers',
      'Favourites',
      'The best',
      'The most recent',
    ];

    return SafeArea(
      child: Scaffold(
        bottomSheet: shoppingCartBottomSummary(themeColor),
        backgroundColor: Color.fromARGB(255, 252, 252, 252),
        key: _drawerKey, // assign key to Scaffold
        body: FutureBuilder<dynamic>(
            future: _getCategories,
            //gettotalCartAmount(productNotifier, authNotifier),
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
                return Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                width: 32,
                                padding: const EdgeInsets.only(top: 8.0),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.chevron_left,
                                    color: themeColor.getColor(),
                                    size: 32,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              Container(
                                width: ScreenUtil.getWidth(context) - 80,
                                margin: EdgeInsets.only(left: 22, top: 14),
                                padding: EdgeInsets.only(left: 18, right: 18),
                                height: 44,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[200],
                                        blurRadius: 8.0,
                                        spreadRadius: 1,
                                        offset: Offset(0.0, 3))
                                  ],
                                  color: Theme.of(context).bottomAppBarColor,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "assets/icons/ic_search.svg",
                                      color: Colors.black45,
                                      height: 12,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: 4),
                                        height: 72,
                                        child: TextFormField(
                                          key: _formKey,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Brand Search",
                                              hintStyle: GoogleFonts.poppins(
                                                fontSize: 13,
                                                color: Color(0xFF5D6A78),
                                                fontWeight: FontWeight.w400,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: ScreenUtil.getWidth(context) - 20,
                            margin: EdgeInsets.only(top: 24, left: 8),
                            padding: EdgeInsets.only(left: 18, right: 22),
                            height: 44,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[200],
                                    blurRadius: 8.0,
                                    spreadRadius: 1,
                                    offset: Offset(0.0, 3))
                              ],
                              color: Theme.of(context).bottomAppBarColor,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Material(
                                  color: Colors.white,
                                  child: InkWell(
                                    onTap: () {
                                      _sortingBottomSheet();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(12),
                                      child: Row(children: <Widget>[
                                        RotatedBox(
                                            quarterTurns: 3,
                                            child: Icon(
                                              Ionicons.ios_swap,
                                              size: 16,
                                            )),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          "Sort",
                                          style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: Color(0xFF5D6A78)),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                                Material(
                                  color: Colors.white,
                                  child: InkWell(
                                    onTap: () {
                                      Nav.route(context, FilterPage());
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(12),
                                      child: Row(children: <Widget>[
                                        SvgPicture.asset(
                                          "assets/icons/funnel.svg",
                                          height: 14,
                                          color: Color(0xFF5D6A78),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          "Filter",
                                          style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: Color(0xFF5D6A78)),
                                        )
                                      ]),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 18, left: 16),
                            height: 42,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: prodcutListType.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(right: 8, bottom: 8),
                                    padding:
                                        EdgeInsets.only(left: 12, right: 12),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey[200],
                                            blurRadius: 8.0,
                                            spreadRadius: 1,
                                            offset: Offset(0.0, 3))
                                      ],
                                      color:
                                          Theme.of(context).bottomAppBarColor,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          prodcutListType[index],
                                          style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: Color(0xFF5D6A78)),
                                        )),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 1,
                            childAspectRatio: 3.0,
                            children: <Widget>[
                              for (var product
                                  in productNotifier.productByCategoryList)
                                ProductItemWidget(
                                    product: product, parent: this)
                              // productSearchItem(
                              //     context, themeColor, product, _drawerKey)
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasData) {
                return Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                width: 32,
                                padding: const EdgeInsets.only(top: 8.0),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.chevron_left,
                                    color: themeColor.getColor(),
                                    size: 32,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              Container(
                                width: ScreenUtil.getWidth(context) - 80,
                                margin: EdgeInsets.only(left: 22, top: 14),
                                padding: EdgeInsets.only(left: 18, right: 18),
                                height: 44,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[200],
                                        blurRadius: 8.0,
                                        spreadRadius: 1,
                                        offset: Offset(0.0, 3))
                                  ],
                                  color: Theme.of(context).bottomAppBarColor,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "assets/icons/ic_search.svg",
                                      color: Colors.black45,
                                      height: 12,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: 4),
                                        height: 72,
                                        child: TextFormField(
                                          key: _formKey,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Brand Search",
                                              hintStyle: GoogleFonts.poppins(
                                                fontSize: 13,
                                                color: Color(0xFF5D6A78),
                                                fontWeight: FontWeight.w400,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: ScreenUtil.getWidth(context) - 20,
                            margin: EdgeInsets.only(top: 24, left: 8),
                            padding: EdgeInsets.only(left: 18, right: 22),
                            height: 44,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[200],
                                    blurRadius: 8.0,
                                    spreadRadius: 1,
                                    offset: Offset(0.0, 3))
                              ],
                              color: Theme.of(context).bottomAppBarColor,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Material(
                                  color: Colors.white,
                                  child: InkWell(
                                    onTap: () {
                                      _sortingBottomSheet();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(12),
                                      child: Row(children: <Widget>[
                                        RotatedBox(
                                            quarterTurns: 3,
                                            child: Icon(
                                              Ionicons.ios_swap,
                                              size: 16,
                                            )),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          "Sort",
                                          style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: Color(0xFF5D6A78)),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                                Material(
                                  color: Colors.white,
                                  child: InkWell(
                                    onTap: () {
                                      Nav.route(context, FilterPage());
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(12),
                                      child: Row(children: <Widget>[
                                        SvgPicture.asset(
                                          "assets/icons/funnel.svg",
                                          height: 14,
                                          color: Color(0xFF5D6A78),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          "Filter",
                                          style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: Color(0xFF5D6A78)),
                                        )
                                      ]),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 18, left: 16),
                            height: 42,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: prodcutListType.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(right: 8, bottom: 8),
                                    padding:
                                        EdgeInsets.only(left: 12, right: 12),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey[200],
                                            blurRadius: 8.0,
                                            spreadRadius: 1,
                                            offset: Offset(0.0, 3))
                                      ],
                                      color:
                                          Theme.of(context).bottomAppBarColor,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          prodcutListType[index],
                                          style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: Color(0xFF5D6A78)),
                                        )),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 1,
                            childAspectRatio: 3.0,
                            children: <Widget>[
                              for (var product
                                  in productNotifier.productByCategoryList)
                                ProductItemWidget(
                                    product: product, parent: this)
                              // productSearchItem(
                              //     context, themeColor, product, _drawerKey)
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }

  void _sortingBottomSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 24,
                ),
                Container(
                    margin: EdgeInsets.only(left: 36, top: 12),
                    child: Text(
                      "Sort Products By",
                      style: GoogleFonts.poppins(color: Color(0xFF5D6A78)),
                    )),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 32, top: 24),
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/icons/checkbox1.svg",
                            height: 18,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text("Smart Sort",
                              style: GoogleFonts.poppins(
                                  color: Color(0xFFA1B1C2))),
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 32, top: 20),
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/icons/checkbox2.svg",
                            height: 18,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text("Newest",
                              style: GoogleFonts.poppins(
                                  color: Color(0xFFA1B1C2))),
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 32, top: 20),
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/icons/checkbox1.svg",
                            height: 18,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text("Min Price",
                              style: GoogleFonts.poppins(
                                  color: Color(0xFFA1B1C2))),
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 32, top: 20),
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/icons/checkbox1.svg",
                            height: 18,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text("Max Price",
                              style: GoogleFonts.poppins(
                                  color: Color(0xFFA1B1C2))),
                        ],
                      )),
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          );
        });
  }

  Widget getCartButton(ProductNotifier productNotifier,
      AuthNotifier authNotifier, Product product, bool isCartAdded) {
    //bool isCartAdded = false;

    if (isCartAdded) {
      return Container(
        padding: EdgeInsets.only(top: 8, left: 8, bottom: 8, right: 8),
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
        child: InkWell(
          onTap: () async {
            cart = Cart();
            // cart.uid = authNotifier.user.uid;
            // cart.quantity = 1;
            // cart.productId = product.id;
            // cart.image = product.image;

            // await saveCartHandle(cart);
            // Scaffold.of(context).showSnackBar(SnackBar(
            //   content: Text('Product added to cart'),
            // ));
            //close the dialoge
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                  onTap: () {
                    setState(() {
                      if (piece != 0) {
                        piece--;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      "-",
                      style: TextStyle(fontSize: 24, color: Colors.red),
                    ),
                  )),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Color(0xFF707070),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    width: 40,
                    height: 32,
                    padding: const EdgeInsets.all(8.0),
                    child: Text('$piece',
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 14)),
                  )),
              InkWell(
                  onTap: () {
                    setState(() {
                      if (piece != 99) {
                        piece++;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text("+", style: TextStyle(color: Colors.red)),
                  )),
            ],
          ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(top: 8, left: 8, bottom: 8, right: 8),
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
        child: InkWell(
          onTap: () async {
            cart = Cart();
            cart.uid = authNotifier.user.uid;
            cart.quantity = 1;
            cart.productId = product.id;
            cart.image = product.image;

            await saveCartHandle(cart);
            await gettotalCartAmount(productNotifier, authNotifier);
            setState(() {
              isCartAdded = true;
            });

            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Product added to cart'),
            ));

            //close the dialoge
          },
          child: Row(children: <Widget>[
            Text(
              "ADD ",
            ),
            Container(
              child: SvgPicture.asset(
                "assets/icons/ic_product_shopping_cart.svg",
                height: 20,
              ),
            )
          ]),
        ),
      );
    }
  }

  Widget getCartButtonState(ThemeNotifier themeColor) {
    //bool isCartAdded = false;

    if (totalCartAmount == -1 || totalCartAmount == 0) {
      return Container(
          child: GFButton(
        color: themeColor.getColor(),
        child: Text(
          "Go to Cart",
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
          "Go to Cart",
          style: GoogleFonts.poppins(color: whiteColor, fontSize: 10),
        ),
        onPressed: () {
          if (totalCartAmount != 0) {
            Nav.route(context, ShoppingCartPage());
          }
        },
        type: GFButtonType.solid,
        shape: GFButtonShape.pills,
      ));
    }
  }

  Widget shoppingCartBottomSummary(ThemeNotifier themeColor) {
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
                totalCartAmount != -1
                    ? totalCartAmount.toString()
                    : "Refreshing...",
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

class ProductItemWidget extends StatefulWidget {
  ProductItemWidget({Key key, this.product, this.cart, this.parent})
      : super(key: key);

  final _SearchPageState parent;
  final Product product;
  final Cart cart;
  @override
  _ProductItemWidgetState createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  Product product;
  Cart cart;
  int mrpPrice = 0;
  int price = 0;
  int totalCartAmount = 0;
  String selectedUnit;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

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

  static Future<dynamic> loadFromStorage(
      BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }

  gettotalCartAmount(ProductNotifier productNotifier, AuthNotifier authNotifier,
      _SearchPageState parent) async {
    totalCartAmount = -1;
    int totalCartAmountTemp = 0;
    setState(() {
      widget.parent.setState(() {
        widget.parent.totalCartAmount = -1;
      });
    });
    //await getProducts(productNotifier, parent.widget.categoryName, "All");
    await getCarts(productNotifier, authNotifier.user.uid);
    for (var cart in productNotifier.cartByUserList) {
      //final product = await getProductById(cart.productId);
      //if (cart.unit == product.unit1) {
      totalCartAmountTemp = totalCartAmountTemp + (cart.price * cart.quantity);
      // } else if (cart.unit == product.unit2) {
      //   totalCartAmountTemp =
      //       totalCartAmountTemp + (product.price2 * cart.quantity);
      // }
    }
    setState(() {
      totalCartAmount = totalCartAmountTemp;
      widget.parent.setState(() {
        widget.parent.totalCartAmount = totalCartAmountTemp;
      });
    });

    return totalCartAmount;
  }

  Future<void> saveCartHandle(Cart cart) async {
    LoaderDialog.showLoadingDialog(
        context, _drawerKey, "Adding product to cart...");
    await saveCart(cart);
    Navigator.of(_drawerKey.currentContext, rootNavigator: true).pop();
  }

  @override
  void initState() {
    product = widget.product;
    cart = widget.cart;
    mrpPrice = product.mrpPrice1;
    price = product.price1;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    final productNotifier = Provider.of<ProductNotifier>(context);
    final authNotifier = Provider.of<AuthNotifier>(context);

    GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
    if (selectedUnit == null) {
      selectedUnit = product.unit1;
    }
    return Stack(
      children: <Widget>[
        InkWell(
          onTap: () {
            //Nav.route(context, ProductDetailPage());
          },
          child: Container(
            width: ScreenUtil.getWidth(context),
            margin: EdgeInsets.only(left: 16, top: 8, right: 12, bottom: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[200],
                        blurRadius: 5.0,
                        spreadRadius: 1,
                        offset: Offset(0.0, 2)),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                            width: 120,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                              child: FutureBuilder(
                                future: _getImage(context, product.image),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.25,
                                      width: MediaQuery.of(context).size.width /
                                          1.25,
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
                              // Image.asset(
                              //   "assets/images/" + product.image,
                              //   fit: BoxFit.cover,
                              // ),
                            )),
                        Container(
                          //color: Colors.white,
                          padding: EdgeInsets.only(left: 150, top: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              AutoSizeText(
                                product.name != null ? product.name : "",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  //color: Color(0xFF5D6A78),
                                  fontWeight: FontWeight.w300,
                                ),
                                maxLines: 2,
                                minFontSize: 11,
                              ),
                              Row(
                                  // children: <Widget>[
                                  //   RatingBar(
                                  //     ignoreGestures: true,
                                  //     initialRating: 3,
                                  //     itemSize: 14.0,
                                  //     minRating: 1,
                                  //     direction: Axis.horizontal,
                                  //     allowHalfRating: true,
                                  //     itemCount: 5,
                                  //     itemBuilder: (context, _) => Icon(
                                  //       Ionicons.ios_star,
                                  //       color: themeColor.getColor(),
                                  //     ),
                                  //     onRatingUpdate: (rating) {
                                  //       print(rating);
                                  //     },
                                  //   ),
                                  //   SizedBox(
                                  //     width: 8,
                                  //   ),
                                  //   Text(
                                  //     "(395)",
                                  //     style: GoogleFonts.poppins(
                                  //         fontSize: 9, fontWeight: FontWeight.w400),
                                  //   )
                                  // ],
                                  ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        mrpPrice != 0
                                            ? mrpPrice.toString()
                                            : product.mrpPrice1.toString(),
                                        style: GoogleFonts.poppins(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Text(
                                        price != 0
                                            ? price.toString()
                                            : product.price1.toString(),
                                        style: GoogleFonts.poppins(
                                            color: themeColor.getColor(),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      FindDropdown(
                                        items: [
                                          product.unit1,
                                          product.unit2,
                                        ],
                                        onChanged: (String item) async {
                                          if (item == product.unit1) {
                                            setState(() {
                                              selectedUnit = item;
                                              price = product.price1;
                                              mrpPrice = product.mrpPrice1;
                                            });
                                          } else if (item == product.unit2) {
                                            setState(() {
                                              selectedUnit = item;
                                              price = product.price2;
                                              mrpPrice = product.mrpPrice2;
                                            });
                                          }
                                        },
                                        selectedItem: product.unit1,
                                        isUnderLine: false,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      // getCartButton(
                                      //     productNotifier, authNotifier, product, isCartAdded),
                                      Container(
                                        padding: EdgeInsets.all(6.0),
                                        // top: 6,
                                        // left: 6,
                                        // bottom: 6,
                                        // right: 6),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey[200],
                                                  blurRadius: 5.0,
                                                  spreadRadius: 1,
                                                  offset: Offset(0.0, 1)),
                                            ]),
                                        child: InkWell(
                                          onTap: () async {
                                            cart = Cart();
                                            cart.uid = authNotifier.user.uid;
                                            cart.quantity = 1;
                                            cart.unit = selectedUnit;
                                            cart.productId = product.id;
                                            cart.image = product.image;
                                            if (selectedUnit == product.unit1) {
                                              cart.price = product.price1;
                                            } else if (selectedUnit ==
                                                product.unit2) {
                                              cart.price = product.price2;
                                            }
                                            await saveCartHandle(cart);
                                            await gettotalCartAmount(
                                                productNotifier,
                                                authNotifier,
                                                widget.parent);

                                            // Navigator.of(
                                            //         _drawerKey.currentContext,
                                            //         rootNavigator: true)
                                            //     .pop();

                                            // Scaffold.of(context).showSnackBar(SnackBar(
                                            //   content: Container(
                                            //       margin: EdgeInsets.fromLTRB(0, 0, 0, 75),
                                            //       child: Text('Product added to cart')),
                                            // ));

                                            //close the dialoge
                                          },
                                          child: Row(children: <Widget>[
                                            Text(
                                              "ADD ",
                                            ),
                                            Container(
                                              child: SvgPicture.asset(
                                                "assets/icons/ic_product_shopping_cart.svg",
                                                height: 20,
                                              ),
                                            )
                                          ]),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 8,
                          child: Container(
                            height: 38,
                            width: 32,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8))),
                            child: Icon(
                              Icons.favorite,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
