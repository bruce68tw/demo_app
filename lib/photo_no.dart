import 'dart:io';
import 'package:flutter/material.dart';
import 'package:base_lib/all.dart';
import 'package:image_picker/image_picker.dart';
import 'all_com.dart';

class PhotoNo extends StatefulWidget {
  const PhotoNo({ Key? key }) : super(key: key);

  @override
  _PhotoNoState createState() => _PhotoNoState();
}

class _PhotoNoState extends State<PhotoNo> {
  final Image _noImage = Image.asset('images/noImage.png');
  final List<Image?> _pickImages = [null, null, null];

  /// get image widget
  Widget getImage(int index) {
    return Material(
      child: InkWell(
        onTap: () async {
          var file = await ImagePicker().pickImage(source: ImageSource.gallery);
          if (file != null){
            _pickImages[index] = Image.file(File(file.path));
            setState((){});
          }
        },
        child: _pickImages[index] ?? _noImage,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WG2.appBar('不使用狀態管理'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(4),
          }, 
          children: [
            TableRow(children: [WG.getText('圖檔1'), getImage(0)]),
            TableRow(children: [WG.getText('圖檔2'), getImage(1)]),
    ])));    
  }

} //class