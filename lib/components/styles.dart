import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static TextStyle titleLoginAppGoogleFont(double size) {
    return GoogleFonts.nunito(
        color: Colors.white, fontSize: size, fontWeight: FontWeight.w700);
  }

  static TextStyle textBlackGoogleFontSize(double size) {
    return GoogleFonts.nunito(
        color: Colors.black, fontSize: size, fontWeight: FontWeight.w700);
  }

  static TextStyle textBlackSubGoogleFontSize(double size) {
    return GoogleFonts.nunito(
        color: Colors.black, fontSize: size, fontWeight: FontWeight.w400);
  }

  static TextStyle textBackInfoGoogleFontsize(double size) {
    return GoogleFonts.nunito(
        color: Colors.black, fontSize: size, fontWeight: FontWeight.w700);
  }

  static TextStyle textRedTitleGoogleFontSize(double size) {
    return GoogleFonts.nunito(
        color: Colors.red[300], fontSize: size, fontWeight: FontWeight.w700);
  }

  static TextStyle buttomGoogleSign() {
    return GoogleFonts.nunito(
        color: Colors.blue[400], fontWeight: FontWeight.w500);
  }

  static TextStyle buttomGoogleSignPersonal(double size) {
    return GoogleFonts.nunito(
        color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: size);
  }

  static TextStyle buttomReservar() {
    return GoogleFonts.nunito(color: Colors.white, fontWeight: FontWeight.w600);
  }

  static TextStyle labelVersionApp() {
    return GoogleFonts.nunito(color: Colors.white, fontWeight: FontWeight.w700);
  }
}
