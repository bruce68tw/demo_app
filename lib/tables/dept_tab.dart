import 'package:base_lib/all.dart';

class DeptTab {
  int? sn; 
  String name;

  DeptTab({
    this.sn, 
    this.name = ''
  });

  static Map<String, dynamic> toMap(DeptTab table) {
    return {
      'sn': table.sn, 
      'name': table.name
    };
  }

  ///convert json to model, static for be parameter !!
  static DeptTab fromMap(Map<String, dynamic> map){
    return DeptTab(
      sn: map['sn'], 
      name: map['name']
    );    
  }

  static Future<Map<String, dynamic>> getMapA(int sn) async {
    return (await DbUt.getJsonA("select * from dept where sn=$sn"))!;
  }

  static Future<bool> insertA(DeptTab row) async {
    return await DbUt.insertA('dept', DeptTab.toMap(row));
  }

  static Future<bool> updateA(DeptTab row) async {
    return await DbUt.updateA('dept', DeptTab.toMap(row), 'sn=?', [row.sn!]);
  }

  static Future<int> deleteA(int sn) async {
    return await DbUt.deleteA('dept', 'sn=?', [sn]);
  }

}//class