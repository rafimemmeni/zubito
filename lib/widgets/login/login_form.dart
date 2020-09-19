import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/main.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/widgets/commons/shadow_button.dart';
import 'package:shoppingapp/widgets/login/login_form_model.dart';
import 'package:validators/validators.dart' as validator;

import '../commons/custom_textfield.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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

    return Container(
      padding: EdgeInsets.only(top: 24, right: 42, left: 42),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            MyTextFormField(
              labelText: "Email",
              hintText: 'Email',
              isEmail: true,
              validator: (String value) {
                if (!validator.isEmail(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              onSaved: (String value) {
                model.email = value;
              },
            ),
            MyTextFormField(
              labelText: "Password",
              hintText: 'Password',
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: themeColor.getColor(),
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
              isPassword: passwordVisible,
              validator: (String value) {
                if (value.length < 7) {
                  return 'Password should be minimum 7 characters';
                }
                _formKey.currentState.save();
                return null;
              },
              onSaved: (String value) {
                model.password = value;
              },
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
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      Nav.routeReplacement(context, InitPage());
//                      Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => Result(model: this.model)));
                    }
                  },
                  child: Text(
                    'Sign In',
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
