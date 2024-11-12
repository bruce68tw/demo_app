// ignore_for_file: use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:flutter/material.dart';
import 'package:base_lib/all.dart';
import 'package:image_picker/image_picker.dart';
import 'all_com.dart';

class MyHttp extends StatefulWidget {
  const MyHttp({ Key? key }) : super(key: key);

  @override
  MyHttpState createState() => MyHttpState();
}

class MyHttpState extends State<MyHttp> {
  final Image _noImage = Image.asset('images/noImage.png');

  String _msgKeyStr = '';
  String _msgJsonJson = '';
  String _msgUploadZip = '';
  //String _msgDownloadZip = '';
  Image? _image;

  /// get image widget
  Widget getImage() {
    return Material(
      child: InkWell(
        child: (_image == null) ? _noImage : _image,
    ));
  }

  /// 1.key/string
  Future<void> onKeyStrAsync() async {
    var data = {'str1':'s1','str2':'s2'};
    await HttpUt.getStrA(context, "MyHttp/KeyStr", false, data, (str){
      setState(()=> _msgKeyStr = str);
    });
  }

  /// 2.json/json
  Future<void> onJsonJsonAsync() async {
    var data = {'Id':'id1','Str':'s1'};
    await HttpUt.getJsonA(context, "MyHttp/JsonJson", true, data, (json){
      var msg = 'by server: Id=${json['Id']}, Str=${json['Str']}';
      setState(()=> _msgJsonJson = msg);
    });
  }

  /// 3.get image
  Future<void> onGetImageAsync() async {
    var data = {'str':'s1'};
    var image = await HttpUt.getImageA(context, "MyHttp/GetImage", data);
    if (image != null){
      setState(()=> _image = image);
    }
  }

  /// 4.upload zip
  Future<void> onUploadZipAsync() async {
    //pick image
    var file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) return;

    //create zip file
    var zipFile = FunUt.dirTemp + 'upload.zip';
    var encoder = ZipFileEncoder();
    encoder.create(zipFile);
    encoder.addFile(File(file.path), file.name);
    encoder.close();

    var data = {'str':'s1'};
    await HttpUt.uploadZipA(context, "MyHttp/UploadZip", File(zipFile), data, false, (str){
      setState(()=> _msgUploadZip = str);
    });
  }

  /*
  Future<void> onDownloadZipAsync() async {
    var saveDir = '';
    await HttpUt.saveUnzipAsync(context, "MyHttp/DownloadZip", {'str':'string 1'}, saveDir);
    setState(()=> _msgDownloadZip = 'Download and Unzip to folder: $saveDir');
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WG2.appBar('HTTP 呼叫'),
      body: SingleChildScrollView(
        child: Padding(
          padding: WG2.pagePad,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WG.elevBtn('1.key/string', ()=> onKeyStrAsync()),
              WG.labelText('結果: ', _msgKeyStr),
              WG.elevBtn('2.json/json', ()=> onJsonJsonAsync()),
              WG.labelText('結果: ', _msgJsonJson),
              WG.elevBtn('3.get image', ()=> onGetImageAsync()),
              getImage(),
              WG.elevBtn('4.upload zip', ()=> onUploadZipAsync()),
              WG.labelText('結果: ', _msgUploadZip),
              //WG.elevBtn('5.download & unzip', ()=> onDownloadZipAsync()),
              //WG.labelText('結果: ', _msgDownloadZip),
      ]))));
  }

} //class