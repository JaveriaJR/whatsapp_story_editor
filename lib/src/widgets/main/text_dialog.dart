import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_story_editor/src/constants.dart';

class TextDialog extends StatelessWidget {
  const TextDialog({
    Key? key,
    required this.controller,
    required this.fontSize,
    required this.onFinished,
    this.onSubmitted,
    required this.color,
  }) : super(key: key);
  final TextEditingController controller;
  final double fontSize;
  final VoidCallback onFinished;
  final Function(String text)? onSubmitted;
  final Color color;
  static void show(BuildContext context, TextEditingController controller,
      double fontSize, Color color,
      {required ValueChanged<BuildContext> onFinished, onSubmitted}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return TextDialog(
            controller: controller,
            fontSize: fontSize,
            onFinished: () => onFinished(context),
            onSubmitted: (s) => onSubmitted(s),
            color: color,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.only(
            top: Get.height * Constants.editingBarHeightRatio, right: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
              autofocus: true,
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: color),
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                border: InputBorder.none,
              ),
              onTapOutside: (e) {
                onFinished();
              },
              onEditingComplete: onFinished,
              onSubmitted: (s) {
                onSubmitted!(s);
              },
            ),
          ],
        ),
      ),
    );
  }
}
