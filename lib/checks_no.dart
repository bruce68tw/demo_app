import 'package:flutter/material.dart';
import 'package:base_lib/all.dart';
import 'all_com.dart';

class ChecksNo extends StatefulWidget {
  const ChecksNo({ Key? key }) : super(key: key);

  @override
  ChecksNoState createState() => ChecksNoState();
}

class ChecksNoState extends State<ChecksNo> {
  //final int _loops = 100;
  final List<bool> _checks = List.filled(100, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WG2.appBar('8b.Riverpod-多筆 CheckBox(不使用)'),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          for(var i=0; i<_checks.length; i++)
            WG.icheck('item-$i', _checks[i], (value)=>setState(()=> _checks[i] = value))
        ]
    ));    
  }

} //class