import 'package:flutter/material.dart';
import 'package:base_lib/all.dart';
import 'xp.dart';

/// project widget(static)
class WG2 {

  static const pagePad = EdgeInsets.all(10);

  ///get appBar widget
  ///@title title string
  static AppBar appBar(String title) {
    return AppBar(
      toolbarHeight: 42,
      title: Text(title, style: titleLabelStyle())
    );
  }

  static TextStyle titleLabelStyle() {
    return const TextStyle(fontSize: Xp.titleFontSize);
  }

  /// center ElevatedButton
  static Widget centerElevBtn(String text, [VoidCallback? fnOnClick]) {
    return Center(child: WG.elevBtn(text, fnOnClick));
  }

  ///return empty message
  static Widget emptyMsg(){
    return WG.emptyMsg('目前無任何資料。', Xp.fontSize, Colors.red);
  }

  static Divider divider(){
    return WG.divider(15);
  }

  //vertical gap
  static Widget vGap([double value = 10]){
    return SizedBox(height: value);
  }

  //horizontal gap
  static Widget hGap([double value = 5]){
    return SizedBox(width: value);
  }

} //class
