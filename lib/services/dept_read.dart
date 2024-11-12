import 'package:base_lib/all.dart';

class DeptRead {

  final _read = ReadDto(
      readSql: '''
select * from dept
order by sn
'''
  );

  Future<Map<String, dynamic>?> getPageAsync(DtDto dt) async {
      return await CrudRead().getPageA(_read, dt);
  }

}//class