import 'package:flutter/material.dart';
import 'package:base_lib/all.dart';
import 'all_com.dart';
import 'tables/all.dart';

class Dept extends StatefulWidget {
  const Dept({Key? key}) : super(key: key);

  @override
  _DeptState createState() => _DeptState();
}

class _DeptState extends State<Dept> {  
  bool _isOk = false;       //state variables
  late PagerSrv _pagerSrv;  //pager service
  late PagerDto<DeptItemDto> _pagerDto;
  late DeptRead _read;
  
  //for edit form
  bool _isNew = true;     //新增
  DeptTab _row = DeptTab();
  //
  //input fields & variables
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();

  @override
  void initState() {
    //initial variables
    _pagerSrv = PagerSrv(showAsync);
    _read = DeptRead();

    super.initState();
    Future.delayed(Duration.zero, ()=> showAsync());
  }

  Future showAsync([String? msg]) async {
    //read db
    var json = await _read.getPageAsync(_pagerSrv.getDtJson());
    if (json == null) return;

    _pagerDto = PagerDto<DeptItemDto>.fromJson(json, DeptItemDto.fromJson);
    setState((){_isOk = true;});

    if (msg != null){
      ToolUt.msg(context, msg);
    }
  }

  //table row to form field
  rowToForm(){
    nameCtrl.text = _row.name;    
    setState((){_isOk = true;});
  }

  formToRow(){
    _row.name = nameCtrl.text;
  }

  //open edit dialog
  Future onEditAsync([int? sn]) async {
    //set _row
    //var status = true;
    _isNew = (sn == null);
    _row = _isNew
      ? DeptTab()
      : DeptTab.fromMap(await DeptTab.getMapAsync(sn!));
    rowToForm();

    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      pageBuilder: (context2, animation, secondaryAnimation) {
        var title = '部門維護-' + (_isNew ? '新增' : '修改');
        return Scaffold(
          appBar: WG2.appBar(title),
          body: SingleChildScrollView(
            padding: WG2.pagePad,
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      WG.itext('名稱', nameCtrl, required: true),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          WG.textBtn('儲存', ()=> onSaveAsync(context2)),
                          WG.textBtn('取消', ()=> ToolUt.closePopup(context2)),
                      ]),
        ]))])));
      
    });
  }

  Future onDeleteAsync(int sn) async {
    ToolUt.ans(context, '是否確定刪除這筆資料?', () async {
      await DeptTab.deleteAsync(sn);
      await showAsync('刪除完成。');
    });
  }

  Future onSaveAsync(BuildContext context2) async{
    if (!_formKey.currentState!.validate()) return;

    formToRow();
    var ok = _isNew
      ? await DeptTab.insertAsync(_row)
      : await DeptTab.updateAsync(_row);

    //close edit dialog
    ToolUt.closePopup(context2);

    //show form and msg
    await showAsync('儲存完成。');
  }

  Widget getBody() {
    //add 'New' button first
    var widgets = <Widget>[];
    widgets.add(Align(
      alignment: Alignment.topLeft,
      child: WG.textBtn('新增', ()=> onEditAsync())
    ));
    widgets.add(WG2.divider());

    //check if rows empty
    var dtos = _pagerDto.dtos;
    if (dtos.isEmpty){
      widgets.add(WG2.emptyMsg());
    } else {
      //add rows
      for (var dto in dtos) {
        widgets.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                WG.textBtn('修改', ()=> onEditAsync(dto.sn)),
                WG.textBtn('刪除', ()=> onDeleteAsync(dto.sn)),
            ]),
            WG.labelText('序號 : ', dto.sn.toString()),
            WG.labelText('名稱 : ', dto.name),
          ],
        ));
        widgets.add(WG2.divider());
      }

      //add pager
      widgets.add(_pagerSrv.getWidgetByDto(_pagerDto));
    }

    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: widgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isOk) return Container();

    return Scaffold(
      appBar: WG2.appBar('部門維護'),
      body: Padding(
        padding: WG2.pagePad,
        child: getBody()
    ));
  }
  
} //class