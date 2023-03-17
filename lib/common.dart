import 'package:flutter/material.dart';

class Common {
  static String verificationId = '';

  static Widget container({
    String? text,
    GestureTapCallback? onTap,
    bool loading = false
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
        child: loading ? const CircularProgressIndicator() :Text(
          text!,
          style: const TextStyle(
              fontWeight: FontWeight.w600, color: Colors.blue, fontSize: 18),
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
    int? maxline,

    required Color bordercolor,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
maxLines: maxline,
      style: TextStyle(color: color),
      decoration: InputDecoration(
        hintText: text,
        labelText: text,
        labelStyle: TextStyle(color: hintcolor),
        filled: true,
        hintStyle: TextStyle(color: hintcolor),
        fillColor: fillColor,
        focusColor: Colors.red,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: bordercolor, width: 0.7),
          borderRadius: BorderRadius.circular(18.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
        ),
      ),
    );
  }

  static Widget updateButton({
    String? text,
    bool loading = false,
    GestureTapCallback? onTap,
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
        child: loading? const CircularProgressIndicator() : Text(
          text!,
          style: TextStyle(
              fontWeight: FontWeight.w600, color: textcolor, fontSize: 18),
        ),
      ),
    );
  }
}
