import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Common {
  static String verificationId = '';

  static Widget container({String? text, GestureTapCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          text!,
          style: const TextStyle(
              fontWeight: FontWeight.w600, color: Colors.blue, fontSize: 18),
        ),
      ),
    );
  }

  static Widget textField({
    String? text,
    Widget? prefixIcon,
    Widget? suffixIcon,
    TextEditingController? controller,
    dynamic validator,
    Color? fillColor,
  }) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: validator,
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: text,
        labelText: text,
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        hintStyle: const TextStyle(color: Colors.white),
        fillColor: fillColor,
        focusColor: Colors.red,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
        ),
      ),
    );
  }

  static Widget custumtextfield({
    String? text,
    Widget? prefixIcon,
    Widget? suffixIcon,
    TextEditingController? controller,
    dynamic validator,
    Color? fillColor,
    Color? color,
    Color? hintcolor,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style:  TextStyle(color: color),
      decoration: InputDecoration(
        hintText: text,
        labelText: text,
        labelStyle: const TextStyle(color: Colors.black87),
        filled: true,
        hintStyle:  TextStyle(color: hintcolor),
        fillColor: fillColor,
        focusColor: Colors.red,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black,width: 0.7),
          borderRadius: BorderRadius.circular(18.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
        ),
      ),
    );
  }

  static Widget updateButton({String? text, GestureTapCallback? onTap,
    Color? color,
    Color? textcolor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          text!,
          style: TextStyle(
              fontWeight: FontWeight.w600, color: textcolor, fontSize: 18),
        ),
      ),
    );
  }

}
