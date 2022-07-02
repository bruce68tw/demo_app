import 'package:flutter/material.dart';
import 'package:base_lib/all.dart';

/// static class
class Xp {
  //=== constant start ===
  //global fontsize, double type
  static const fontSize = 20.0;
  static const titleFontSize = 18.0; 

  ///1.is https or not
  static const isHttps = false;
  static const isHttpsTest = false;

  ///2.api server end point
  static const apiServer = '192.168.1.103:5001';
  //=== constant end ===

  //temp photo file path, png for repaintBoundary
  static String tempPhoto = FunUt.dirApp + 'temp.png';
  //=== auto set start ===
  ///already init or not
  //static bool _isInit = false;

  //for data input
  //static DateTime _nowDate = DateTime.now();

  static List<IdStrDto> workClasses = [];  //WorkClass
  static List<IdStrDto> areas = [];
  static List<IdStrDto> dispatches = [];
  static List<IdStrDto> closes = [];
  static List<IdStr2Dto> closeDetails = [];
  //=== auto set end ===

  /// init database
  static initDb() {
    DbUt.init('Demo.db', 1, ['''
Create Table user(
  sn Integer Primary Key AutoIncrement,
  account Text Unique not null,
  name Text not null,
  dept_sn Integer,
  email Text,
  birth Text,
  status Integer not null,
  created TimeStamp Default Current_TimeStamp,
  note Text)
''','''
Create Table dept(
  sn Integer Primary Key AutoIncrement,
  name Text not null)
''']);

    //temp add, recreate user table
    //DbUt.reTableAsync('user');
  }

  //=== folder start ===
  /*
  /// get directory of workOrder image
  static String dirWoImage([String id = '', bool create = false]) {
    var dirWo = FunUt.dirApp + 'image/wo/';
    if (id == '') return dirWo;

    //create folder if need
    var dirSave = dirWo + id;
    if (create){
      var dir = Directory(dirSave);
      if (!dir.existsSync()) {
        dir.createSync(recursive: true);
      }
    }

    return dirSave + '/';
  }
  */
  //=== folder end ===

  /// get result
  /// 後端會包2層 Result 屬性!!
  static dynamic getResult(dynamic result) {
    return result['Result']['Result'];
  }

  static bool checkResultError(BuildContext context, dynamic result) {
    var msg = getResult(result);
    if (msg != ''){
      ToolUt.msg(context, msg);
      return false;
    } else {
      return true;
    }
  }

  static Future<List<IdStrDto>> getDeptsAsync() async {
    var sql = 'select sn as Id, name as Str from dept order by sn';
    var rows = await DbUt.getIdStrsAsync(sql);
    ListUt.selectAddEmpty(rows);
    return rows;
  }

} //class
