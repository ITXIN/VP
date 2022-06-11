import 'package:flutter/material.dart';
import 'dart:ui';

class Global {
  static MediaQueryData mediaQueryData = MediaQueryData.fromWindow(window);
  static double screenWidth = mediaQueryData.size.width;
  static double screenHeight = mediaQueryData.size.height;
}
