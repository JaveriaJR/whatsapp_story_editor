import 'package:flutter/material.dart';

undo({Function? onTap}) => GestureDetector(
      onTap: (() {
        if (onTap != null) onTap();
      }),
      child: SizedBox(
        height: 28,
        child: Image.asset(
          'assets/icons/undo.png',
          package: 'whatsapp_story_editor',
          fit: BoxFit.fitHeight,
        ),
      ),
    );
