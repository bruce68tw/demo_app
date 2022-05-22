import 'package:base_lib/all.dart';
import 'package:flutter/material.dart';
import 'all_com.dart';
import 'tables/all.dart';

class DeptEdit extends StatefulWidget {
  const DeptEdit({Key? key, this.sn}) : super(key: key);
  final int? sn;
  
  @override
  _DeptEditState createState() => _DeptEditState();
}

class _DeptEditState extends State<DeptEdit> {  
  bool _isOk = false;
  late bool _isNew;     //新增
  late DeptTab _row;

  //input fields & variables
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();

  @override
  void initState() {    
    //initial variables
    _isNew = (widget.sn == null);

    super.initState();
    Future.delayed(Duration.zero, ()=> initAsync());
  }

  Future initAsync() async {
    //set _row
    if (_isNew){
      _row = DeptTab();
      rowToForm();
    } else {
      var json = await UserTab.getMapAsync(widget.sn!);
      _row = DeptTab.fromMap(json!);
      rowToForm();
    }
  }

  //table row into form field
  rowToForm(){
    nameCtrl.text = _row.name;    
    setState((){_isOk = true;});
  }

  formToRow(){
    _row.name = nameCtrl.text;
  }

  Future onSaveAsync() async{
    if (!_formKey.currentState!.validate()) return;

    formToRow();
    if (_isNew){
      await DeptTab.insertAsync(_row);
    } else {
      await DeptTab.updateAsync(_row);
    }

    ToolUt.msg(context, '儲存完成。', ()=> ToolUt.closePopup(context));
  }

  @override
  Widget build(BuildContext context) {
    if (!_isOk) return Container();

    var title = '部門維護-' + (_isNew ? '新增' : '修改');
    return Scaffold(
      appBar: WG.appBar(title),
      body: SingleChildScrollView(
        padding: WG.pagePad,
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  WG.itext('名稱', nameCtrl, true),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WG.linkBtn('儲存', ()=> onSaveAsync()),
                      WG.linkBtn('取消', (){}),
                  ]),
    ]))])));
  }
  
} //class