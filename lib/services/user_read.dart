import 'package:base_lib/all.dart';

class UserRead {

  final _read = ReadDto(
      readSql: '''
select u.sn, u.name, u.account,
  d.name as dept_name
from user u
left join dept d on u.dept_sn=d.sn
order by u.sn
''',
      items: [
          QitemDto(fid: 'account', op: ItemOpEstr.like),
          QitemDto(fid: 'name', op: ItemOpEstr.like),
          QitemDto(fid: 'dept_sn'),
      ],
  );

  Future<Map<String, dynamic>?> getPageAsync(DtDto dt) async {
      return await CrudRead().getPageAsync(_read, dt);
  }

}//class