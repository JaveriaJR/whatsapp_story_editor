import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hsv_color_pickers/hsv_color_pickers.dart';
import 'package:whatsapp_story_editor/src/controller/editing_controller.dart'; 

class ColorPickerSlider extends StatefulWidget {
  const ColorPickerSlider({Key? key}) : super(key: key);

  @override
  State<ColorPickerSlider> createState() => _ColorPickerSliderState();
}

class _ColorPickerSliderState extends State<ColorPickerSlider> {
  final EditingController editingController = Get.find<EditingController>();
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: HuePicker(
        trackHeight: 10,
        controller: HueController(editingController.hueController.value),
        onChanged: (HSVColor color) { 
          setState(() {
            editingController.hueController.value = color;
          });
        },
      ),
    );
  }
}
