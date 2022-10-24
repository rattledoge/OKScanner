import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory root =
      await getApplicationDocumentsDirectory(); // this is using path_provider
  String directoryPath = root.path + '/okscanner';
  await Directory(directoryPath)
      .create(recursive: true); // the error because of this line
  String filePath = '$directoryPath/${DateTime.now()}.jpg';

  print(filePath);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OK SCANNER',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image;
  var _selectedIndex;
  var _onItemTapped;

  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    File? img = File(image.path);
    img = await _cropImage(imageFile: img);
    final bytes = File(img!.path).readAsBytesSync();
    String img64 = base64Encode(bytes);
    print(img64);
    setState(() {
      _image = img;
    });
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

// koyu renk Color(0xFF152733) - turuncu renk Color(0xFFF17D09)
  @override
  Widget build(BuildContext context) {
    int _bottomNavIndex;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFF17D09),

        onPressed: () {},

        child: const Icon(
          Icons.document_scanner_sharp,
          color: Colors.white,
          size: 30,
        ),
        //params
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [Icons.home, Icons.share],
        iconSize: 30,
        inactiveColor: Colors.white,
        activeIndex: 2,
        backgroundColor: Color(0xFF152733),
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 0,
        rightCornerRadius: 0,
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF152733),
        title: const Text(
          "Fotoğrafları metne çevir",
          style: TextStyle(color: Colors.white,fontSize: 16),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Önizleme",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFF152733)),
          ),
          const SizedBox(
            height: 10,
          ),
          _image != null
              ? Image.file(
                  _image!,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                )
              : Icon(Icons.image_search,size: 180,),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF152733), // background
                      onPrimary: Colors.black, // foreground
                    ),
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                    child: Column(
                      children: const [
                        SizedBox(
                          height: 10,
                        ),
                        Icon(
                          Icons.image,
                          color: Colors.white,
                          size: 40,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Galeriden Seç',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF152733), // background
                        onPrimary: Colors.black, // foreground
                      ),
                      onPressed: () {
                        getImage(ImageSource.camera);
                      },
                      child: Column(
                        children: const [
                          SizedBox(
                            height: 10,
                          ),
                          Icon(
                            Icons.camera_alt_sharp,
                            size: 40,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Fotograf Çek',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(1, 0, 6, 0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFF17D09), // background
                        onPrimary: Colors.black, // foreground
                      ),
                      onPressed: () {
                        getImage(ImageSource.camera);
                      },
                      child: Column(
                        children: const [
                          SizedBox(
                            height: 10,
                          ),
                          Icon(
                            Icons.send,
                            size: 40,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Metne Çevir',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
          const Divider(
            height: 30,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
