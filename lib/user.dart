import 'package:flutter/material.dart';
import 'package:base_lib/all.dart';
import 'all_com.dart';

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
  List<IdStrDto>?_depts;
  
  @override
  void initState() {
    //initial variables
    _pagerSrv = PagerSrv(initAsync);
    _read = UserRead();

    super.initState();
    Future.delayed(Duration.zero, ()=> initAsync());
  }

  Future initAsync() async {
    //set _depts if need
    _depts ??= await Xp.getDeptsAsync();

    //read db
    var json = await _read.getPageAsync(_pagerSrv.getDtJson());
    if (json == null) return;

    _pagerDto = PagerDto<UserItemDto>.fromJson(json, UserItemDto.fromJson);
    setState((){_isOk = true;});
  }

  Widget getBody() {
    //add 'New' button first
    var widgets = <Widget>[];
    widgets.add(Align(
      alignment: Alignment.topLeft,
      child: WG.linkBtn('新增', ()=> onEdit())
    ));
    widgets.add(WG.divider());

    //check if rows empty
    var dtos = _pagerDto.dtos;
    if (dtos.isEmpty){
      widgets.add(WG.emptyMsg());
    } else {
      //add rows
      for (var dto in dtos) {
        widgets.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                WG.linkBtn('修改', ()=> onEdit(dto.sn)),
                WG.linkBtn('刪除', ()=> onDelete(dto.sn)),
            ]),
            WG.text(dto.account),
            WG.text(dto.name),
            WG.text(dto.deptName),
          ],
        ));
        widgets.add(WG.divider());
      }

      //add pager
      widgets.add(_pagerSrv.getWidget(_pagerDto));
    }

    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: widgets,
    );
  }

  
  onEdit([int? sn]){
    //ToolUt.openForm(context, UserEdit(sn:sn, depts:_depts!));
    //setState((){});
    //ToolUt.openForm(context, ProjectEdit(id: id, wcId: wcId, isEdit: isEdit));
  }

  onDelete(int sn){
    //setState((){});
    //ToolUt.openForm(context, ProjectEdit(id: id, wcId: wcId, isEdit: isEdit));
  }

  @override
  Widget build(BuildContext context) {
    if (!_isOk) return Container();

    return Scaffold(
      appBar: WG.appBar('用戶維護'),
      body: Padding(
        padding: WG.pagePad,
        child: getBody()
    ));
  }
  
} //class