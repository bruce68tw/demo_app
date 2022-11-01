import 'package:flutter/material.dart';
import 'package:base_lib/all.dart';
import 'all_com.dart';
import 'models/derive_dto.dart';

class Derive0 extends StatefulWidget {
  const Derive0({ Key? key, required this.dto }) : super(key: key);
  final DeriveDto dto;

  @override
  Derive0State createState() => Derive0State();
}

//不能宣告為抽象類別(無法實例化)
class Derive0State<T extends Derive0> extends State<T> {
  late DeriveDto _dto;

  //在子類別覆寫, 用途上類似抽象方法
  String fnTest()=> '';   

  @override
  void initState() {
    _dto = widget.dto;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WG2.appBar(_dto.title),
      body: Padding(
        padding: WG2.pagePad,
        child: Column(
          children: [
            WG.labelText('函數結果：', fnTest()),
    ])));
  }

} //class