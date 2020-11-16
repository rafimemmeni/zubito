import 'package:flutter/material.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/widgets/commons/product_card.dart';
import 'package:shoppingapp/widgets/homepage/product_list_titlebar.dart';
import 'package:shoppingapp/notifier/product_notifier.dart';

class SubCategoryList extends StatelessWidget {
  const SubCategoryList(
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
                    imageUrl: "rice.png",
                    categoryName: "Rice",
                    productNotifier: productNotifier,
                  ),
                  ProductCard(
                      themeColor: themeColor,
                      imageUrl: "cookingoil.png",
                      categoryName: "Cooking Oils"),
                  ProductCard(
                    themeColor: themeColor,
                    imageUrl: "ricepowder.png",
                    categoryName: "Rice Powder",
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
                    imageUrl: "spices.png",
                    categoryName: "Spices",
                    productNotifier: productNotifier,
                  ),
                  ProductCard(
                      themeColor: themeColor,
                      imageUrl: "spicepowder.png",
                      categoryName: "Spice Powder"),
                  ProductCard(
                    themeColor: themeColor,
                    imageUrl: "dryfruits.png",
                    categoryName: "Dry Frtuits",
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
                    imageUrl: "tea.png",
                    categoryName: "Tea",
                    productNotifier: productNotifier,
                  ),
                  ProductCard(
                      themeColor: themeColor,
                      imageUrl: "nutritiondrink.png",
                      categoryName: "Nutrition Drink"),
                  ProductCard(
                    themeColor: themeColor,
                    imageUrl: "pulses.png",
                    categoryName: "Pulses",
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
