import 'package:flutter/material.dart';
import 'package:base_lib/all.dart';
import 'all_com.dart';
import 'exchange_b.dart';

class ExchangeA extends StatefulWidget {
  const ExchangeA({ Key? key }) : super(key: key);

  @override
  _ExchangeAState createState() => _ExchangeAState();
}

class _ExchangeAState extends State<ExchangeA> {

  void fnCallback(){
    ToolUt.msg(context, 'Called by B畫面 !');
  }

  @override
  Widget build(BuildContext context) {
    //if (!_isOk) return Container();

    return Scaffold(
      appBar: WG2.appBar('A畫面'),
      body: Padding(
        padding: WG2.pagePad,
        child: Column(
          children: [
            WG.elevBtn('開啟B畫面', ()=> ToolUt.openForm(context, ExchangeB(fnCallback: fnCallback ))),
    ])));
  }

} //class