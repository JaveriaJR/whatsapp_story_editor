import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:whatsapp_story_editor/src/controller/editing_controller.dart';
import 'package:whatsapp_story_editor/src/enums/editable_item_type.dart';
import 'package:whatsapp_story_editor/src/models/sticker_data.dart';
import 'package:whatsapp_story_editor/src/models/graphic_info.dart';
import 'package:whatsapp_story_editor/src/widgets/circle_widget.dart';
import 'package:whatsapp_story_editor/src/widgets/icon_widget.dart';

class GraphicView extends StatefulWidget {
  const GraphicView({Key? key}) : super(key: key);

  @override
  State<GraphicView> createState() => _GraphicViewState();
}

class _GraphicViewState extends State<GraphicView> {
  late StickerData stickerData;
  bool isStickersLoading = true;
  bool isSearchSelected = false;
  int switchSelected = 0;
  final EditingController editingController = Get.find<EditingController>();

  _loadStickers() async {
    var data = await rootBundle.loadString(
        "packages/whatsapp_story_editor/assets/stickers/sticker_packs.json");
    stickerData = StickerData.fromJson(jsonDecode(data.toString()));
    setState(() {
      isStickersLoading = false;
    });
  }

  @override
  void initState() {
    _loadStickers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24.0),
        decoration: const BoxDecoration(
          color: Colors.black,
          // image: DecorationImage(
          //   //TODO: add selected image here
          //   image: NetworkImage(
          //     'https://cdn.pixabay.com/photo/2022/12/05/19/36/hellebore-7637542_1280.jpg',
          //   ),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 18.0),
                _topBar(context),
                const SizedBox(height: 10.0),
                isSearchSelected ? _searchBar() : _switchBar(),
                const SizedBox(height: 35),
                Text(switchSelected == 0 ? "Favourites" : "Smileys & People",
                    style: const TextStyle(color: Colors.grey, fontSize: 13)),
                isStickersLoading
                    ? const SizedBox()
                    : Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(0),
                          itemCount: switchSelected == 0
                              ? stickerData.stickerPacks!.first.stickers!
                                  .length //stickers
                              : 88, //out of 300+ available emojies in asset
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              alignment: (index + 1) % 4 == 0
                                  ? Alignment.centerRight
                                  : index % 4 == 0
                                      ? Alignment.centerLeft
                                      : Alignment.center,
                              margin: (index + 1) % 4 == 0
                                  ? const EdgeInsets.only(left: 14)
                                  : index % 4 == 0
                                      ? const EdgeInsets.only(right: 14)
                                      : const EdgeInsets.only(
                                          right: 8, left: 8),
                              child: switchSelected == 0
                                  ? GestureDetector(
                                      onTap: () {
                                        editingController.addtoEditableItemList(
                                            EditableItem(
                                                editableItemType:
                                                    EditableItemType.graphic,
                                                graphicImagePath:
                                                    "packages/whatsapp_story_editor/assets/stickers/2/${stickerData.stickerPacks!.first.stickers![index].imageFile}",
                                                matrixInfo:
                                                    Matrix4.identity()));

                                        Navigator.pop(context);
                                      },
                                      child: SizedBox(
                                        height: 65,
                                        width: 65,
                                        child: Image.asset(
                                          "packages/whatsapp_story_editor/assets/stickers/2/${stickerData.stickerPacks!.first.stickers![index].imageFile}",
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        editingController.addtoEditableItemList(
                                            EditableItem(
                                                editableItemType:
                                                    EditableItemType.graphic,
                                                graphicImagePath:
                                                    "packages/whatsapp_story_editor/assets/emojies/e15${index + 11}.png",
                                                matrixInfo:
                                                    Matrix4.identity()));
                                        Navigator.pop(context);
                                      },
                                      child: SizedBox(
                                        height: 60,
                                        width: 60,
                                        child: Image.asset(
                                          "packages/whatsapp_story_editor/assets/emojies/e15${index + 11}.png",
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                            );
                          },
                        ),
                      )
              ],
            )),
      ),
    );
  }

  _topBar(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      buildIcon(icon: Icons.arrow_back, onTap: () => Navigator.pop(context)),
      Obx(() => circleWidget(
          radius: 40,
          bgColor: Get.find<EditingController>().hueController.value.toColor(),
          child: const Icon(
            Icons.emoji_emotions_outlined,
            color: Colors.white,
          )))
    ]);
  }

  _searchBar() {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        style: const TextStyle(
            color: Colors.black54, fontSize: 16.0, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isSearchSelected = false;
                  });
                },
                child: const Icon(Icons.close, color: Colors.black54)),
            prefixIcon: const Icon(Icons.search, color: Colors.black87),
            hintText: 'Search',
            hintStyle: const TextStyle(
                color: Colors.black45,
                fontSize: 18.0,
                fontWeight: FontWeight.w400)),
      ),
    );
  }

  _switchBar() => Row(children: [
        buildIcon(
            icon: Icons.search,
            onTap: () => setState(() => isSearchSelected = true)),
        const Spacer(),
        GestureDetector(
          onTap: () => setState(() => switchSelected = 0),
          child: Container(
              height: 35,
              width: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: switchSelected == 0
                      ? Colors.white.withOpacity(0.9)
                      : Colors.white.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Text(
                "Stickers",
                style: TextStyle(
                    color: switchSelected == 0
                        ? Colors.black.withOpacity(0.8)
                        : Colors.white.withOpacity(0.7),
                    fontSize: 15),
              )),
        ),
        GestureDetector(
          onTap: () => setState(() => switchSelected = 1),
          child: Container(
            height: 35,
            width: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: switchSelected == 1
                    ? Colors.white.withOpacity(0.9)
                    : Colors.white.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Text(
              "Emoji",
              style: TextStyle(
                  color: switchSelected == 1
                      ? Colors.black.withOpacity(0.7)
                      : Colors.white.withOpacity(0.8),
                  fontSize: 15),
            ),
          ),
        ),
        const Spacer(),
      ]);
}
