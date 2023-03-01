import 'package:get/get.dart';
import 'package:whatsapp_story_editor/src/controller/editing_controller.dart';

class EditingBinding implements Bindings {
// default dependency
  @override
  void dependencies() {
    Get.lazyPut(() => EditingController());
  }
}
