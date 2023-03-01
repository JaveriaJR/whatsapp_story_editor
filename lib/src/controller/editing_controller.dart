import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_story_editor/src/enums/editable_item_type.dart';
import 'package:whatsapp_story_editor/src/models/graphic_info.dart';
import 'package:whatsapp_story_editor/src/enums/editing_mode.dart';

class EditingController extends GetxController {
  /// The color selected from the color vertical slider
  final Rx<HSVColor> _hueController = HSVColor.fromColor(Colors.green).obs;
  Rx<HSVColor> get hueController => _hueController;
  set hueController(Rx<HSVColor> hueController) =>
      _hueController.value = hueController.value;

  /// Main Background Image; usually updates after cropped and after final Editing
  /// try to minimize the memory image saving
  final Rx<File> _backgroundImage = File("").obs;
  File get backgroundImage => _backgroundImage.value;
  set backgroundImage(File newBackgroundImage) =>
      _backgroundImage.value = newBackgroundImage;

  /// selected paint-brush index (size) one of four different sizes
  /// Be-default the selected is first one
  final Rx<int> _paintBrush = 1.obs;
  int get paintBrush => _paintBrush.value;
  set paintBrush(int newpaintBrush) => _paintBrush.value = newpaintBrush;

  /// The selected editing mode from the top bar
  /// Choose from EDITINGMODE enumerator
  final Rx<EDITINGMODE> _editingModeSelected = EDITINGMODE.NONE.obs;
  EDITINGMODE get editingModeSelected => _editingModeSelected.value;
  set editingModeSelected(EDITINGMODE neweditingModeSelected) =>
      _editingModeSelected.value = neweditingModeSelected;

  /// Index of the filter that is selected
  /// Be-default it is 0 which means none/no filter applied
  final Rx<int> _selectedFilter = 0.obs;
  int get selectedFilter => _selectedFilter.value;
  set selectedFilter(int newSelectedFilter) =>
      _selectedFilter.value = newSelectedFilter;

  /// Selected Editable Information from EDITINGMODE.GRAPHIC || EDITINGMODE.TEXT
  final RxList<EditableItem?> _editableItemInfo = <EditableItem>[].obs;
  List<EditableItem?> get editableItemInfo => _editableItemInfo;
  set editableItemInfo(List<EditableItem?> editableItemInfo) =>
      _editableItemInfo.value = editableItemInfo;
  addtoEditableItemList(EditableItem editableItem) =>
      _editableItemInfo.add(editableItem);
  List<EditableItem> getEditableTextType() => _editableItemInfo
      .where((item) => item!.editableItemType == EditableItemType.text)
      .toList()
      .cast<EditableItem>();
  undoLastEditableTextItem() {
    try {
      _editableItemInfo.remove(_editableItemInfo
          .lastWhere((e) => e!.editableItemType == EditableItemType.text));
    } catch (e) {
      if (e.runtimeType == StateError) {
        debugPrint("No Text element to Undo");
      }
    }
  }

  /// Caption of the image
  final Rx<String> _caption = "".obs;
  String get caption => _caption.value;
  set caption(String newCaption) => _caption.value = newCaption;

  /// Status if the EditableItem is in Deletion Zone
  final Rx<bool> _isDeletionEligible = false.obs;
  bool get isDeletionEligible => _isDeletionEligible.value;
  set isDeletionEligible(bool status) => _isDeletionEligible.value = status;

  /// The rotation Angle of the Image if it was rotated
  final Rx<double> _rotationAngle = 0.0.obs;
  double get rotationAngle => _rotationAngle.value;
  set rotationAngle(double angle) => _rotationAngle.value = angle;

  /// The rotation Phase of the Image if it was rotated
  /// Includes from 0,1,2,3
  final Rx<int> _rotation = 0.obs;
  int get rotation => _rotation.value;
  set rotation(int rotation) => _rotation.value = rotation;
}
