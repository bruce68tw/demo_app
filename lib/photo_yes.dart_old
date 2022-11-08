import 'dart:io';
import 'package:flutter/material.dart';
import 'package:base_lib/all.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'all_com.dart';

//global provider 
final photoProvider = StateNotifierProvider<PhotoNotifier, PhotoVo>((ref)=> PhotoNotifier());

/// Model(view object) for UI
class PhotoVo {
  PhotoVo({this.image1, this.image2});
  Image? image1;
  Image? image2;

  /// return model for  state !!
  PhotoVo copyWith(int index, Image image){
    return (index == 1)
      ? PhotoVo(image1: image, image2: image2)
      : PhotoVo(image1: image1, image2: image);
  }  
}

/// ViewModel(notifier)
class PhotoNotifier extends StateNotifier<PhotoVo>{
  PhotoNotifier(): super(PhotoVo());

  /// method: update image
  /// state model property is immutable here !!
  void setImage(int index, Image image){
    state = state.copyWith(index, image);
  }
}

/// UI
class PhotoYes extends ConsumerWidget {  
  PhotoYes({ Key? key }) : super(key: key);
  final _noImage = Image.asset('images/noImage.png');

  /// get image widget
  Widget getImage(int index, WidgetRef ref) {
    var model = ref.watch(photoProvider);
    return Material(
      child: InkWell(
        onTap: () async {
          var file = await ImagePicker().pickImage(source: ImageSource.gallery);
          if (file != null){
            ref.read(photoProvider.notifier).setImage(index, Image.file(File(file.path)));
          }
        },
        child: (index == 1)
          ? model.image1 ?? _noImage
          : model.image2 ?? _noImage,
    ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: WG2.appBar('使用狀態管理'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(4),
          }, 
          children: [
            TableRow(children: [WG.getText('圖檔1'), getImage(0, ref)]),
            TableRow(children: [WG.getText('圖檔2'), getImage(1, ref)]),
    ])));    
  }

} //class