import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingapp/api/product_api.dart';
import 'package:shoppingapp/notifier/auth_notifier.dart';
import 'package:shoppingapp/notifier/product_notifier.dart';
import 'package:shoppingapp/pages/choose_location_page.dart';
import 'package:shoppingapp/pages/screen_controller.dart';
import 'package:shoppingapp/utils/screen.dart';

import '../config.dart';
import '../main.dart';
import 'location_page.dart';
import 'login_page.dart';
import 'onboarding_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    //AuthNotifier authNotifier =
    //Provider.of<AuthNotifier>(context, listen: false);
    //initializeCurrentUser(authNotifier);

    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) {
                if (prefs.getString('location') == null) {
                  return LocationPage();
                } else {
                  return InitPage(location: prefs.getString('location'));
                }
              })));
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: mainColor,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );
    return Scaffold(
      backgroundColor: whiteSplashColor,
      body: Center(
        child: Container(
          height: ScreenUtil.getHeight(context),
          width: ScreenUtil.getWidth(context),
          child: Image.asset('assets/images/start_up.png'),
        ),
      ),
    );
  }
}
