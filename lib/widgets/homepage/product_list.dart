import 'package:flutter/material.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/widgets/commons/product_card.dart';
import 'package:shoppingapp/widgets/homepage/product_list_titlebar.dart';
import 'package:shoppingapp/notifier/product_notifier.dart';

class ProductList extends StatelessWidget {
  const ProductList(
      {Key key,
      @required this.themeColor,
      this.productListTitleBar,
      this.productNotifier})
      : super(key: key);

  final ThemeNotifier themeColor;
  final ProductListTitleBar productListTitleBar;
  final ProductNotifier productNotifier;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          productListTitleBar,
          Container(
              height: 100.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ProductCard(
                    themeColor: themeColor,
                    imageUrl: "Foodgrains.png",
                    categoryName: "Foodgains",
                    productNotifier: productNotifier,
                  ),
                  ProductCard(
                      themeColor: themeColor,
                      imageUrl: "bakery.png",
                      categoryName: "Bakery"),
                  ProductCard(
                    themeColor: themeColor,
                    imageUrl: "bakery.png",
                    categoryName: "Meat & Fish",
                  ),
                ],
              )),
          Container(
              height: 100.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ProductCard(
                    themeColor: themeColor,
                    imageUrl: "kitchen.png",
                    categoryName: "Kitchen",
                  ),
                  ProductCard(
                      themeColor: themeColor,
                      imageUrl: "fruits.jpg",
                      categoryName: "Fruits"),
                  ProductCard(
                    themeColor: themeColor,
                    imageUrl: "beauty.png",
                    categoryName: "Beauty",
                  ),
                ],
              )),
          Container(
              height: 100.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ProductCard(
                    themeColor: themeColor,
                    imageUrl: "beverages.png",
                    categoryName: "Beverages",
                  ),
                  ProductCard(
                      themeColor: themeColor,
                      imageUrl: "bakery.png",
                      categoryName: "Snacks"),
                  ProductCard(
                    themeColor: themeColor,
                    imageUrl: "health.png",
                    categoryName: "Health",
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
