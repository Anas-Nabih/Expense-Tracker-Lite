import 'package:flutter/material.dart';

class SizeConfig{
  static const double desktopBreakPoint = 1200;
  static const double tabletBreakPoint = 800;

  static late double height, width;

  static initScreenDimensions(BuildContext context){
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
  }
}