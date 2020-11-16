import 'package:badges/badges.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/api/product_api.dart';
import 'package:shoppingapp/notifier/auth_notifier.dart';
import 'package:shoppingapp/notifier/product_notifier.dart';
import 'package:shoppingapp/pages/category_page.dart';
import 'package:shoppingapp/pages/edit_user_info_page.dart';
import 'package:shoppingapp/pages/favorite_products_page.dart';
import 'package:shoppingapp/pages/home_page.dart';
import 'package:shoppingapp/pages/my_profile_page.dart';
import 'package:shoppingapp/pages/orders_detail_page.dart';
import 'package:shoppingapp/pages/shopping_cart_page.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';

class HomeNavigator extends StatefulWidget {
  @override
  _HomeNavigatorState createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
  @override
  void initState() {
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    getCartsByUserCount(productNotifier, authNotifier.user.uid);
    super.initState();
  }

  int _currentPage = 0;

  List<Widget> _pages = [
    HomePage(),
    HomePage(),
    ShoppingCartPage(),
    OrdersDetailPage(),
    EditUserInfoPage(userSaveButtonCaption: "Save")
  ];

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    final productNotifier = Provider.of<ProductNotifier>(context);

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 12),
        child: ConvexAppBar(
          color: Color(0xFF5D6A78),
          backgroundColor: Color(0xFF07128A),
          activeColor: themeColor.getColor(),
          elevation: 0.0,
          top: -28,
          onTap: (int val) {
            if (val == _currentPage) return;
            setState(() {
              _currentPage = val;
              productNotifier.currentPageIndex = val;
            });
          },
          curveSize: 0,
          initialActiveIndex: _currentPage,
          style: TabStyle.fixedCircle,
          items: <TabItem>[
            TabItem(icon: Feather.home, title: ''),
            TabItem(icon: Feather.search, title: ''),
            TabItem(
                icon: bottomCenterItem(themeColor, productNotifier), title: ''),
            TabItem(icon: Feather.truck, title: ''),
            TabItem(icon: Feather.user, title: ''),
          ],
        ),
      ),
      body: _pages[_currentPage],
    );
  }

  bottomCenterItem(ThemeNotifier themeColor, ProductNotifier productNotifier) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                // boxShadow: [
                //   BoxShadow(
                //       color: Colors.grey[200],
                //       //blurRadius: 5.0,
                //       spreadRadius: 1,
                //       offset: Offset(0.0, 1)),
                // ],
                color: Color(0xFFf77605),
                borderRadius: BorderRadius.circular(18)),
            child: Align(
              child: Badge(
                badgeColor: themeColor.getColor(),
                padding: EdgeInsets.all(4),
                badgeContent: Text(
                  productNotifier.totalCart != null
                      ? productNotifier.totalCart.toString()
                      : "0",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                child: SvgPicture.asset(
                    "assets/icons/ic_shopping_cart_bottom.svg",
                    color: Colors.white,
                    ),
              ),
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}
