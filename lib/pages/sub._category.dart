import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/api/product_api.dart';
import 'package:shoppingapp/notifier/product_notifier.dart';
import 'package:shoppingapp/pages/product_detail.dart';
import 'package:shoppingapp/utils/dummy_data/discountImages.dart';
import 'package:shoppingapp/utils/dummy_data/discountImages_two.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/widgets/homepage/category_list_view.dart';
import 'package:shoppingapp/widgets/homepage/discount_list.dart';
import 'package:shoppingapp/widgets/homepage/home_services.dart';
import 'package:shoppingapp/widgets/homepage/product_list.dart';
import 'package:shoppingapp/widgets/homepage/product_list_titlebar.dart';
import 'package:shoppingapp/widgets/homepage/search_box.dart';
import 'package:shoppingapp/widgets/homepage/slider_dot.dart';

class SubCategoryPage extends StatefulWidget {
  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  int _carouselCurrentPage = 0;
  @override
  void initState() {
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    // getProducts(productNotifier, "Bakery", "Offer");
    super.initState();
  }

  void showDemoActionSheet({BuildContext context, Widget child}) {
    showCupertinoModalPopup<String>(
        context: context,
        builder: (BuildContext context) => child).then((String value) {
      changeLocale(context, value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xFF07128A),
      body: ListView(
        children: <Widget>[
          InkWell(
            onTap: () {
              // Nav.route(context, ProductDetailPage());
            },
          ),
          SliderDot(current: _carouselCurrentPage),
          SizedBox(
            height: 8,
          ),
          ProductList(
            themeColor: themeColor,
            productListTitleBar: ProductListTitleBar(
              themeColor: themeColor,
              title: "Rice & Others",
              isCountShow: false,
            ),
            productNotifier: productNotifier,
          ),
          SizedBox(
            height: 8,
          ),
          SliderDot(current: _carouselCurrentPage),
          SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 36,
          ),
        ],
      ),
    );
  }
}
