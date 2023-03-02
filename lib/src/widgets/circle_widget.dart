import 'package:flutter/material.dart';

circleWidget(
        {double? radius = 50,
        Color? bgColor,
        EdgeInsetsGeometry? padding,
        Function? onTap,
        Widget? child}) =>
    GestureDetector(
      onTap: (() {
        if (onTap != null) onTap();
      }),
      child: Container(
          padding: padding,
          height: radius,
          width: radius,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor ?? const Color.fromARGB(255, 7, 191, 139)),
          child: child),
    );
