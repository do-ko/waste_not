import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});

  final String title = 'Add product';

  @override
  State<AddProductView> createState() => _AddProductPage();
}

class _AddProductPage extends State<AddProductView> {
  bool textScanning = false;

  XFile? imageFile;

  String scannedText = "";

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        getRecognisedText(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occured while scanning";
      setState(() {});
    }
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    RegExp exp = RegExp(
        r'(\d{2}/\d{2}/\d{4})|(\d{2}.\d{2}.\d{4})|(\d{2}-\d{2}-\d{4})|(\d{4}/\d{2}/\d{2})|(\d{4}.\d{2}.\d{2})|(\d{4}-\d{2}-\d{2})|(\d{2}/\d{2}/\d{2})|(\d{2}.\d{2}.\d{2})|(\d{2}-\d{2}-\d{2})|(\d{2}/\d{4})|(\d{2}.\d{4})|(\d{2}-\d{4})');
    // String test = "test string 12/12/24";
    // RegExpMatch? match = exp.firstMatch(test);
    // if (match != null) {
    //   String foundDate = match.group(
    //       0)!; // Safely extract the matched date (non-null guaranteed by if-check)
    //   scannedText = scannedText +
    //       foundDate +
    //       "\n"; // Append the found date to your result string with a newline
    //   print(foundDate);
    //   // print("Date found: $foundDate");  // Optional: output the found date
    // }
    scannedText = "";
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        // Handle each line of text here
        // scannedText = "";
        RegExpMatch? match = exp.firstMatch(line.text);
        if (match != null) {
          // print(match.pattern);
          String foundDate = match.group(
              0)!; // Safely extract the matched date (non-null guaranteed by if-check)
          scannedText = scannedText +
              foundDate +
              "\n"; // Append the found date to your result string with a newline
          print(foundDate);
          // print("Date found: $foundDate");  // Optional: output the found date
        }
        // scannedText = scannedText + line.text + "\n";
      }
    }
    textScanning = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (textScanning) const CircularProgressIndicator(),
              if (!textScanning && imageFile == null)
                Container(
                  width: 300,
                  height: 300,
                  color: Colors.grey[300]!,
                ),
              if (imageFile != null) Image.file(File(imageFile!.path)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // primary: Colors.white,
                          // onPrimary: Colors.grey,
                          shadowColor: Colors.grey[400],
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                        ),
                        onPressed: () {
                          getImage(ImageSource.gallery);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.image,
                                size: 30,
                              ),
                              Text(
                                "Gallery",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[600]),
                              )
                            ],
                          ),
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // primary: Colors.white,
                          // onPrimary: Colors.grey,
                          shadowColor: Colors.grey[400],
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                        ),
                        onPressed: () {
                          getImage(ImageSource.camera);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.camera_alt,
                                size: 30,
                              ),
                              Text(
                                "Camera",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[600]),
                              )
                            ],
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(
                  // height: 20,
                  ),
              Container(
                child: Text(
                  scannedText,
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
