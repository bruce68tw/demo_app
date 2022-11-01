import 'package:flutter/material.dart';
import 'derive0.dart';
import 'models/derive_dto.dart';

class DeriveA extends Derive0 {
  DeriveA({ Key? key }) : super(key: key, dto:DeriveDto(
    title: 'A畫面',
  ));

  @override
  _DeriveAState createState() => _DeriveAState();
}

class _DeriveAState extends Derive0State<DeriveA> {

  @override
  String fnTest(){
    return 'fnTest-A';
  }

} //class