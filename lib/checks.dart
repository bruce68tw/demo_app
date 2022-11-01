import 'package:flutter/material.dart';
import 'package:base_lib/all.dart';
import 'all_com.dart';
import 'checks_3.dart';
import 'checks_yes.dart';
import 'checks_no.dart';

class Checks extends StatefulWidget {
  const Checks({ Key? key }) : super(key: key);

  @override
  ChecksState createState() => ChecksState();
}

class ChecksState extends State<Checks> {

  @override
  Widget build(BuildContext context) {
    //if (!_isOk) return Container();

    return Scaffold(
      appBar: WG2.appBar('8b.Riverpod-多筆 CheckBox'),
      body: Padding(
        padding: WG2.pagePad,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WG.elevBtn('使用狀態管理', ()=> ToolUt.openForm(context, const ChecksYes())),
            WG.elevBtn('不使用狀態管理', ()=> ToolUt.openForm(context, const ChecksNo())),
            WG.elevBtn('case 3', ()=> ToolUt.openForm(context, const MyHomePage())),
    ])));
  }

} //class