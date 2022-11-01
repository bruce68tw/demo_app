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

  static Future<Map<String, dynamic>> getMapAsync(int sn) async {
    return (await DbUt.getJsonAsync("select * from dept where sn=$sn"))!;
  }

  static Future<bool> insertAsync(DeptTab row) async {
    return await DbUt.insertAsync('dept', DeptTab.toMap(row));
  }

  static Future<bool> updateAsync(DeptTab row) async {
    return await DbUt.updateAsync('dept', DeptTab.toMap(row), 'sn=?', [row.sn!]);
  }

  static Future<int> deleteAsync(int sn) async {
    return await DbUt.deleteAsync('dept', 'sn=?', [sn]);
  }

}//class