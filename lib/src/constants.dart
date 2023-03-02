// ignore_for_file: non_constant_identifier_names

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class Constants {
  //Sizing
  static double editingBarHeightRatio = 0.10;
  static double captionBarHeightRatio = 0.10;
  static double bottomBarHeightRatio = 0.065;
  static double contentHeightRatio = 1 -
      (editingBarHeightRatio + captionBarHeightRatio + bottomBarHeightRatio);

  //Theme
  static Color mattBlack = const Color.fromARGB(255, 25, 40, 46);
  static Color green1 = const Color(0xFF075E54);
  static Color green2 = const Color(0xFF128C7E);
  static Color green3 = const Color.fromARGB(255, 7, 191, 139);
  static Color green4 = const Color.fromARGB(255, 53, 243, 154);
  static Color grey1 = const Color(0xFFD0E9EA);
  static Color grey2 = const Color(0xFFEDF8F5);

  //Filters
  static List<String> filterTitle = [
    "None",
    "Pop",
    "B&W",
    "Cool",
    "Chrome",
    "Film"
  ];
  static List<List<double>> filters = [
    Constants.NONE,
    Constants.FILTER_3,
    Constants.GREYSCALE_MATRIX,
    Constants.FILTER_4,
    Constants.FILTER_5,
    Constants.VINTAGE_MATRIX,
    Constants.SEPIA_MATRIX,
    Constants.FILTER_1,
    Constants.FILTER_2,
  ];

  static List<double> NONE = [
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0
  ];

  static List<double> SEPIA_MATRIX = [
    0.39,
    0.769,
    0.189,
    0.0,
    0.0,
    0.349,
    0.686,
    0.168,
    0.0,
    0.0,
    0.272,
    0.534,
    0.131,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0
  ];

  static List<double> GREYSCALE_MATRIX = [
    0.2126,
    0.7152,
    0.0722,
    0.0,
    0.0,
    0.2126,
    0.7152,
    0.0722,
    0.0,
    0.0,
    0.2126,
    0.7152,
    0.0722,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0
  ];

  static List<double> VINTAGE_MATRIX = [
    0.9,
    0.5,
    0.1,
    0.0,
    0.0,
    0.3,
    0.8,
    0.1,
    0.0,
    0.0,
    0.2,
    0.3,
    0.5,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0
  ];

  static List<double> FILTER_1 = [
    1.0,
    0.0,
    0.2,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0
  ];

  static List<double> FILTER_2 = [
    0.4,
    0.4,
    -0.3,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.2,
    0.0,
    0.0,
    -1.2,
    0.6,
    0.7,
    1.0,
    0.0
  ];

  static List<double> FILTER_3 = [
    0.8,
    0.5,
    0.0,
    0.0,
    0.0,
    0.0,
    1.1,
    0.0,
    0.0,
    0.0,
    0.0,
    0.2,
    1.1,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0
  ];

  static List<double> FILTER_4 = [
    1.1,
    0.0,
    0.0,
    0.0,
    0.0,
    0.2,
    1.0,
    -0.4,
    0.0,
    0.0,
    -0.1,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0
  ];

  static List<double> FILTER_5 = [
    1.2,
    0.1,
    0.5,
    0.0,
    0.0,
    0.1,
    1.0,
    0.05,
    0.0,
    0.0,
    0.0,
    0.1,
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0
  ];
}
