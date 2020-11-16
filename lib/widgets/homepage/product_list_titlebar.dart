import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';

class ProductListTitleBar extends StatelessWidget {
  const ProductListTitleBar({
    Key key,
    @required this.themeColor,
    this.title,
    this.isCountShow,
  }) : super(key: key);

  final ThemeNotifier themeColor;
  final String title;
  final bool isCountShow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Color(0xFF5D6A78),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),          
        ],
      ),
    );
  }
}
