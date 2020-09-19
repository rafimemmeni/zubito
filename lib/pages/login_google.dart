import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/api/product_api.dart';
import 'package:shoppingapp/main.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/widgets/commons/shadow_button.dart';

class LoginGoogle extends StatefulWidget {
  @override
  _LoginGoogleState createState() => _LoginGoogleState();
}

class _LoginGoogleState extends State<LoginGoogle> {
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Color(0xFFFCFCFC),
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );
    return Container(
      padding: EdgeInsets.only(top: 24, right: 42, left: 42),
      child: Form(
        //key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              height: 42,
              width: ScreenUtil.getWidth(context),
              margin: EdgeInsets.only(top: 32, bottom: 12),
//               child: ShadowButton(
//                 borderRadius: 12,
//                 height: 40,
//                 child: FlatButton(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: new BorderRadius.circular(8.0),
//                   ),
//                   color: themeColor.getColor(),
// //                   onPressed: () {
// //                     //if (_formKey.currentState.validate()) {
// //                     //_formKey.currentState.save();

// //                     Nav.routeReplacement(context, InitPage());

// // //                      Navigator.push(
// // //                          context,
// // //                          MaterialPageRoute(
// // //                              builder: (context) => Result(model: this.model)));
// //                     //}
// //                   },
//                   // child: Text(
//                   //   'Login In with Google',
//                   //   style: GoogleFonts.poppins(
//                   //     fontSize: 16,
//                   //     color: Colors.white,
//                   //     fontWeight: FontWeight.w400,
//                   //   ),
//                   // ),
//                 ),
//               ),
            ),
            GFButton(
                icon: SvgPicture.asset(
                  "assets/icons/google_icon.svg",
                  semanticsLabel: 'Acme Logo',
//                color: themeColor.getColor(),
                  color: Colors.white,
                ),
                buttonBoxShadow: true,
                boxShadow: BoxShadow(
                  color: themeColor.getColor().withOpacity(0.6),
                  blurRadius: 6,
                  offset: Offset(0, 0),
                ),
                color: themeColor.getColor(),
//              type: GFButtonType.outline,
                onPressed: () async {
                  //await loginUser(9496341717,context)
                  //await googleSignIn();
                  Nav.routeReplacement(context, InitPage());
                },
                text: " Login with Google "),
          ],
        ),
      ),
    );
    // return SafeArea(
    //   child: Scaffold(
    //     bottomNavigationBar: InkWell(
    //       onTap: () {
    //         Nav.routeReplacement(context, InitPage());
    //       },
    //       child: Container(
    //         margin: EdgeInsets.only(left: 14, right: 14),
    //         child: Align(
    //           alignment: Alignment.center,
    //           child: Text(
    //             "Login with Google",
    //             style: GoogleFonts.poppins(color: Colors.white),
    //           ),
    //         ),
    //         height: 60,
    //         decoration: BoxDecoration(
    //             color: themeColor.getColor(),
    //             borderRadius: BorderRadius.only(
    //                 topLeft: Radius.circular(32),
    //                 topRight: Radius.circular(32))),
    //       ),
    //     ),
    //     backgroundColor: Color(0xFFFCFCFC),
    //     body: Container(
    //       padding: EdgeInsets.all(24),
    //       child: SingleChildScrollView(
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             Text(
    //               "Login",
    //               style: GoogleFonts.poppins(
    //                   fontSize: 18, color: Color(0xFF5D6A78)),
    //             ),
    //             Container(
    //                 width: 20,
    //                 child: Divider(
    //                   color: themeColor.getColor(),
    //                   height: 1,
    //                   thickness: 2,
    //                 )),
    //             // SizedBox(
    //             //   height: 16,
    //             // ),
    //             // Container(
    //             //   margin: EdgeInsets.all(8),
    //             //   child: ListView(
    //             //     shrinkWrap: true,
    //             //     physics: NeverScrollableScrollPhysics(),
    //             //     children: <Widget>[
    //             //      // buildAddressItem(context),
    //             //      // buildAddressItem(context),
    //             //     ],
    //             //   ),
    //             // )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
