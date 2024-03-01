import 'dart:io';

import 'package:example/saved_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp_story_editor/whatsapp_story_editor.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

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
  final List<String> imageUrl = [
    'assets/cake.jpg',
    'assets/image1.jpg',
    'assets/image2.jpg',
    'assets/persion.jpeg',
    // Add more image URLs as needed
  ];
  var data;
  List<File?> imageUrls = [];
  Future<File?> getImageFileFromAsset(String assetPath) async {
    try {
      final ByteData byteData = await rootBundle.load(assetPath);
      final List<int> byteList = byteData.buffer.asUint8List();

      // Get the temporary directory path
      final String tempPath = (await getTemporaryDirectory()).path;

      // Extract the file name from the asset path
      final String fileName = basename(assetPath);

      // Create the temporary file with the correct path
      final File tempFile = File('$tempPath/$fileName');

      // Write the bytes to the file
      await tempFile.writeAsBytes(byteList, flush: true);

      return tempFile;
    } catch (e) {
      print('Error loading asset: $e');
      return null;
    }
  }

  Future<void> loadImageFiles() async {
    for (var i = 0; i < imageUrl.length; i++) {
      final File? file = await getImageFileFromAsset(imageUrl[i]);
      setState(() {
        imageUrls.add(file);
      });
    }
    print(imageUrls);

    // Now, you can use the populated imageFiles list as needed.
  }

  @override
  void initState() {
    super.initState();
    loadImageFiles();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.black,
          body:data==null? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 8.0, // Spacing between columns
                  mainAxisSpacing: 8.0, // Spacing between rows
                ),
                itemCount: imageUrls.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WhatsappStoryEditor(
                                  image: imageUrls[index],
                                )),
                      ).then((whatsappStoryEditorResult) {
                        // if (whatsappStoryEditorResult != null) {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => SavedImageView(
                        //               image: whatsappStoryEditorResult.image,
                        //               caption:
                        //                   whatsappStoryEditorResult.caption,
                        //             )),
                        //   );
                        // }
                        setState(() {
                          data = whatsappStoryEditorResult;
                        });
                        print("data :${data.image}");
                        print("data :${data.caption}");
                      });
                    },
                    child: Image.file(
                      imageUrls[index]!,
                      fit: BoxFit
                          .cover, // Adjust the image to cover the entire cell
                    ),
                  );
                },
              )
            ],
          ):Stack(
            children: [
              
                  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Container(
                  alignment: Alignment.center,
                  child: Image(
                    image: data.image,
                    fit: BoxFit.contain,
                  ),
                  ),
              ),
              const SizedBox(height: 30),
              Text(
                  data.caption ?? "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 30),
            ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(onPressed: () {
                        print("object");
                        setState(() {
                          
                        });
                        data=null;
                      }, icon: Icon(Icons.clear,color: Colors.white,)),
                    ),
                  )
                ],
          ),
        ));
  }
}
