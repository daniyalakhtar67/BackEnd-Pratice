import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Uihelper {
  static CustomeText({required String text, FontWeight?fontWeight, Color?color,required double fontsize}){
    return Text(text,style: GoogleFonts.roboto(
      fontSize: fontsize,
    ),);
  }
  static CustomTextFeild({required TextEditingController controller,
  required String text,
    required TextInputType textinputype,
     IconData? icondata,
    String? hintext,
  }){
    return Container(
      height: 45,
      width: 360,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintext,
          prefixIcon: Icon(icondata,color: Colors.white),
          hintStyle: GoogleFonts.roboto(
            fontSize: 14,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}