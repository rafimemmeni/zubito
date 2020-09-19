import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/getflutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/main.dart';
import 'package:shoppingapp/pages/credit_cart_page.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';

import 'new_adress_page.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Color(0xFFFCFCFC),
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFCFCFC),
        body: Container(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Addresses",
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: Color(0xFF5D6A78)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      buildAddressItem(context, themeColor),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Select a payment method",
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: Color(0xFF5D6A78)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            buildPayMethodItem(
                                context, "Pay at the door", themeColor),
                            buildPayMethodItem(context, "Paypal", themeColor),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 16, bottom: 8),
                  child: Text(
                    "Order Note",
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: Color(0xFF5D6A78)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8, right: 8, left: 8),
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: themeColor.getColor()),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: textColor),
                                    ),
                                    labelStyle: new TextStyle(
                                        color: const Color(0xFF424242)),
                                    hintText: "Enter the order Notes",
                                    hintStyle: GoogleFonts.poppins(
                                        fontSize: 12, color: textColor)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: GFButton(
                    borderShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        6,
                      ),
                    ),
                    child: Text("Payment Details"),
                    color: themeColor.getColor(),
                    onPressed: () {
                      Nav.route(context, CreditCartPage());
                    },
                    type: GFButtonType.solid,
                    fullWidthButton: true,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildPayMethodItem(BuildContext context, String title, themeColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Radio(
              value: true,
              groupValue: true,
              activeColor: themeColor.getColor(),
              focusColor: themeColor.getColor(),
              hoverColor: themeColor.getColor(),
              onChanged: (bool value) {},
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF5D6A78)),
            ),
          ],
        ),
      ],
    );
  }

  buildAddressItem(BuildContext context, themeColor) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildItemRadio(context, themeColor),
          buildItemRadio(context, themeColor),
          Padding(
            padding: const EdgeInsets.only(left: 14.0, bottom: 10, top: 24),
            child: Container(
              height: ScreenUtil.getHeight(context) * 0.05,
              width: ScreenUtil.getWidth(context) * 0.30,
              child: GFButton(
                focusColor: themeColor.getColor().withOpacity(0.5),
                disabledColor: themeColor.getColor().withOpacity(0.5),
                disabledTextColor: themeColor.getColor().withOpacity(0.5),
                highlightColor: themeColor.getColor().withOpacity(0.5),
                hoverColor: themeColor.getColor().withOpacity(0.5),
                splashColor: themeColor.getColor().withOpacity(0.5),
                color: themeColor.getColor(),
                type: GFButtonType.outline,
                onPressed: () {
                  Nav.route(context, NewAddressPage());
                },
                child: Text("Add address"),
              ),
            ),
          )
        ],
      ),
    );
  }

  buildItemRadio(BuildContext context, themeColor) {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12, top: 24),
      width: ScreenUtil.getWidth(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Radio(
                value: true,
                groupValue: true,
                activeColor: themeColor.getColor(),
                focusColor: themeColor.getColor(),
                hoverColor: themeColor.getColor(),
                onChanged: (bool value) {},
              ),
              Expanded(
                  child: Text(
                "The lama respects truth which is not inward.truth which is not inwar",
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF5D6A78)),
              )),
            ],
          ),
        ],
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
}
