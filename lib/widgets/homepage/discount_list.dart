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
              height: 170.0,
              child: new ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  //:Load discount list

                  // for (var product in productNotifier.offerProductList)
                  RestaurantItem(
                      themeColor: themeColor,
                      imageUrl: "mra.png",
                      name: "",
                      price: 'MRA Bakery',
                      mrpPrice: ''),
                  RestaurantItem(
                      themeColor: themeColor,
                      imageUrl: "chicking.png",
                      name: "",
                      price: 'Chicking',
                      mrpPrice: '')

                  //});

                  // DiscountItem(
                  //themeColor: themeColor, imageUrl: "prodcut1.png")
                  // DiscountItem(
                  //     themeColor: themeColor, imageUrl: "prodcut2.png"),
                  // DiscountItem(
                  //     themeColor: themeColor, imageUrl: "prodcut3.png"),
                ],
              )
              // child: ListView.separated(
              //   itemBuilder: (BuildContext context, int index) {
              //     return ListTile(
              //       leading: Image.network(
              //         productNotifier.productList[index].image != null
              //             ? productNotifier.productList[index].image
              //             : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
              //         width: 120,
              //         fit: BoxFit.fitWidth,
              //       ),
              //       title: Text(productNotifier.productList[index].name),
              //       subtitle: Text(productNotifier.productList[index].category),
              //       onTap: () {
              //         productNotifier.currentFood =
              //             productNotifier.productList[index];
              //         Navigator.of(context).push(
              //             MaterialPageRoute(builder: (BuildContext context) {
              //           //return FoodDetail();
              //         }));
              //       },
              //     );
              //   },
              //   itemCount: productNotifier.productList.length,
              //   separatorBuilder: (BuildContext context, int index) {
              //     return Divider(
              //       color: Colors.black,
              //     );
              //   },
              // ),

              //  child: new ListView(
              //   scrollDirection: Axis.horizontal,
              //   children: <Widget>[
              //     DiscountItem(
              //         themeColor: themeColor, imageUrl: "prodcut1.png"),
              //     DiscountItem(
              //         themeColor: themeColor, imageUrl: "prodcut2.png"),
              //     DiscountItem(
              //         themeColor: themeColor, imageUrl: "prodcut3.png"),
              //   ],
              // )
              ),
        ],
      ),
    );
  }
}
