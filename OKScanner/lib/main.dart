import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

void main() {
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
        primarySwatch: Colors.orange,
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

  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    //final imageTemporary = File(image.path);
    final imagePermanent = await saveFilePermanently(image.path);
    setState(() {
      _image = imagePermanent;
    });
  }

  Future<File> saveFilePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "OK Scanner",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.mail,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
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
            height: 30,
          ),
          _image != null
              ? Image.file(
                  _image!,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                )
              : Image.asset('assets/images/yz_200.png'),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.cyan, // background
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
                        primary: Colors.cyan, // background
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
                        primary: Colors.green, // background
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
          Center(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: SizedBox(
                    width: 118,
                    height: 90,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.cyan, // background
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
                            Icons.document_scanner_sharp,
                            color: Colors.white,
                            size: 40,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Belgelerim',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: SizedBox(
                    width: 114,
                    height: 90,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.cyan, // background
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
                              Icons.share,
                              size: 40,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Paylaş',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(1, 0, 6, 0),
                  child: SizedBox(
                    width: 108,
                    height: 90,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.cyan, // background
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
                              Icons.info,
                              size: 40,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Info',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
