import 'package:flutter/material.dart';

class SavedImageView extends StatefulWidget {
  final MemoryImage image;
  final String? caption;
  const SavedImageView({Key? key, required this.image, required this.caption})
      : super(key: key);

  @override
  State<SavedImageView> createState() => _SavedImageViewState();
}

class _SavedImageViewState extends State<SavedImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 25, 40, 46),
          title: const Text("WhatsApp Story Editor Results")),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Image(
                  image: widget.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              widget.caption ?? "no caption",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
