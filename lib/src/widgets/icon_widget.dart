import 'package:flutter/material.dart';
import '../constants.dart';

buildIcon({required IconData icon, Function()? onTap}) => GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Icon(icon, color: Constants.grey2, size: 26),
    );
