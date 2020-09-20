import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/models/order.dart';
import 'package:shoppingapp/models/orderItems.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';

class OrderItemList extends StatelessWidget {
  final String imageUrl;
  final Order order;

  OrderItemList({Key key, this.imageUrl, ThemeNotifier themeColor, this.order})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

    return Container(
      margin: EdgeInsets.only(top: 8, left: 16, bottom: 8, right: 16),
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
      width: ScreenUtil.getWidth(context) / 1.25,
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          "assets/images/$imageUrl",
                          fit: BoxFit.cover,
                        )),
                    width: 110,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    height: 160,
                    padding: EdgeInsets.all(10),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // AutoSizeText(
                      //   'Alter amicitias ducunt ad',
                      //   style: GoogleFonts.poppins(
                      //     fontSize: 13,
                      //     color: Color(0xFF5D6A78),
                      //     fontWeight: FontWeight.w300,
                      //   ),
                      //   maxLines: 2,
                      //   minFontSize: 11,
                      // ),
                      // SizedBox(
                      //   height: 2,
                      // ),
                      AutoSizeText(
                        'Order Code : ',
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
                      AutoSizeText(
                        order.id,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Color(0xFF5D6A78),
                          fontWeight: FontWeight.w300,
                        ),
                        maxLines: 2,
                        minFontSize: 11,
                      ),
                      AutoSizeText(
                        'Delivery Address : ',
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
                      Container(
                        width: 150,
                        child: Text(
                          order.address,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                        ),
                      ),
                      AutoSizeText(
                        'Location : ',
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
                      Container(
                        width: 150,
                        child: Text(
                          order.location,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            order.totalPrice.toString(),
                            style: GoogleFonts.poppins(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(3),
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
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Order Placed",
                                    style: GoogleFonts.poppins(
                                        color: Color(0xFF5D6A78),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Icon(
                                    FontAwesome5.dot_circle,
                                    size: 12,
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 36,
                            ),
                            InkWell(
                              onTap: () {
                                //openAlertBox(context, themeColor);
                              },
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(3),
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
                                // child: RatingBar(
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
                                //       color: Colors.red,
                                //       width: 9,
                                //     ),
                                //   ),
                                //   onRatingUpdate: (rating) {
                                //     print(rating);
                                //   },
                                // ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              //Divider(),
              Container(
                width: ScreenUtil.getWidth(context),
                margin: EdgeInsets.only(left: 16, right: 16, top: 8),
                padding: EdgeInsets.only(left: 8, right: 8),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[200],
                        blurRadius: 8.0,
                        spreadRadius: 1,
                        offset: Offset(0.0, 3))
                  ],
                  color: Theme.of(context).bottomAppBarColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ExpandablePanel(
                  header: Text(
                    "Order Details",
                    style: GoogleFonts.poppins(
                        color: Color(0xFF5D6A78), fontSize: 12),
                  ),
                  expanded: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                for (var orderItem in order.orderItems)
                                  Container(
                                    //width: ScreenUtil.getWidth(context) / 4,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width:
                                              ScreenUtil.getWidth(context) / 4,
                                          child: Text(
                                            orderItem.name,
                                            softWrap: true,
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                              color: Color(0xFF5D6A78),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width:
                                              ScreenUtil.getWidth(context) / 4,
                                          child: Text(
                                            orderItem.quantity.toString() +
                                                " X " +
                                                orderItem.price.toString(),
                                            softWrap: true,
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                              color: Color(0xFF5D6A78),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          (orderItem.quantity * orderItem.price)
                                              .toString(),
                                          softWrap: true,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: Color(0xFF5D6A78),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            )
                            // Text(
                            //   "1",
                            //   softWrap: true,
                            //   style: GoogleFonts.poppins(
                            //     fontSize: 12,
                            //     fontWeight: FontWeight.w300,
                            //     color: Color(0xFF5D6A78),
                            //   ),
                            // ),
                            // Text(
                            //   "\$450",
                            //   softWrap: true,
                            //   style: GoogleFonts.poppins(
                            //     fontSize: 12,
                            //     fontWeight: FontWeight.w300,
                            //     color: Color(0xFF5D6A78),
                            //   ),
                            // )
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Positioned(
          //     top: 0,
          //     right: 0,
          //     child: IconButton(
          //       icon: Icon(
          //         Feather.trash,
          //         size: 18,
          //         color: Color(0xFF5D6A78),
          //       ),
          //       onPressed: () {},
          //     ))
        ],
      ),
    );
  }
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
                Text("Rate",
                    style: GoogleFonts.poppins(color: Color(0xFF5D6A78))),
                SizedBox(
                  height: 16,
                ),
                RatingBar(
                  initialRating: 3,
                  itemSize: 22.0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => Container(
                    height: 12,
                    child: SvgPicture.asset(
                      "assets/icons/ic_star.svg",
                      color: Colors.red,
                      width: 9,
                    ),
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                Text("You gave 4 points",
                    style: GoogleFonts.poppins(
                        fontSize: 13, color: Color(0xFF5D6A78))),
                SizedBox(
                  height: 32,
                ),
                Container(
                  width: 260,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: themeColor.getColor(),
                    child: Text(
                      "Rate",
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
