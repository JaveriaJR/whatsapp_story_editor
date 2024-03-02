import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_story_editor/src/constants.dart';
import 'package:whatsapp_story_editor/src/controller/editing_controller.dart';
import 'package:whatsapp_story_editor/src/enums/editable_item_type.dart';
import 'package:whatsapp_story_editor/src/enums/editing_mode.dart';
import 'package:whatsapp_story_editor/src/models/graphic_info.dart';
import 'package:whatsapp_story_editor/src/models/text_info.dart';
import 'package:whatsapp_story_editor/src/widgets/color_picker_slider.dart';
import 'package:whatsapp_story_editor/src/widgets/bars/bottom_bar.dart';
import 'package:whatsapp_story_editor/src/widgets/bars/caption_bar.dart';
import 'package:whatsapp_story_editor/src/widgets/circle_widget.dart';
import 'package:whatsapp_story_editor/src/widgets/done_btn.dart';
import 'package:whatsapp_story_editor/src/widgets/text_dialog.dart';
import 'package:whatsapp_story_editor/src/widgets/undo.dart';

///Allows to add Text over the Image
class TextView extends StatefulWidget {
  const TextView({Key? key}) : super(key: key);

  @override
  State<TextView> createState() => _TextViewState();
}

class _TextViewState extends State<TextView> {
  final EditingController controller = Get.find<EditingController>();
  Offset? lastTappedOffset;
  final double sHeight = Get.height;
  final double sWidth = Get.width;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showTextEditDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            _textBar(),
            const Spacer(),
            captionBar(context: context),
            bottomBar(context: context),
          ],
        ),

        /// to add text on clicking anywhere on screen
        Positioned(
            top: sHeight * Constants.editingBarHeightRatio,
            bottom: sHeight *
                (Constants.captionBarHeightRatio +
                    Constants.bottomBarHeightRatio),
            child: _drawTextPainter()),
        const Positioned(top: 80, right: 16, child: ColorPickerSlider())
      ],
    );
  }

  _showTextEditDialog() {
    TextDialog.show(context, TextEditingController(), 36,
        controller.hueController.value.toColor(),
        onFinished: (context) => Navigator.of(context).pop(),
        onSubmitted: (text) {
          controller.addtoEditableItemList(EditableItem(
            editableItemType: EditableItemType.text,
            matrixInfo: Matrix4.identity(),
            text: TextInfo(
              text: text,
              offset: lastTappedOffset,
              color: controller.hueController.value.toColor(),
            ),
          ));
          controller.editingModeSelected = EDITINGMODE.NONE;
        });
  }

  _textBar() {
    final controller = Get.find<EditingController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Row(
        children: [
          doneBtn(onTap: () async {
            controller.editingModeSelected = EDITINGMODE.NONE;
          }),
          const Spacer(),
          Obx(() => controller.getEditableTextType().isNotEmpty
              ? undo(
                  onTap: () => setState(() {
                        controller.undoLastEditableTextItem();
                      }))
              : const SizedBox()),
          const SizedBox(width: 10.0),
          Obx(
            () => circleWidget(
                radius: 45,
                bgColor: controller.hueController.value.toColor(),
                onTap: () => TextDialog.show(context, TextEditingController(),
                    16, controller.hueController.value.toColor(),
                    onFinished: (context) => Navigator.of(context).pop(),
                    onSubmitted: (text) => controller.addtoEditableItemList(
                        EditableItem(
                            editableItemType: EditableItemType.text,
                            matrixInfo: Matrix4.identity(),
                            text: TextInfo(
                                text: text,
                                offset: null,
                                color: controller.hueController.value
                                    .toColor())
                                    ))),
                child: const Icon(
                  Icons.title,
                  color: Colors.white,
                )),
          )
        ],
      ),
    );
  }

  /// TO PAINT TEXT INSTEAD OF WRITING THROUGH TEXTFIELD
  /// Not being used Currently
  _drawTextPainter() {
    return GestureDetector(
      // onTapDown: (TapDownDetails details) => setState(() {
      //   // lastTappedOffset = details.localPosition;
      // }),
      onTap: () {
       
        _showTextEditDialog();
      },
      child: Container(
        color: Colors.red,
        // width: Get.width,
        // height: Get.height * Constants.contentHeightRatio,
      ),
      // child: CustomPaint(
      //   size: Size(sWidth, sHeight * Constants.contentHeightRatio),
      //   painter: Sketcher(editingmode: EDITINGMODE.TEXT),
      // ),
    );
  }
}
