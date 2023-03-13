import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Common{

  static Widget container({String? text , GestureTapCallback? onTap}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:const  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          text!,style: const TextStyle(
          fontWeight: FontWeight.w600,color: Colors.blue,fontSize: 18
        ),
        ),
      ),
    );
  }
  static Widget textField({required String text,
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
        hintText: text ,
        labelText: text,
        labelStyle:const  TextStyle(color: Colors.white),
        filled: true,
        hintStyle: const TextStyle(color: Colors.white),
        fillColor: fillColor,
        focusColor: Colors.red,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder:OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
        ),
      ),
    );
  }
}