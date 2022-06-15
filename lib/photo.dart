import 'package:flutter/material.dart';
import 'package:base_lib/all.dart';
import 'all_com.dart';
import 'photo_yes.dart';
import 'photo_no.dart';

class Photo extends StatefulWidget {
  const Photo({ Key? key }) : super(key: key);

  @override
  _PhotoState createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WG2.appBar('狀態管理 Riverpod'),
      body: Padding(
        padding: WG2.pagePad,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WG.textBtn('1.使用狀態管理', ()=> ToolUt.openForm(context, PhotoYes())),
            WG.textBtn('2.不使用狀態管理', ()=> ToolUt.openForm(context, const PhotoNo())),
    ])));
  }

} //class