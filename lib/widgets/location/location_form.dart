import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingapp/api/product_api.dart';
import 'package:shoppingapp/main.dart';
import 'package:shoppingapp/notifier/auth_notifier.dart';
import 'package:shoppingapp/notifier/product_notifier.dart';
import 'package:shoppingapp/utils/drop_down_menu/find_dropdown.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/widgets/commons/custom_dropdown.dart';
import 'package:shoppingapp/widgets/commons/shadow_button.dart';
import 'package:shoppingapp/widgets/login/login_form_model.dart';
import 'package:validators/validators.dart' as validator;

import '../commons/custom_textfield.dart';

class LocationForm extends StatefulWidget {
  @override
  _LocationFormState createState() => _LocationFormState();
}

class _LocationFormState extends State<LocationForm> {
  final _formKey = GlobalKey<FormState>();
  Model model = Model();
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);

    return Container(
      padding: EdgeInsets.only(top: 24, right: 42, left: 42),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            FindDropdown(
              items: ["Nadapuram", "Vadakara"],
              onChanged: (String value) async {
                model.location = value;
                var prefs = await SharedPreferences.getInstance();
                prefs.setString('location', value);
                productNotifier.currentLocationInfo =
                    prefs.getString('location');
              },
              selectedItem: "Nadapuram",
              isUnderLine: false,
              backgroundColor: Color(0xFFEEEEF3),
              labelStyle: GoogleFonts.poppins(
                  fontSize: 50,
                  color: true ? Colors.black54 : Color(0xFF5D6A78),
                  fontWeight: true ? FontWeight.w800 : FontWeight.w800),
            ),
            Container(
              height: 42,
              width: ScreenUtil.getWidth(context),
              margin: EdgeInsets.only(top: 32, bottom: 12),
              child: ShadowButton(
                borderRadius: 12,
                height: 40,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(8.0),
                  ),
                  color: themeColor.getColor(),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      await initializeCurrentUser(authNotifier);
                      Nav.routeReplacement(context, InitPage());

//                      Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => Result(model: this.model)));
                    }
                  },
                  child: Text(
                    'Start Shopping',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
