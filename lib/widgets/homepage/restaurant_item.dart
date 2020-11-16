import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/types/gf_button_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:shoppingapp/pages/product_detail.dart';
import 'package:shoppingapp/pages/search_page.dart';
import 'package:shoppingapp/pages/shopping_cart_page.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';

import '../../config.dart';

class RestaurantItem extends StatelessWidget {
  final themeColor;
  final String imageUrl;
  final String price;
  final String name;
  final mrpPrice;

  RestaurantItem(
      {Key key,
      this.themeColor,
      this.imageUrl,
      this.price,
      this.name,
      this.mrpPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //Nav.route(context, ProductDetailPage());
      },
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 8, left: 8, bottom: 8),
            decoration: BoxDecoration(
                //borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[200],
                      //blurRadius: 5.0,
                      spreadRadius: 1,
                      offset: Offset(0.0, 1)),
                ]),
            width: ScreenUtil.getWidth(context) / 3.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 2, bottom: 2, left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // Container(
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(2),
                      //     child: AutoSizeText(
                      //       name.toString(),
                      //       style: GoogleFonts.poppins(
                      //         fontSize: 12,
                      //         color: Color(0xFF5D6A78),
                      //         fontWeight: FontWeight.w300,
                      //       ),
                      //       maxLines: 1,
                      //       minFontSize: 11,
                      //     ),
                      //   ),
                      //   width: ScreenUtil.getWidth(context) * 0.30,
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(8),
                      //   ),
                      //   height: 40,
                      //   padding: EdgeInsets.all(10),
                      // ),
                      Container(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              "assets/images/$imageUrl",
                              fit: BoxFit.cover,
                            )),
                        width: ScreenUtil.getWidth(context) * 0.2,
                        // decoration: BoxDecoration(
                        //   color: Colors.white,
                        //   borderRadius: BorderRadius.circular(8),
                        // ),
                        height: 100,
                        padding: EdgeInsets.all(1),
                      ),
                      Container(
                        child: GFButton(
                          onPressed: () {
                            Nav.route(context, SearchPage(categoryName: name));
                            // Scaffold.of(context).showSnackBar(SnackBar(
                            //     backgroundColor: mainColor,
                            //     content: Text('Coming soon')));
                            //Nav.route(context, ShoppingCartPage());
                          },
                          child: Text(
                            "Order Now",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                          type: GFButtonType.transparent,
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xFFf77605),
                            borderRadius: BorderRadius.circular(3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.2),
                                blurRadius: 6.0, // soften the shadow
                                spreadRadius: 0.0, //extend the shadow
                                offset: Offset(
                                  5.0, // Move to right 10  horizontally
                                  1.0, // Move to bottom 10 Vertically
                                ),
                              )
                            ]),
                        height: 32,
                        padding: EdgeInsets.all(4),
                      ),
                      // Container(
                      //   child: GFButton(
                      //     onPressed: () {
                      //       Nav.route(context, SearchPage(categoryName: name));
                      //       // Scaffold.of(context).showSnackBar(SnackBar(
                      //       //     backgroundColor: mainColor,
                      //       //     content: Text('Coming soon')));
                      //       //Nav.route(context, ShoppingCartPage());
                      //     },
                      //     child: Text(
                      //       "Order Now",
                      //       style: GoogleFonts.poppins(
                      //           color: Color(0xFF5D6A78),
                      //           fontSize: 10,
                      //           fontWeight: FontWeight.w400),
                      //     ),
                      //     type: GFButtonType.transparent,
                      //   ),
                      //   decoration: BoxDecoration(
                      //       color: Color(0xFFf77605),
                      //       borderRadius: BorderRadius.circular(3),
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: Colors.grey.withOpacity(.2),
                      //           blurRadius: 6.0, // soften the shadow
                      //           spreadRadius: 0.0, //extend the shadow
                      //           offset: Offset(
                      //             0.0, // Move to right 10  horizontally
                      //             1.0, // Move to bottom 10 Vertically
                      //           ),
                      //         )
                      //       ]),
                      //   height: 32,
                      //   padding: EdgeInsets.all(4),
                      // ),

                      // Text(
                      //   "Free Delivery",
                      //   style: GoogleFonts.poppins(
                      //       color: themeColor.getColor(),
                      //       fontSize: 10,
                      //       fontWeight: FontWeight.w300),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
