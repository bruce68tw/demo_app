import 'package:flutter/material.dart';
import 'package:base_lib/all.dart';
import 'all_com.dart';
import 'tables/all.dart';

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {  
  bool _isOk = false;       //state variables
  late PagerSrv _pagerSrv;  //pager service
  late PagerDto<UserItemDto> _pagerDto;
  late UserRead _read;
  
  //for edit form
  bool _isNew = false;     //新增
  UserTab _row = UserTab();

  //input fields & variables
  //int? _deptSn;
  List<IdStrDto>?_depts;
  final _formKey = GlobalKey<FormState>();
  final accountCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final birthCtrl = TextEditingController();
  final noteCtrl = TextEditingController();
  //bool _status = false;

  @override
  void initState() {
    //initial variables
    _pagerSrv = PagerSrv(showAsync);
    _read = UserRead();

    super.initState();
    Future.delayed(Duration.zero, ()=> showAsync());
  }

  Future showAsync([String? msg]) async {
    //set _depts if need
    _depts ??= await Xp.getDeptsAsync();

    //read db
    var json = await _read.getPageAsync(_pagerSrv.getDtJson());
    if (json == null) return;

    _pagerDto = PagerDto<UserItemDto>.fromJson(json, UserItemDto.fromJson);
    setState((){_isOk = true;});

    if (msg != null){
      ToolUt.msg(context, msg);
    }
  }

  //table row into form field
  rowToForm(){
    accountCtrl.text = _row.account;
    nameCtrl.text = _row.name;
    emailCtrl.text = _row.email ?? '';
    birthCtrl.text = _row.birth ?? '';
    noteCtrl.text = _row.note ?? '';
    
    setState((){_isOk = true;});
  }

  formToRow(){
    _row.account = accountCtrl.text;
    _row.name = nameCtrl.text;
    _row.email = emailCtrl.text;
    _row.birth = birthCtrl.text;
    _row.note = noteCtrl.text;
  }
  
  //open edit dialog
  Future onEditAsync([int? sn]) async {
    //set _row
    _isNew = (sn == null);
    _row = _isNew
      ? UserTab(status: 1)
      : UserTab.fromMap(await UserTab.getMapAsync(sn!));
    rowToForm();

    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      pageBuilder: (context2, animation, secondaryAnimation) {
        //使用 StatefulBuilder 才能更新 checkbox 狀態
        return StatefulBuilder(
          builder: (context3, setState) {
            var title = '用戶維護-' + (_isNew ? '新增' : '修改');            
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
                          WG.itext('帳號', accountCtrl, required: true),
                          WG.itext('姓名', nameCtrl, required: true),
                          WG.iselect('部門', _row.dept_sn, _depts!, (value)=>
                            setState(()=> _row.dept_sn = int.parse(value)), required: true),
                          WG.idate(context3, '生日', birthCtrl, (value)=> setState((){}), 
                            oneYearRange: false),
                          WG.itext('Email', emailCtrl),
                          WG.icheck('資料狀態', (_row.status == 1), (value)=> 
                            setState(()=> _row.status = value ? 1 : 0)),
                          WG.itext('備註', noteCtrl, maxLines:5),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              WG.textBtn('儲存', ()=> onSaveAsync(context2)),
                              WG.textBtn('取消', ()=> ToolUt.closeForm(context2)),
                          ]),
    ]))])));});});
  }

  Future onDeleteAsync(int sn) async {
    ToolUt.ans(context, '是否確定刪除這筆資料?', () async {
      await UserTab.deleteAsync(sn);
      await showAsync('刪除完成。');
    });
  }

  Future onSaveAsync(BuildContext context2) async {
    if (!_formKey.currentState!.validate()) return;

    formToRow();
    var ok = _isNew
      ? await UserTab.insertAsync(_row)
      : await UserTab.updateAsync(_row);

    //close edit dialog
    ToolUt.closeForm(context2);

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
            WG.labelText('帳號 : ', dto.account),
            WG.labelText('姓名 : ', dto.name),
            WG.labelText('部門 : ', dto.deptName),
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
      appBar: WG2.appBar('用戶維護'),
      body: Padding(
        padding: WG2.pagePad,
        child: getBody()
    ));
  }
  
} //class