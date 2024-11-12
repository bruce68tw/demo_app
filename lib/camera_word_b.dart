import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:base_lib/all.dart';
import 'package:flutter/rendering.dart';
import 'camera_word_a.dart';
import 'services/all.dart';

class CameraWordB extends StatefulWidget {
  const CameraWordB({ Key? key, required this.imagePath, required this.fnAfterTakePhoto }) : super(key: key);
  final String imagePath;
  final Function fnAfterTakePhoto;

  @override
  _CameraWordBState createState() => _CameraWordBState();
}

class _CameraWordBState extends State<CameraWordB> {
  final _repaintKey = GlobalKey();

  //onclick save
  Future onSaveAsync() async{
    //固定寫法
    var boundary = _repaintKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    var image = await boundary?.toImage();
    var byteData = await image?.toByteData(format: ImageByteFormat.png);  //png only
    var bytes = byteData?.buffer.asUint8List();

    if (bytes != null) {
      var imageFile = await File(Xp.tempPhoto).create();
      await imageFile.writeAsBytes(bytes);

      //callback function: close form & show msg
      widget.fnAfterTakePhoto(context);
    }
  }

  //相片文字 style
  static Text cameraText(String text) {
    return Text(text, 
      style: TextStyle(
        fontSize: 30,
        color: Colors.red.withOpacity(0.5),
    ));
  }

  @override
  Widget build(BuildContext context) {
    //if (!_isOk) return Container();

    //第一層stack: 區分圖檔(含文字)和功能按鈕
    //第二層stack: 圖檔內容
    return Stack(
      children: [
        //圖檔內容
        RepaintBoundary(
          key: _repaintKey,
          //Material for remove text underline
          child: Material(
            child:
          Stack(
            //set fit type, or will be cut !!
            fit: StackFit.expand,
            children: [
              ImageUt.reload(widget.imagePath),
              Center(
                child: cameraText('內部資料，請勿外流')
              )
              /*
              Align(
                alignment: FractionalOffset.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom:10, left:10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      cameraText('第1行文字ABC'),
                      cameraText('第2行文字DEF')
              ])))
              */
        ]))),

        //功能按鈕
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom:10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WG.elevBtn('儲存', ()=> onSaveAsync()),
                WG.hGap(),
                WG.elevBtn('重新拍照', () async {
                  ToolUt.closeForm(context);
                  ToolUt.openForm(context, CameraWordA(fnAfterTakePhoto: widget.fnAfterTakePhoto));
        })])))
    ]);
  }

} //class