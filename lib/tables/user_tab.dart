import 'package:base_lib/all.dart';

/// User table
// ignore_for_file: non_constant_identifier_names
class UserTab {
  //String id; 
  int? sn;
  String account;
  String name;
  int? dept_sn;
  String? email;
  String? birth;
  String? note;
  int status;
  String? created;

  UserTab({
    //this.id = '', 
    this.sn,
    this.account = '',
    this.name = '',
    this.dept_sn,
    this.email,
    this.birth,
    this.note,
    this.status = 0,
    this.created,
  });

  static Map<String, dynamic> toMap(UserTab table) {
    return {
      //'id': table.id, 
      'sn': table.sn,
      'account': table.account,
      'name': table.name,
      'dept_sn': table.dept_sn,
      'email': table.email,
      'birth': table.birth,
      'note': table.note,
      'status': table.status,
      'created': table.created,
    };
  }

  ///convert json to model, static for be parameter !!
  ///can not use Map<String, Object> for null value !!
  static UserTab fromMap(Map<String, dynamic> map){
    return UserTab(
      //id: map['id'], 
      sn: map['sn'],
      account: map['account'], 
      name: map['name'], 
      dept_sn: map['dept_sn'], 
      email: map['email'], 
      birth: map['birth'], 
      note: map['note'],
      status: map['status'],
      created: map['created'], 
    );    
  }

  static Future<Map<String, dynamic>> getMapAsync(int sn) async {
    return (await DbUt.getMapAsync("select * from user where sn=$sn"))!;
  }

  static Future<bool> insertAsync(UserTab row) async {
    return await DbUt.insertAsync('user', UserTab.toMap(row));
  }

  static Future<bool> updateAsync(UserTab row) async {
    return await DbUt.updateAsync('user', UserTab.toMap(row), 'sn=?', [row.sn!]);
  }

  static Future<int> deleteAsync(int sn) async {
    return await DbUt.deleteAsync('user', 'sn=?', [sn]);
  }

}//class