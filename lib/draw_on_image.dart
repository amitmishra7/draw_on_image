import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:path_provider/path_provider.dart';

class DrawOnImage extends StatefulWidget {
  @override
  _DrawOnImageState createState() => _DrawOnImageState();
}

class _DrawOnImageState extends State<DrawOnImage> {
  final _imageKey = GlobalKey<ImagePainterState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Paint'),
      ),
      body: ImagePainter.asset(
        'assets/brush.jpg',
        key: _imageKey,
        scalable: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: saveImage,
        child: Icon(Icons.save),
      ),
    );
  }

  Future<void> saveImage() async {
    final uInt8ListImage = await _imageKey.currentState!.exportImage();
    final Directory? directory = await getExternalStorageDirectory();
    final fullPath = directory!.path +
        DateTime.now().millisecondsSinceEpoch.toString() +
        '.jpg';
    final imageFile = File(fullPath);
    imageFile.writeAsBytesSync(uInt8ListImage);
    
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Image saved successfully!')));
  }
}
