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
              color: Color(0xFF07128A),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ProductCard(
                    themeColor: themeColor,
                    imageUrl: "fruits.png",
                    categoryName: "Fruits",
                    productNotifier: productNotifier,
                  ),
                  ProductCard(
                      themeColor: themeColor,
                      imageUrl: "veg.png",
                      categoryName: "Vegitables"),
                  ProductCard(
                    themeColor: themeColor,
                    imageUrl: "meatFish.png",
                    categoryName: "Chicken & Egg",
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
                    imageUrl: "foodgrains.png",
                    categoryName: "Rice & others",
                    productNotifier: productNotifier,
                  ),
                  ProductCard(
                      themeColor: themeColor,
                      imageUrl: "beverages.png",
                      categoryName: "Beverages"),
                  ProductCard(
                    themeColor: themeColor,
                    imageUrl: "caketools.png",
                    categoryName: "Cake tools",
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
                    imageUrl: "babykids.png",
                    categoryName: "Baby & kids",
                    productNotifier: productNotifier,
                  ),
                  ProductCard(
                      themeColor: themeColor,
                      imageUrl: "beauty.png",
                      categoryName: "Personal Care"),
                  ProductCard(
                    themeColor: themeColor,
                    imageUrl: "cleaning.png",
                    categoryName: "Cleaning",
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
