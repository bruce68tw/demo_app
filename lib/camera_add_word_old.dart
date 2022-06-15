import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as image2;
import 'package:base_lib/all.dart';
import 'all_com.dart';

class CameraAddWord extends StatefulWidget {
  const CameraAddWord({ Key? key }) : super(key: key);

  @override
  _CameraAddWordState createState() => _CameraAddWordState();
}

class _CameraAddWordState extends State<CameraAddWord> {

  //constant
  final Image _noPhotoImage = Image.asset('images/noImage.png');
  final String _tempPhoto = FunUt.dirApp + 'temp.jpg';

  final _repaintKey = GlobalKey();

  //input fields
  final wordCtrl = TextEditingController(text:'圖檔底部文字');
  
  bool _isPick = false;   //是否選取圖檔
  bool _downSize = true;  //縮小圖檔大小
  Image? _photo;          //加上文字後的圖檔

  /// 從相簿選擇
  Future onPickAsync() async {
    var file = await ImagePicker().pickImage(
      source: ImageSource.gallery
    );
    if (file == null) return;

    //add word
    ToolUt.openWait(context);
    await photoAddTextAsync(file.path);
    ToolUt.closeWait(context);
    setState(()=> _isPick = true);
  }

  Future photoAddTextAsync(String filePath) async {
  }  

  /// 圖檔加上文字同時寫入手機disk
  Future zz_photoAddTextAsync(String filePath) async {
    //load image
    var ext = FileUt.getExt(filePath);
    var image = await ImageUt.decodeAsync(filePath, ext);
    var word = wordCtrl.text;
    if (word == '') word = '[輸入文字]';

    // draw text using 24pt arial font
    var x = 20;
    var diff = 50;
    var color = 0xff0000ff;   //red
    var height = image!.height - 20;
    //var font = image2.arial_48;
    var font = image2.BitmapFont.fromFnt('Font1', image);
    //var font = image2.BitmapFont.fromZip(await getAsset('newFonts/${controller.fontFamilyy}.zip'));

    //寫入文字, 由下到上
    var pos = 1;
    image2.drawString(image, font, x, height - diff * pos, word, color: color);
    pos++;
        
    // save image to disk
    File(_tempPhoto).writeAsBytesSync(ImageUt.encode(image, ext)!);
    _photo = ImageUt.reload(_tempPhoto);
  }

  @override
  Widget build(BuildContext context) {
    //if (!_isOk) return Container();

    return RepaintBoundary(
      key: _repaintKey,
      child: Scaffold(
        appBar: WG2.appBar('照相加上中文字'),
        body: Padding(
          padding: WG2.pagePad,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(5),
                  }, 
                  children: [
                    WG.itext2('加上文字', wordCtrl),
                    WG.tableRow('', WG.icheck('縮小圖檔', _downSize, (value){
                      _downSize = value;
                      setState((){});
                    })),
                    WG.tableRow('', WG.elevBtn('選取圖檔', ()=> onPickAsync())),
                    WG.tableRow('顯示結果', Container())
                ]),
                InteractiveViewer(
                  panEnabled: true,
                  boundaryMargin: WG.gap(0),
                  minScale: 1,
                  maxScale: 8, 
                  child: _isPick ? _photo! : _noPhotoImage,
                )
    ])))));
  }

} //class