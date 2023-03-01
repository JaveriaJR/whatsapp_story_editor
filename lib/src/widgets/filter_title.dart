import 'package:flutter/material.dart';
import 'package:whatsapp_story_editor/src/widgets/vertical_gest_behavior.dart';
import 'package:whatsapp_story_editor/src/widgets/shake_widget.dart';

import '../constants.dart';

filterTitle() => verticalGestureBehavior(
      child: ShakeWidget(
        child: Column(children: [
          const Icon(Icons.keyboard_arrow_up_rounded, color: Colors.white),
          const SizedBox(height: 4.0),
          Text(
            "Filters",
            style: TextStyle(color: Constants.grey2),
          ),
        ]),
      ),
    );
