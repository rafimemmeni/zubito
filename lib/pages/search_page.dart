import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/api/product_api.dart';
import 'package:shoppingapp/models/product.dart';
import 'package:shoppingapp/models/cart.dart';
import 'package:shoppingapp/pages/filter_page.dart';
import 'package:shoppingapp/pages/product_detail.dart';
import 'package:shoppingapp/pages/shopping_cart_page.dart';
import 'package:shoppingapp/utils/commons/loaderdialog.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/notifier/product_notifier.dart';
import 'package:shoppingapp/notifier/auth_notifier.dart';

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
  String deneme = "Dursun";
  Cart cart;
  @override
  void initState() {
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);

    getProducts(productNotifier, widget.categoryName, "All");
    super.initState();
  }

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

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

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
        backgroundColor: Color.fromARGB(255, 252, 252, 252),
        key: _drawerKey, // assign key to Scaffold
        body: Builder(
          // Create an inner BuildContext so that the onPressed methods
          // can refer to the Scaffold with Scaffold.of().
          builder: (BuildContext context) {
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
                                margin: EdgeInsets.only(right: 8, bottom: 8),
                                padding: EdgeInsets.only(left: 12, right: 12),
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
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        children: <Widget>[
                          for (var product
                              in productNotifier.productByCategoryList)
                            productSearchItem(
                                context, themeColor, product, _drawerKey)
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
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

  Stack productSearchItem(BuildContext context, ThemeNotifier themeColor,
      Product product, GlobalKey<ScaffoldState> _drawerKey) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);

    return Stack(
      children: <Widget>[
        InkWell(
          onTap: () {
            //Nav.route(context, ProductDetailPage());
          },
          child: Container(
            width: ScreenUtil.getWidth(context) / 2,
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
                            width: 300,
                            height: 120,
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
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 10, top: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AutoSizeText(
                          product.name,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Color(0xFF5D6A78),
                            fontWeight: FontWeight.w300,
                          ),
                          maxLines: 2,
                          minFontSize: 11,
                        ),
                        SizedBox(
                          height: 2,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  product.mrpPrice.toString(),
                                  style: GoogleFonts.poppins(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  product.price.toString(),
                                  style: GoogleFonts.poppins(
                                      color: themeColor.getColor(),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 22,
          right: 22,
          child: InkWell(
            onTap: () {
              // Scaffold.of(context).showSnackBar(SnackBar(
              //     backgroundColor: themeColor.getColor(),
              //     content: Text('Product added to cart')));
              //Nav.route(context, ShoppingCartPage());
            },
            child: Container(
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
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Product added to cart'),
                  ));
                  //close the dialoge
                },
                child: Row(children: <Widget>[
                  Text(
                    "Add to Cart ",
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
          ),
        )
      ],
    );
  }
}
