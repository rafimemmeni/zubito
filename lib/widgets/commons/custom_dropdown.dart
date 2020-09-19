import 'package:flutter/material.dart';

class MyDropdownFormField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final Function validator;
  final Function onSaved;
  final IconButton suffixIcon;
  final bool isPassword;
  final bool isEmail;

  MyDropdownFormField({
    this.hintText,
    this.validator,
    this.onSaved,
    this.isPassword = false,
    this.isEmail = false,
    this.labelText,
    this.suffixIcon,
  });
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: DropdownButton(
          value: _value,
          items: [
            DropdownMenuItem(
              child: Text("First Item"),
              value: 1,
            ),
            DropdownMenuItem(
              child: Text("Second Item"),
              value: 2,
            ),
            DropdownMenuItem(child: Text("Third Item"), value: 3),
            DropdownMenuItem(child: Text("Fourth Item"), value: 4)
          ],
          onChanged: (value) {
            //setState(() {
            _value = value;
            //});
          }),
      // child: TextFormField(
      //   decoration: InputDecoration(
      //     hintText: hintText,
      //     contentPadding: EdgeInsets.all(15.0),
      //     border: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(8),
      //       borderSide: BorderSide(
      //         width: 0,
      //         style: BorderStyle.none,
      //       ),
      //     ),
      //     labelText: labelText,
      //     filled: true,
      //     suffixIcon: this.suffixIcon,
      //     fillColor: Color(0xFFEEEEF3),
      //   ),
      //   obscureText: isPassword ? true : false,
      //   validator: validator,
      //   onSaved: onSaved,
      //   keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      // ),
    );
  }
}
