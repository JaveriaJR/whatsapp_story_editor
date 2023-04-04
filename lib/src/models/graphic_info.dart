// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:whatsapp_story_editor/src/enums/editable_item_type.dart';
import 'package:whatsapp_story_editor/src/models/text_info.dart';

class EditableItem {
  final EditableItemType editableItemType;
  final TextInfo? text;
  final String? graphicImagePath;
  final String? shapeSvg;
  final Matrix4 matrixInfo;

  EditableItem(
      {this.graphicImagePath,
      this.text,
      this.shapeSvg,
      required this.editableItemType,
      required this.matrixInfo})
      : assert(
            (editableItemType == EditableItemType.graphic &&
                    graphicImagePath != null) ||
                (editableItemType == EditableItemType.shape &&
                    shapeSvg != null) ||
                (editableItemType == EditableItemType.text && text != null),
            "Must provide related arguments");

  EditableItem copyWith({
    String? graphicImagePath,
    Matrix4? matrixInfo,
    TextInfo? text,
    String? shapeSvg,
    EditableItemType? editableItemType,
  }) {
    return EditableItem(
      graphicImagePath: graphicImagePath ?? this.graphicImagePath,
      matrixInfo: matrixInfo ?? this.matrixInfo,
      text: text ?? this.text,
      shapeSvg: shapeSvg ?? this.shapeSvg,
      editableItemType: editableItemType ?? this.editableItemType,
    );
  }

  static String circleShapeSvg() =>
      """<svg height="100" width="100"><circle cx="50" cy="50" r="40" stroke="red" stroke-width="5" fill="none" /></svg>""";
  static String arrowShapeSvg() =>
      """<svg height="24" width="24"> <path d="M2,12 L22,12 M16,6 L22,12 L16,18" stroke="red" stroke-width="2" fill="none" /></svg>""";
  static String lineShapeSvg() =>
      """<svg height="5" width="60"> <line x1="0" y1="1" x2="100" y2="1" stroke="red" stroke-width="5" /> </svg>""";
  static String doubleArrowShapeSvg() =>
      """<svg height="30" width="50"><path d="M2,12 L10,12 M14,12 L22,12 M16,6 L22,12 L16,18 M2,12 L10,12 M14,12 L2,12 M8,6 L2,12 L8,18" stroke="red" stroke-width="2" fill="none" /></svg>""";
  static String rectangleShapeSvg() =>
      """<svg height="100" width="200"><rect x="50" y="20" width="100" height="60" stroke="red" stroke-width="6" fill="none" /></svg>""";
  static String squareShapeSvg() =>
      """<svg width="100" height="100"> <rect x="10" y="10" width="80" height="80" stroke="red" stroke-width="4" fill="none"  /> </svg>""";

  static List<String> getSvgShapes() => [
        circleShapeSvg(),
        arrowShapeSvg(),
        lineShapeSvg(),
        doubleArrowShapeSvg(),
        rectangleShapeSvg(),
        squareShapeSvg()
      ];
  static String changeSvgColor(String svg, Color color) {
    List<String> svgSplitted = svg.split("""stroke=\"""");
    String colortoReplace = svgSplitted[1].split("""\" stroke-width=""")[0];

    String updatedSvg =
        "${svgSplitted[0]} stroke=\"#${svgSplitted[1].replaceAll(colortoReplace, color.toString().split("Color(0xff")[1].replaceAll(")", "").toString())}";
    return updatedSvg;
  }
}
