import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingapp/api/product_api.dart';
import 'package:shoppingapp/notifier/auth_notifier.dart';
import 'package:shoppingapp/pages/choose_location_page.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/providers/location_provider.dart';
import 'package:shoppingapp/utils/navigator.dart';

import '../main.dart';
import 'location_page.dart';

class ScreensController extends StatefulWidget {
  @override
  _ScreensControllerState createState() => _ScreensControllerState();
}

class _ScreensControllerState extends State<ScreensController> {
  void initState() {
    //AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    //initializeCurrentUser(authNotifier);
    super.initState();
  }

  Widget SwitchScreen() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    if (authNotifier.user == null) {
      //Login as anonymous user
      loginAnon(authNotifier);
      return Nav.routeReplacement(context, LocationPage());
    } else {
      if (authNotifier.user != null) {
        //String location = Color(prefs.getInt('location'));
        //return Nav.routeReplacement(context, InitPage());
      } else {
        //return Nav.routeReplacement(context, LocationPage());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(home: SwitchScreen());
  }
}
