import 'package:flutter/material.dart';
import 'package:base_lib/all.dart';
import 'all_com.dart';
import 'derive_a.dart';
import 'derive_b.dart';

class Derive extends StatefulWidget {
  const Derive({ Key? key }) : super(key: key);

  @override
  _DeriveState createState() => _DeriveState();
}

class _DeriveState extends State<Derive> {

  @override
  Widget build(BuildContext context) {
    //if (!_isOk) return Container();

    return Scaffold(
      appBar: WG2.appBar('10.畫面繼承'),
      body: Padding(
        padding: WG2.pagePad,
        child: Column(
          children: [
            WG.elevBtn('A畫面', ()=> ToolUt.openForm(context, DeriveA())),
            WG.elevBtn('B畫面', ()=> ToolUt.openForm(context, DeriveB())),
    ])));
  }

} //class