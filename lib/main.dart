import 'package:flutter/material.dart';
import 'package:base_lib/all.dart';
import 'exchange_a.dart';
import 'services/all.dart';
import 'user.dart';
import 'dept.dart';
import 'user_edit2.dart';

void main()=> runApp(const MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainForm(),
      theme: ThemeData(
        textTheme: const TextTheme(
          button: TextStyle(fontSize:16),
        ),
      ),      
    );
  }
} //MyApp

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

    Future.delayed(Duration.zero, ()=> initAsync());
  }

  Future initAsync() async {
    Xp.initDb();    
    setState((){_isOk = true;});
  }

  /*
  //onclick item
  void onItem(int index) {
    setState(()=> _index = index);
  }
  */

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
        ]
      ),
    );
  }

} //class