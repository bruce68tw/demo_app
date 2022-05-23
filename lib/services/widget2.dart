import 'package:flutter/material.dart';
import 'package:base_lib/all.dart';

/// project widget(static)
class WG2 {

  static const pagePad = EdgeInsets.all(20);

  ///get appBar widget
  ///@title title string
  static AppBar appBar(String title) {
    return AppBar(
      toolbarHeight: 42,
      title: Text(title, style: const TextStyle(fontSize:16))
    );
  }

  /*
  static Text text(String text, [bool status = true]) {
    var color = status ? CssUt.textColorOk : CssUt.textColorSkip;
    return WidgetUt.text(CssUt.textFontSize, text, color);
  }

  static Text label(String label) {
    return WidgetUt.text(CssUt.labelFontSize, label, CssUt.labelColor);
  }
  
  ///display label & text
  static Column labelText(String label, String text, [Color? color]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WG.label(label),
        WG.text(text),
        WG.divider(),
    ]);
  }

  ///input field style
  static TextStyle textStyle([bool status = true]) {    
    return TextStyle(
      fontSize: CssUt.textFontSize,
      color: status ? Colors.black : Colors.grey,
    );
  }

  //return label
  static InputDecoration inputDecore(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        fontSize: 16,
        color: Colors.grey,
        height: 0.8,
      ),
    );
  }

  static Widget itext(String label, TextEditingController ctrl,  
    {bool required = false, Function? fnValid, Function? fnOnChange}) {
    return WidgetUt.itext(ctrl, WG.textStyle(), WG.inputDecore(label), 
      required, 1, fnValid, fnOnChange);
  }

  static Widget itextarea(String label, TextEditingController ctrl, 
    {bool required = false, Function? fnValid, Function? fnOnChange}) {
    return WidgetUt.itext(ctrl, WG.textStyle(), WG.inputDecore(label), 
      required, 5, fnValid, fnOnChange);
  }

  static Widget iselect(String label, dynamic value, List<IdStrDto> rows,
    {bool required = false, Function? fnValid, Function? fnOnChange}) {
    return WidgetUt.iselect(WG.label(label), value, rows,
      required, fnValid, fnOnChange);
  }

  static Widget icheck(String label, bool status, Function fnOnChange) {
    return WidgetUt.icheck(WG.text(label), status, fnOnChange);
  }

  static Widget idate(BuildContext context, String label, TextEditingController ctrl, 
    Function fnOnChange, [bool required = false, bool oneYearRange = true]){

    return WidgetUt.idate(context, ctrl, WG.textStyle(), 
      WG.inputDecore(label), fnOnChange, required, oneYearRange);
  }
  */

  static Widget _tailCenter(Widget widget) {
    return Container(
      alignment: Alignment.center,
      margin: WG.gap(10),
      child: widget,
    );
  }

  /*
  static Widget linkBtn(String text, [VoidCallback? fnOnClick, bool isTail = false]) {
    var btn = WidgetUt.linkBtn(text, FunUt.fontSize, fnOnClick);
    return isTail ? _tailCenter(btn) : btn;
  }

  static Widget textBtn(String text, [VoidCallback? fnOnClick, bool isTail = false]) {
    var btn = WidgetUt.textBtn(text, FunUt.fontSize, fnOnClick);
    return isTail ? _tailCenter(btn) : btn;
  }
  */

  /*
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
  */

  ///return empty message
  static Widget emptyMsg(){
    return WG.emptyMsg('目前無任何資料。', 18, Colors.red);
  }

  static Divider divider(){
    return WG.divider(15);
  }

} //class
