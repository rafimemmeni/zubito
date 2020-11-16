import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shoppingapp/pages/orders_detail_page.dart';
import 'package:shoppingapp/pages/product_detail.dart';
import 'package:shoppingapp/pages/search_page.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/notifier/product_notifier.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/utils/navigator.dart';

import '../../config.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    return CategoriesListView(
      title: "YOUR TITLES",
      productNotifier: productNotifier,
      categories: [
        'ic_whatsapp.svg',
        'ic_medical.svg',
        'restaurant.svg',
        'book.svg',
        'taxi.svg'
      ],
      categoryTitle: [
        //'My Orders',
        'Whatsapp Direct Order',
        'Medicine',
        'Restaurant',
        'Books',
        'Taxi',
      ],
    );
  }
}

class CategoriesListView extends StatelessWidget {
  final String title;
  final List<String> categories;
  final List<String> categoryTitle;
  final ProductNotifier productNotifier;

  const CategoriesListView(
      {this.productNotifier,
      Key key,
      @required this.title,
      @required this.categories,
      @required this.categoryTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2, left: 4),
      height: 108,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              //productNotifier.currentCategory = categoryTitle[index];
              //OrdersDetailPage();
              if (categoryTitle[index] == "Whatsapp Order") {
                FlutterOpenWhatsapp.sendSingleMessage(
                    "918129196970", "Hi Zubito");
              } else if (categoryTitle[index].trim() == "Medicine") {
                FlutterOpenWhatsapp.sendSingleMessage(
                    "918129196970", "Hi Zubito, I need to order a medicine.");
              } else {
                Scaffold.of(context).showSnackBar(SnackBar(
                    backgroundColor: mainColor, content: Text('Coming soon')));
                //Nav.route(context, OrdersDetailPage());
                // Navigator.push(
                //   context,
                //   PageTransition(
                //     type: PageTransitionType.fade,
                //     child: OrdersDetailPage(),
                //   ),
                // );
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  width: 55,
                  height: 55,
                  margin:
                      EdgeInsets.only(top: 4, bottom: 1, left: 12, right: 8),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[200],
                          //blurRadius: 5.0,
                          spreadRadius: 1,
                          offset: Offset(0.0, 1)),
                    ],
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Container(
                    width: 50,
                    height: 40,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/" + categories[index],
                      //color: categoryIconColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  width: 75,
                  height: 40,
                  child: Text(
                    categoryTitle[index],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                          color: textColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
