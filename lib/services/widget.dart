//import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:base_lib/all.dart';

//import 'xp.dart';

/// static class(widget)
class WG {

  static const pagePad = EdgeInsets.all(20);

  ///get appBar widget
  ///@title title string
  static AppBar appBar(String title) {
    return AppBar(
      toolbarHeight: 42,
      title: WidgetUt.text(15, title, Colors.white),
    );
  }

  static Text text(String text) {
    return WidgetUt.text(FunUt.fontSize, text, Colors.black);
  }
  static Text label(String label) {
    return WidgetUt.text(FunUt.fontSize, label, Colors.grey);
  }

  ///display label & text
  static Column labelText(String label, String text, [Color? color]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WG.label(label),
        WG.text(text),
        WG.divider(),
      ]
    );
  }

  ///input field style
  static TextStyle inputStyle([bool status = true]) {    
    return TextStyle(
      fontSize: FunUt.fontSize,
      color: status ? Colors.black : Colors.grey,
    );
  }

  //return label
  static InputDecoration inputLabel(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        fontSize: 16,
        color: Colors.grey,
        height: 0.8,
      ),
    );
  }

  static Widget itext(String label, TextEditingController ctrl, bool required, 
    {Function? fnValid, Function? fnOnChange}) {
    return InputUt.itext(ctrl, WG.inputStyle(), WG.inputLabel(label), 
      required, fnValid, fnOnChange);
  }

  static Widget iselect(String label, dynamic value, 
    List<IdStrDto> rows, bool required, 
    {Function? fnValid, Function? fnOnChange}) {
    return InputUt.iselect(WG.label(label), value, rows,
      required, fnValid, fnOnChange);
  }

  static Widget linkBtn(String text, [VoidCallback? fnOnClick]) {
    return WidgetUt.linkBtn(text, FunUt.fontSize, fnOnClick);
  }

  static Widget textBtn(String text, [VoidCallback? fnOnClick]) {
    return WidgetUt.textBtn(text, FunUt.fontSize, fnOnClick);
  }

  ///one button at form end/tail
  static Container tailBtn(String text, [VoidCallback? fnOnClick, double? top]) {
    var status = (fnOnClick != null);
    return Container(
      alignment: Alignment.center,
      margin: (top == null) 
        ? WidgetUt.gap(15) : EdgeInsets.only(top:top, right:15, bottom:15, left:15),
      child: ElevatedButton(          
        child: WidgetUt.text(16, text),
        onPressed: status ? fnOnClick : null,
      ));
  }

  ///return empty message
  static Widget emptyMsg(){
    return WidgetUt.emptyMsg('目前無任何資料。', FunUt.fontSize, Colors.red);
  }

  static Divider divider(){
    return WidgetUt.divider(15);
  }

} //class
