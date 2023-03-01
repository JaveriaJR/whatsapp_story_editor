library whatsapp_story_editor;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_story_editor/src/controller/editing_binding.dart';
import 'package:whatsapp_story_editor/src/views/main_view.dart';
import 'package:whatsapp_camera/whatsapp_camera.dart';

class WhatsappStoryEditorResult {
  MemoryImage image;
  String? caption;
  WhatsappStoryEditorResult({required this.image, this.caption});
}

class WhatsappStoryEditor extends StatefulWidget {
  const WhatsappStoryEditor({Key? key}) : super(key: key);

  @override
  State<WhatsappStoryEditor> createState() => _WhatsappStoryEditorState();
}

class _WhatsappStoryEditorState extends State<WhatsappStoryEditor> {
  // final files = ValueNotifier(<File>[]);

  @override
  void initState() {
    // files.addListener(() => setState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // List<File>? res =
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const WhatsappCamera(),
        ),
      ).then((res) {
        if (res != null) {
          // files.value = res;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainControllerView(
                // file: files.value.first,
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
