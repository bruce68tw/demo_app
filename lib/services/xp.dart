import 'dart:io';
import 'package:flutter/material.dart';
import 'package:base_lib/all.dart';

/// static class
class Xp {
  //=== constant start ===
  //global fontsize, double type
  //static const double fontSize = 18;

  ///1.is https or not
  static const isHttps = false;
  static const isHttpsTest = false;

  ///2.api server end point
  //static const apiServer = '192.168.1.100:5007';
  static const apiServer = 'uper.fhnet.com.tw:5007';
  //static const apiServerTest = '192.168.1.100:5007'; //e-fun
  static const apiServerTest = 'uper.fhnet.com.tw:5007'; //e-fun  
  //=== constant end ===

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
  sn Integer Primary Key AutoIncrement not null,
  account Text Unique,
  name Text not null,
  dept_sn Integer,
  email Text,
  created TimeStamp Default Current_TimeStamp,
  note Text)
''','''
Create Table dept(
  sn Integer Primary Key AutoIncrement not null,
  name Text not null)
''']);
  }

  //=== folder start ===
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
    var sql = 'select sn ad id, name as str from dept order by sn';
    return await DbUt.getIdStrsAsync(sql);
  }

} //class
