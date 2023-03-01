import 'package:flutter/material.dart';

doneBtn({Function? onTap}) => GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        height: 30,
        width: 70,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Text(
          "Done",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
