import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_story_editor/src/constants.dart';
import 'package:whatsapp_story_editor/src/controller/editing_controller.dart';
import 'package:whatsapp_story_editor/src/enums/editing_mode.dart';

/// the filters bar allows to add filters to image
filtersBar({required File file}) {
  final EditingController controller = Get.find<EditingController>();
  return Container(
      height: Get.height *
          (Constants.bottomBarHeightRatio + Constants.captionBarHeightRatio),
      color: Constants.mattBlack,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: Constants.filterTitle.length,
        itemBuilder: ((context, index) {
          return Obx(() {
            return GestureDetector(
              onTap: (() {
                controller.editingModeSelected = EDITINGMODE.FILTERS;
                controller.selectedFilter = index;
              }),
              child: Container(
                width: 65,
                margin: EdgeInsets.only(
                    bottom: 10.0,
                    top: controller.selectedFilter == index ? 10 : 18.0),
                child: Stack(children: [
                  index == 0
                      ? SizedBox(
                          height: double.infinity,
                          width: controller.selectedFilter == index ? 60 : 58,
                          child: Image.file(file, fit: BoxFit.fill),
                        )
                      : SizedBox(
                          height: double.infinity,
                          width: controller.selectedFilter == index ? 60 : 58,
                          child: ColorFiltered(
                              colorFilter:
                                  ColorFilter.matrix(Constants.filters[index]),
                              child: Image.file(file, fit: BoxFit.fill)),
                        ),
                  Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        width: controller.selectedFilter == index ? 60 : 58,
                        height: 25,
                      )),
                  Positioned(
                    bottom: 5.0,
                    left: 6.0,
                    right: 4.0,
                    child: Text(
                      Constants.filterTitle[index],
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          color: Constants.grey2,
                          fontSize: 14,
                          letterSpacing: -0.5),
                    ),
                  ),
                  controller.editingModeSelected == EDITINGMODE.FILTERS &&
                          controller.selectedFilter == index
                      ? Positioned(
                          right: 10.0,
                          top: 4.0,
                          child: Container(
                            alignment: Alignment.center,
                            height: 22,
                            width: 22,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1.5),
                                color: Colors.teal.shade600,
                                shape: BoxShape.circle),
                            child: const Icon(Icons.done, size: 15),
                          ),
                        )
                      : const SizedBox(),
                ]),
              ),
            );
          });
        }),
      ));
}
