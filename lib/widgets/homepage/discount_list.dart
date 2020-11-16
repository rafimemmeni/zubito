import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/api/product_api.dart';
import 'package:shoppingapp/notifier/auth_notifier.dart';
import 'package:shoppingapp/notifier/product_notifier.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/widgets/homepage/discount_item.dart';
import 'package:shoppingapp/widgets/homepage/restaurant_item.dart';
import 'package:shoppingapp/widgets/homepage/product_list_titlebar.dart';

class DiscountList extends StatelessWidget {
  const DiscountList({
    Key key,
    @required this.themeColor,
    this.productListTitleBar,
  }) : super(key: key);

  final ThemeNotifier themeColor;
  final ProductListTitleBar productListTitleBar;

  @override
  Widget build(BuildContext context) {
    //AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);

    Future<void> _refreshList() async {
      getProducts(productNotifier, "All", "section");
    }

    return Container(
      margin: EdgeInsets.only(right: 16, top: 16, bottom: 8),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          productListTitleBar,
          Container(
              height: 160.0,
              //width: 10.0,
              child: new ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  //:Load discount list
                  // for (var product in productNotifier.offerProductList)
                  RestaurantItem(
                      themeColor: themeColor,
                      imageUrl: "mra.png",
                      name: "MRA Bakery",
                      price: '',
                      mrpPrice: ''),

                  RestaurantItem(
                      themeColor: themeColor,
                      imageUrl: "mra.png",
                      name: "MRA Bakery",
                      price: '',
                      mrpPrice: ''),
                  RestaurantItem(
                      themeColor: themeColor,
                      imageUrl: "mra.png",
                      name: "MRA Bakery",
                      price: '',
                      mrpPrice: ''),
                  RestaurantItem(
                      themeColor: themeColor,
                      imageUrl: "mra.png",
                      name: "MRA Bakery",
                      price: '',
                      mrpPrice: ''),
                ],
              )),
        ],
      ),
    );
  }
}
