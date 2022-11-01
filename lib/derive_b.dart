import 'package:flutter/material.dart';
import 'derive0.dart';
import 'models/derive_dto.dart';

class DeriveB extends Derive0 {
  DeriveB({ Key? key }) : super(key: key, dto:DeriveDto(
    title: 'B畫面',
  ));

  @override
  _DeriveBState createState() => _DeriveBState();
}

class _DeriveBState extends Derive0State<DeriveB> {

  @override
  String fnTest(){
    return 'fnTest-B';
  }

} //class