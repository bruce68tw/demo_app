import 'package:flutter/material.dart';
import 'package:base_lib/all.dart';
import 'all_com.dart';

class ExchangeB extends StatefulWidget {
  const ExchangeB({ Key? key, required this.fnCallback }) : super(key: key);
  final Function fnCallback;

  @override
  _ExchangeBState createState() => _ExchangeBState();
}

class _ExchangeBState extends State<ExchangeB> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WG2.appBar('B畫面'),
      body: Padding(
        padding: WG2.pagePad,
        child: Column(
          children: [
            WG.elevBtn('呼叫A畫面', (){
              ToolUt.closePopup(context);
              widget.fnCallback();
    })])));
  }

} //class