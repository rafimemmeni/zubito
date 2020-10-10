import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/localization_delegate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingapp/api/product_api.dart';
import 'package:shoppingapp/pages/category_page.dart';
import 'package:shoppingapp/pages/edit_user_info_page.dart';
import 'package:shoppingapp/pages/favorite_products_page.dart';
import 'package:shoppingapp/pages/home_navigator.dart';
import 'package:shoppingapp/pages/location_page.dart';
import 'package:shoppingapp/pages/login_google.dart';
import 'package:shoppingapp/pages/my_profile_page.dart';
import 'package:shoppingapp/pages/orders_detail_page.dart';
import 'package:shoppingapp/pages/orders_detail_page_customer.dart';
import 'package:shoppingapp/pages/shopping_cart_page.dart';
import 'package:shoppingapp/pages/splash_screen.dart';
import 'package:shoppingapp/utils/drawer_menu/hidden_drawer/hidden_drawer_menu.dart';
import 'package:shoppingapp/utils/drawer_menu/hidden_drawer/screen_hidden_drawer.dart';
import 'package:shoppingapp/utils/drawer_menu/menu/item_hidden_menu.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';

import 'config.dart';
import 'notifier/auth_notifier.dart';
import 'notifier/product_notifier.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en_US', supportedLocales: ['en_US', 'es', 'fa', 'ar']);

  SharedPreferences.getInstance().then((prefs) {
    Color color = mainColor;
    if (prefs.getInt('color') != null) {
      color = Color(prefs.getInt('color'));
    }

    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(color),
        child: Phoenix(
          child: LocalizedApp(
            delegate,
            MyApp(),
          ),
        ),
      ),
    );
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeNotifier(color),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductNotifier(),
        ),
      ],
      child: Phoenix(
        child: LocalizedApp(
          delegate,
          MyApp(),
        ),
      ),
    ));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping App',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          localizationDelegate
        ],
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,
        theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          }),
          primaryColor: themeColor.getColor(),
        ),
        home: SplashScreen(),
      ),
    );
  }
}

class InitPage extends StatefulWidget {
  final String location;
  InitPage({Key key, this.location}) : super(key: key);

  @override
  _InitPageState createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  List<ScreenHiddenDrawer> items = new List();

  @override
  void initState() {
    var icon2 = Icon(
      Feather.home,
      size: 19,
      color: Colors.white,
    );
    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          icon: icon2,
          name: "Home Page",
          baseStyle: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.6), fontSize: 19.0),
          colorLineSelected: Colors.transparent,
        ),
        HomeNavigator()));

    // items.add(new ScreenHiddenDrawer(
    //     new ItemHiddenMenu(
    //       icon: Icon(
    //         Feather.search,
    //         color: Colors.white,
    //         size: 19,
    //       ),
    //       name: 'Categories',
    //       baseStyle: GoogleFonts.poppins(
    //           color: Colors.white.withOpacity(0.6), fontSize: 19.0),
    //       colorLineSelected: Colors.orange,
    //     ),
    //     CategoryPage()));
    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          icon: Icon(
            Feather.shopping_bag,
            size: 19,
            color: Colors.white,
          ),
          name: 'Shopping Cart',
          baseStyle: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.6), fontSize: 19.0),
          colorLineSelected: Colors.orange,
        ),
        ShoppingCartPage()));
    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          icon: Icon(
            Feather.truck,
            size: 19,
            color: Colors.white,
          ),
          name: 'My Orders',
          baseStyle: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.6), fontSize: 19.0),
          colorLineSelected: Colors.orange,
        ),
        OrdersDetailPage()));
    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          icon: Icon(
            Feather.truck,
            size: 19,
            color: Colors.white,
          ),
          name: 'Manage Order',
          baseStyle: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.6), fontSize: 19.0),
          colorLineSelected: Colors.orange,
        ),
        CustomerOrdersDetailPage()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          icon: Icon(
            Feather.user,
            size: 19,
            color: Colors.white,
          ),
          name: 'My Profile',
          baseStyle: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.6), fontSize: 19.0),
          colorLineSelected: Colors.orange,
        ),
        EditUserInfoPage(userSaveButtonCaption: "Save")));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    if (widget.location != null) {
      productNotifier.currentLocationInfo = widget.location;
    }

    // SharedPreferences.getInstance().then((prefs) {
    //   if (prefs.getInt('location') != null) {
    //   }
    // });
    initializeCurrentUser(authNotifier);
    return HiddenDrawerMenu(
      iconMenuAppBar: Padding(
        padding: EdgeInsets.only(bottom: 6),
        child: SvgPicture.asset(
          "assets/icons/ic_menu.svg",
          height: 20,
          color: themeColor.getColor(),
        ),
      ),
      isTitleCentered: true,
      elevationAppBar: 0.0,
      backgroundColorAppBar: Color.fromARGB(255, 252, 252, 252),
      tittleAppBar: Padding(
        child: Image.asset(
          "assets/icons/titlebar_icon.png",
          height: 20,
          //color: themeColor.getColor(),
        ),
        // child: IconButton(
        //   icon: Icon(
        //     Icons.location_on,
        //     color: themeColor.getColor(),
        //     size: 20,
        //   ),
        // child: Text(
        //   "Zubito",
        //   style: GoogleFonts.poppins(
        //     fontSize: 26,
        //     color: themeColor.getColor(),
        //     fontWeight: FontWeight.w600,
        //   ),
        //),
        padding: EdgeInsets.all(1.0),
      ),
      actionsAppBar: <Widget>[
        Padding(
          child: InkWell(
            onTap: () {
              Nav.route(context, LocationPage());
            },
            child: Text(
              productNotifier.currentLocationInfo != null
                  ? productNotifier.currentLocationInfo
                  : " ",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          padding: EdgeInsets.all(8.0),
        ),
        // Padding(
        //   //width: 32,
        //   padding: EdgeInsets.all(1),
        //   child: IconButton(
        //     icon: Icon(
        //       Icons.location_on,
        //       color: themeColor.getColor(),
        //       size: 20,
        //     ),
        //     onPressed: () {
        //       Nav.route(context, LocationPage());
        //     },
        //   ),
        // ),
      ],
      backgroundColorMenu: Colors.blueGrey,
      screens: items,
      enableScaleAnimin: true,
      slidePercent: 70.0,
      verticalScalePercent: 90.0,
      contentCornerRadius: 16.0,
    );
  }
}
