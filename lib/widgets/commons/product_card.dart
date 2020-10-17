import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/pages/product_detail.dart';
import 'package:shoppingapp/pages/shopping_cart_page.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import '../../config.dart';
import 'package:shoppingapp/notifier/product_notifier.dart';
import 'package:shoppingapp/pages/search_page.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {Key key,
      @required this.themeColor,
      this.imageUrl,
      this.categoryName,
      this.productNotifier})
      : super(key: key);

  final ThemeNotifier themeColor;
  final String imageUrl;
  final String categoryName;
  final ProductNotifier productNotifier;

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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Material(
          child: InkWell(
            splashColor: Colors.green,
            hoverColor: Colors.red,
            onTap: () {
              Nav.route(context, SearchPage(categoryName: categoryName));
            },
            child: Container(
              width: (ScreenUtil.getWidth(context) - 6) / 3,
              margin: EdgeInsets.only(left: 1, top: 1, right: 1, bottom: 1),
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
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      height: 90,
                      child: Stack(
                        children: <Widget>[
                          Container(
                              width: 200,
                              height: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                                // child: FutureBuilder(
                                //   future: _getImage(context, imageUrl),
                                //   builder: (context, snapshot) {
                                //     if (snapshot.hasData) {
                                //         return Container(
                                //           height:
                                //               MediaQuery.of(context).size.height /
                                //                   1.25,
                                //           width:
                                //               MediaQuery.of(context).size.width /
                                //                   1.25,
                                //           child: snapshot.data,
                                //         );
                                //     }
                                //     // if (snapshot.connectionState ==
                                //     //     ConnectionState.waiting)
                                //     //   return Container(
                                //     //       height:
                                //     //           MediaQuery.of(context).size.height /
                                //     //               1.25,
                                //     //       width:
                                //     //           MediaQuery.of(context).size.width /
                                //     //               1.25,
                                //     //       child: CircularProgressIndicator());

                                //     return Container();
                                //   },
                                // ),
                                child: Image.asset(
                                  "assets/images/$imageUrl",
                                  fit: BoxFit.cover,
                                ),
                              )),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8))),
                              width: 100,
                              height: 20,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  categoryName,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: themeColor.getColor(),
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Positioned(
                          //   top: 0,
                          //   right: 8,
                          //   child: Container(
                          //     height: 38,
                          //     width: 32,
                          //     decoration: BoxDecoration(
                          //         color: Colors.white.withOpacity(0.4),
                          //         borderRadius: BorderRadius.only(
                          //             bottomLeft: Radius.circular(8),
                          //             bottomRight: Radius.circular(8))),
                          //     child: Icon(
                          //       Icons.favorite,
                          //       color: Colors.white,
                          //       size: 18,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                    // Container(
                    //   color: Colors.white,
                    //   width: 204.0,
                    //   padding: EdgeInsets.only(left: 10, top: 4),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: <Widget>[
                    //       AutoSizeText(
                    //         'Milma Milk 1 Ltr',
                    //         style: GoogleFonts.poppins(
                    //           fontSize: 12,
                    //           color: Color(0xFF5D6A78),
                    //           fontWeight: FontWeight.w300,
                    //         ),
                    //         maxLines: 2,
                    //         minFontSize: 11,
                    //       ),
                    //       SizedBox(
                    //         height: 2,
                    //       ),
                    //       Row(
                    //         children: <Widget>[
                    //           RatingBar(
                    //             ignoreGestures: true,
                    //             initialRating: 3,
                    //             itemSize: 14.0,
                    //             minRating: 1,
                    //             direction: Axis.horizontal,
                    //             allowHalfRating: true,
                    //             itemCount: 5,
                    //             itemBuilder: (context, _) => Icon(
                    //               Ionicons.ios_star,
                    //               color: themeColor.getColor(),
                    //             ),
                    //             onRatingUpdate: (rating) {
                    //               print(rating);
                    //             },
                    //           ),
                    //           SizedBox(
                    //             width: 8,
                    //           ),
                    //           Text(
                    //             "(395)",
                    //             style: GoogleFonts.poppins(
                    //                 fontSize: 9, fontWeight: FontWeight.w400),
                    //           )
                    //         ],
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: <Widget>[
                    //           Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: <Widget>[
                    //               SizedBox(
                    //                 height: 4,
                    //               ),
                    //               Text(
                    //                 "\₹120",
                    //                 style: GoogleFonts.poppins(
                    //                     decoration: TextDecoration.lineThrough,
                    //                     fontSize: 14,
                    //                     fontWeight: FontWeight.w300),
                    //               ),
                    //               Text(
                    //                 "\₹478",
                    //                 style: GoogleFonts.poppins(
                    //                     color: themeColor.getColor(),
                    //                     fontSize: 18,
                    //                     fontWeight: FontWeight.w400),
                    //               )
                    //             ],
                    //           ),
                    //         ],
                    //       )
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ),
        ),
        // Positioned(
        //   bottom: 22,
        //   right: 22,
        //   child: InkWell(
        //     onTap: () {
        //       Scaffold.of(context).showSnackBar(SnackBar(
        //           backgroundColor: mainColor,
        //           content: Text('Product added to cart')));
        //       Nav.route(context, ShoppingCartPage());
        //     },
        //     child: Container(
        //       padding: EdgeInsets.only(top: 8, left: 8, bottom: 8, right: 8),
        //       decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(8),
        //           color: Colors.white,
        //           boxShadow: [
        //             BoxShadow(
        //                 color: Colors.grey[200],
        //                 blurRadius: 5.0,
        //                 spreadRadius: 1,
        //                 offset: Offset(0.0, 1)),
        //           ]),
        //       child: Row(
        //         children: <Widget>[
        //           SvgPicture.asset(
        //             "assets/icons/ic_product_shopping_cart.svg",
        //             height: 12,
        //           ),
        //           SizedBox(
        //             width: 8,
        //           ),
        //           Text(
        //             "Add to Cart",
        //             style: GoogleFonts.poppins(
        //                 color: Color(0xFF5D6A78),
        //                 fontSize: 10,
        //                 fontWeight: FontWeight.w400),
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
