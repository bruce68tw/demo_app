import 'package:flutter/material.dart';
//1.use getx package
import 'package:get/get.dart';
import 'all_com.dart';

//2.item model
class ItemDto {
  String id;
  String title;
  bool status;

  ItemDto({
    required this.id,
    required this.title,
    this.status = false,
  });
}

//3.getx controller
class StateMngCtrl extends GetxController {
  List<ItemDto> _items = [];

  //constructor
  StateMngCtrl(List<ItemDto> items) {
    _items = items;
  }

  ItemDto getItem(int index) {
    return _items[index];
  }

  int getLen() {
    return _items.length;
  }

  /*
  reload(List<ItemDto> items) {
    _items = items;
    update();
  }
  */

  add(ItemDto todo) {
    _items.add(todo);
    update();
  }

  //已存在 update() !!
  edit(ItemDto todo) {
    int index = _items.indexOf(todo);
    _items[index].status = !_items[index].status;
    update();
  }

  delete(String id) {
    _items.removeWhere((element) => element.id == id);
    update();
  }
}

//4.ui
class StateMngGetx extends StatefulWidget {
  const StateMngGetx({Key? key}) : super(key: key);

  @override
  StateMngGetxState createState() => StateMngGetxState();
}

class StateMngGetxState extends State<StateMngGetx> {
  bool _isOk = false; 
  List<ItemDto> _items = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, ()=> showA());
  }

  //非同步載入資料(可從後端載入)
  Future<void> showA() async {
    //initial items
    _items = [];
    var len = 300;
    for (var i=1; i<=len; i++){
      _items.add(ItemDto(id: i.toString(), title: 'item $i'));
    }

    setState((){_isOk = true;});
  }

  @override
  Widget build(BuildContext context) {
    if (!_isOk) return Container();

    return Scaffold(
      appBar: WG2.appBar('8.狀態管理 by Getx'),
      //5.call GetBuilder()
      body: GetBuilder(        
        init: StateMngCtrl(_items),   //6.load initial data
        builder: (StateMngCtrl ctrl) {
          return ListView.builder(
            itemCount: ctrl.getLen(),
            itemBuilder: (context, index) {
              //7.get item
              var item = ctrl.getItem(index);

              return ListTile(
                //onTap: () {},
                title: Text(item.title),
                leading: Checkbox(
                  //8.use item
                  value: item.status,
                  onChanged: (value)=> ctrl.edit(item)
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: ()=> ctrl.delete(item.id)
      ));});}),
    );
  }
}