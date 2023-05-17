import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomTextFields extends StatelessWidget {
  CustomTextFields(
      {this.controller,
        this.obscure=false,
        this.height,
        this.validator,
        this.hintText,
        this.label,
        this.onchanged,this.prefixIcon,this.onsaved,this.onpressedLeading,this.leadinIcon,this.borderradius,this.hintColor,this.fillColor});
  var height;
  var fillColor;
  var hintText;
  var hintColor;
  var label;
  var borderradius;
  var onchanged;
  var onsaved;
  var controller;
  var prefixIcon;
  var leadinIcon;
  var onpressedLeading;
  var validator;
  var obscure;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:5),
      child: TextFormField(

        obscureText: obscure,
        validator: validator ,
        cursorColor: Color(0xffD9D9D9),
        style:GoogleFonts.workSans(textStyle: TextStyle(color: Color(0xffD9D9D9),)),
        // cursorWidth: 20,
        decoration: InputDecoration(


          prefixIcon: prefixIcon??prefixIcon ,
          suffixIcon: leadinIcon??leadinIcon,
          suffixIconColor: Color(0xffD9D9D9),
          prefixIconColor: Color(0xffD9D9D9),
          fillColor: fillColor!=null?fillColor:Color(0xff898787).withOpacity(0.50),
          filled: true,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderradius!=null?borderradius:10),
              borderSide: BorderSide(
                width: 1,
                color:Color(0xff898787).withOpacity(0.50)
              )),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderradius!=null?borderradius:20),
              borderSide: BorderSide(
                width: 1,
                color:Color(0xffD9D9D9)

              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderradius!=null?borderradius:20),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderradius!=null?borderradius:20),
              borderSide: BorderSide(
                width: 1,
                color: Color(0xffD9D9D9),
              )),
          contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          hintText: hintText ?? hintText,
          hintStyle: GoogleFonts.workSans(textStyle: TextStyle(color: hintColor!=null?hintColor:Color(0xffD9D9D9))),
          // hintStyle: TextStyle()
        ),
        onChanged: onchanged ?? onchanged,
        onSaved: onsaved ?? onsaved,
        controller: controller ?? controller,
      ),
    );
  }
}