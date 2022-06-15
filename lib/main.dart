import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:base_lib/all.dart';
import 'services/all.dart';
import 'exchange_a.dart';
import 'camera_word_a.dart';
import 'photo.dart';
//import 'test1.dart';
import 'user.dart';
import 'dept.dart';
import 'user_edit2.dart';

//final helloWorldProvider = Provider((_) => 'Hello world');

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

/// This Widget is the main application widget.
class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainForm(),
      theme: ThemeData(
        textTheme: const TextTheme(
          button: TextStyle(fontSize:Xp.fontSize),
        ),
    ));
  }
} //MainApp

class MainForm extends StatefulWidget {
  const MainForm({Key? key}) : super(key: key);

  @override
  _MainFormState createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {
  bool _isOk = false;

  @override
  void initState() {
    //call before rebuild()
    super.initState();

    Future.delayed(Duration.zero, ()=> showAsync());
  }

  //callback after CameraWordB take photo
  void afterTakePhoto(BuildContext context2){
    ToolUt.closeForm(context2);
    ToolUt.msg(context, '儲存完成。');    
  }

  Future showAsync() async {
    //set global
    FunUt.fontSize = Xp.fontSize;
    FunUt.init(Xp.isHttps, Xp.apiServer);

    Xp.initDb();    
    setState(()=> _isOk = true);
  }

  //show gps
  Future showGpsAsync() async {
    ToolUt.openWait(context);
    LogTimeUt.init();
    var gps = await DeviceUt.getGpsAsync();
    var miniSec = LogTimeUt.getMiniSec();
    ToolUt.closeWait(context);
    ToolUt.msg(context, '''
經度: ${gps.longitude}
緯度: ${gps.latitude}
使用時間: $miniSec 毫秒''');
  }

  @override
  Widget build(BuildContext context) {
    //check status
    if (!_isOk) return Container();

    return Scaffold(
      appBar: WG2.appBar('Flutter Demo'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WG.textBtn('1.Dept CRUD', ()=> ToolUt.openForm(context, const Dept())),
          WG.textBtn('2.User CRUD', ()=> ToolUt.openForm(context, const User())),
          WG.textBtn('3.檢視 sqlite 資料表', ()=> 
            ToolUt.openForm(context, const Sqlite())),
          WG.textBtn('4.傳統 style 輸入欄位', ()=> 
            ToolUt.openForm(context, const UserEdit2())),
          WG.textBtn('5.資料交換 by Callback Function', ()=> 
            ToolUt.openForm(context, const ExchangeA())),
          WG.textBtn('6.讀取經緯度', ()=> showGpsAsync()),
          WG.textBtn('7.照相加上文字', ()=> 
            ToolUt.openForm(context, CameraWordA(fnAfterTakePhoto: afterTakePhoto))),
          WG.textBtn('8.狀態管理 Riverpod', ()=> 
            ToolUt.openForm(context, const Photo())),
    ]));
  }

} //class  