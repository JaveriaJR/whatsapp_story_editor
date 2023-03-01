import 'package:example/saved_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp_story_editor/whatsapp_story_editor.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static Color mattBlack = const Color.fromARGB(255, 25, 40, 46);
  static Color green3 = const Color.fromARGB(255, 7, 191, 139);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.black,
          floatingActionButton: Builder(builder: (context) {
            return FloatingActionButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WhatsappStoryEditor()),
                ).then((whatsappStoryEditorResult) {
                  if (whatsappStoryEditorResult != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SavedImageView(
                                image: whatsappStoryEditorResult.image,
                                caption: whatsappStoryEditorResult.caption,
                              )),
                    );
                  }
                });
              },
              child: Container(
                height: 60,
                width: 60,
                decoration:
                    BoxDecoration(color: green3, shape: BoxShape.circle),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            );
          }),
          body: Container(
            color: mattBlack,
            padding: const EdgeInsets.only(top: 50, left: 18, right: 18),
            height: 140,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "WhatsApp",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white38,
                    fontSize: 21,
                  ),
                ),
                const Spacer(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Chats",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white38,
                          fontSize: 16,
                        ),
                      ),
                      Center(
                        child: Text(
                          "Status",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white38,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        "Calls",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white38,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Center(child: Container(height: 3, width: 130, color: green3))
              ],
            ),
          ),
        ));
  }
}
