import 'package:flutter/gestures.dart';
import 'package:whatsapp_story_editor/src/enums/editable_item_type.dart';
import 'package:whatsapp_story_editor/src/models/text_info.dart';

class EditableItem {
  final EditableItemType editableItemType;
  final TextInfo? text;
  final String? graphicImagePath;
  final Matrix4 matrixInfo;

  EditableItem(
      {this.graphicImagePath,
      this.text,
      required this.editableItemType,
      required this.matrixInfo})
      : assert(
            (editableItemType == EditableItemType.graphic &&
                    graphicImagePath != null) ||
                (editableItemType == EditableItemType.text && text != null),
            "Must provide related arguments");

  EditableItem copyWith({
    String? graphicImagePath,
    Matrix4? matrixInfo,
    TextInfo? text,
    EditableItemType? editableItemType,
  }) {
    return EditableItem(
      graphicImagePath: graphicImagePath ?? this.graphicImagePath,
      matrixInfo: matrixInfo ?? this.matrixInfo,
      text: text ?? this.text,
      editableItemType: editableItemType ?? this.editableItemType,
    );
  }
}
