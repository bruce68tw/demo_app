import 'package:flutter/material.dart';
import 'package:base_lib/all.dart';
import 'package:provider/provider.dart';

class ChecksYesVo with ChangeNotifier {  
  List<bool> checks = [];

  //constructor
  ChecksYesVo(this.checks);

  /*
  void init(List<bool> status2){
    checks = status2;
    notifyListeners();
  }
  */
  
  void setCheck(int index, bool value){
    checks[index] = value;
    notifyListeners();
  }
}

class ChecksYes extends StatelessWidget {
  const ChecksYes({ Key? key }) : super(key: key);

  /// initial
  ChecksYesVo initVo(){
    return ChecksYesVo(List.filled(100, false));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChecksYesVo>(
      create: (_)=> initVo(),
      child: Scaffold(
        appBar: AppBar(),
        body: Consumer<ChecksYesVo>(
          builder: (a1, vo, a2)=> ListView.builder(
            itemCount: vo.checks.length,
            itemBuilder: (_, i)=> 
              WG.icheck('item-$i', vo.checks[i], (value)=> vo.setCheck(i, value))
    ))));
  }
}
