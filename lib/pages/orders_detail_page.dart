import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/models/orderItems.dart';
import 'package:shoppingapp/notifier/auth_notifier.dart';
import 'package:shoppingapp/notifier/product_notifier.dart';
import 'package:shoppingapp/utils/commons/colors.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/widgets/orders_detail/order_item.dart';
import 'package:shoppingapp/api/product_api.dart';

class OrdersDetailPage extends StatefulWidget {
  @override
  _OrdersDetailPageState createState() => _OrdersDetailPageState();
}

class _OrdersDetailPageState extends State<OrdersDetailPage> {
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 252, 252, 252),
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));
    getOrderByUser(
        ProductNotifier productNotifier, AuthNotifier authNotifier) async {
      await getOrderByUserId(productNotifier, authNotifier.user.uid);
      for (var order in productNotifier.orderByUserList) {
        await getOrderItemByOrderId(order);
      }
      return true;
    }

    GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    return FutureBuilder<dynamic>(
        future: getOrderByUser(productNotifier, authNotifier),
        // ignore: missing_return
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            // LoaderDialog.showLoadingDialog(context, _keyLoader);
            return Stack(children: <Widget>[
              Text(
                "    Loading your order...",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Color(0xFF5D6A78)),
              )
            ]);
          } else if (snapshot.hasData) {
            return SafeArea(
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize:
                      Size.fromHeight(42.0), // here the desired height
                  child: AppBar(
                    backgroundColor: greyBackground,
                    elevation: 0,
                    centerTitle: true,
                    title: Text(
                      "Order Details.",
                      style: GoogleFonts.poppins(
                          color: Color(0xFF5D6A78), fontSize: 15),
                    ),
                    leading: Icon(
                      Icons.chevron_left,
                      color: textColor,
                      size: 32,
                    ),
                  ),
                ),
                backgroundColor: greyBackground,
                key: _drawerKey, // assign key to Scaffold

                body: Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: ScreenUtil.getWidth(context),
                            margin:
                                EdgeInsets.only(left: 16, right: 16, top: 8),
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
                          ),
                          ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              for (var order in productNotifier.orderByUserList)
                                OrderItemList(
                                    themeColor: themeColor,
                                    imageUrl: "onb1.png",
                                    order: order),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
