import 'package:flutter/material.dart';
import 'package:base_lib/all.dart';
import 'all_com.dart';
import 'tables/all.dart';

class UserEdit2 extends StatefulWidget {
  const UserEdit2({Key? key}) : super(key: key);

  @override
  _UserEdit2State createState() => _UserEdit2State();
}

class _UserEdit2State extends State<UserEdit2> {  
  bool _isOk = false;       //state variables

  //for edit form
  final UserTab _row = UserTab();

  //input fields & variables
  List<IdStrDto>?_depts;
  final _formKey = GlobalKey<FormState>();
  final accountCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final birthCtrl = TextEditingController();
  final noteCtrl = TextEditingController();

  @override
  void initState() {    
    //initial variables

    super.initState();
    Future.delayed(Duration.zero, ()=> showAsync());
  }

  Future showAsync() async {
    //set _depts if need
    _depts ??= await Xp.getDeptsAsync();

    //rowToForm();
    setState((){_isOk = true;});
  }

  /*
  //table row into form field
  rowToForm(){

    _isOk = true;
    setState((){});
  }
  */

  @override
  Widget build(BuildContext context) {
    if (!_isOk) return Container();

    return Scaffold(
      appBar: WG2.appBar('傳統 style 輸入欄位'),
      body: SingleChildScrollView(
        padding: WG2.pagePad,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(5),
                }, 
                children: [
                  WG.tableRow('帳號', WG.itext('', accountCtrl, required: true)),
                  WG.tableRow('姓名', WG.itext('', nameCtrl, required: true)),
                  WG.tableRow('部門', WG.iselect('', _row.dept_sn, _depts!, (value)=>
                    setState(()=> _row.dept_sn = int.parse(value)), required: true)),
                  WG.tableRow('生日', WG.idate(context, '', birthCtrl, (value)=> setState((){}), 
                    oneYearRange: false)),
                  WG.tableRow('Email', WG.itext('', emailCtrl)),
                  WG.tableRow('資料狀態', WG.icheck('', (_row.status == 1), (value)=> 
                    setState(()=> _row.status = value ? 1 : 0))),
                  WG.tableRow('備註', WG.itext('', noteCtrl, maxLines:5)),
              ]),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WG.textBtn('儲存', (){}),
                  WG.textBtn('取消', (){}),
              ]),
    ]))));
  }
  
} //class