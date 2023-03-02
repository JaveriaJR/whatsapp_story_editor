library whatsapp_story_editor;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_story_editor/src/controller/editing_binding.dart';
import 'package:whatsapp_story_editor/src/views/main_view.dart';
import 'package:whatsapp_camera/whatsapp_camera.dart';

///To encapsulate the result of editing a WhatsApp story.
///The image property contains the edited image,
///and the caption property contains the caption (if any) that was added to the image.
class WhatsappStoryEditorResult {
  MemoryImage image;
  String? caption;
  WhatsappStoryEditorResult({required this.image, this.caption});
}

///Allows users to edit a WhatsApp story by adding captions and stickers to an image.
class WhatsappStoryEditor extends StatefulWidget {
  const WhatsappStoryEditor({Key? key}) : super(key: key);

  @override
  State<WhatsappStoryEditor> createState() => _WhatsappStoryEditorState();
}

class _WhatsappStoryEditorState extends State<WhatsappStoryEditor> {
  @override
  void initState() {
    //Switch to WhatsappCamera
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const WhatsappCamera(),
        ),
      ).then((res) {
        //pass results to MainController
        if (res != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainControllerView(
                file: res[0],
              ),
            ),
          );
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // files.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, (route) => route.isFirst);
        return true;
      },
      child: GetMaterialApp(
        initialBinding: EditingBinding(),
        debugShowCheckedModeBanner: false,
        color: Colors.black,
        home: Container(),
      ),
    );
  }
}
