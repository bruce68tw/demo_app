import 'package:flutter/material.dart';
//import 'package:base_lib/all.dart';
import 'all_com.dart';

//2.item model
class Item2Dto {
  String id;
  String title;
  bool status;

  Item2Dto({
    required this.id,
    required this.title,
    this.status = false,
  });
}

class ChildCheck extends StatefulWidget {
  const ChildCheck({ Key? key }) : super(key: key);

  @override
  ChildCheckState createState() => ChildCheckState();
}

class ChildCheckState extends State<ChildCheck> {
  bool _isOk = false; 
  List<Item2Dto> _items = [];

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
      _items.add(Item2Dto(id: i.toString(), title: 'item $i'));
    }

    setState((){_isOk = true;});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WG2.appBar('11.child checkbox setState()'),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          for(var i=0; i<_items.length; i++)
            StatefulBuilder(builder: (context2, setState2) {
              var item = _items[i];
              return ListTile(
                //onTap: () {},
                title: Text(item.title),
                leading: Checkbox(
                  value: item.status,
                  onChanged: (value)=> setState2(()=> item.status = value!)
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: (){}
              ));
            })
            //CheckItem(item: _items[i])
        ]
    ));    
  }

} //class

/*
//child
class CheckItem extends StatefulWidget {
  const CheckItem({ Key? key, required this.item }) : super(key: key);
  final Item2Dto item;

  @override
  CheckItemState createState() => CheckItemState();
}

class CheckItemState extends State<CheckItem> {
  @override
  Widget build(BuildContext context) {
    var item = widget.item;
    return ListTile(
      //onTap: () {},
      title: Text(item.title),
      leading: Checkbox(
        value: item.status,
        onChanged: (value)=> setState(()=> item.status = value!)
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: (){}
    ));
  }

} //class
*/