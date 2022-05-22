class UserItemDto {
  int sn;
  String account;
  String name;
  String deptName;

  UserItemDto({required this.sn, required this.name, required this.account,
    this.deptName = '' });

  ///convert json to model, static for be parameter !!
  static UserItemDto fromJson(Map<String, dynamic> json){
    return UserItemDto(
      sn : json['sn'],
      account : json['account'],
      name : json['name'],
      deptName : json['dept_name'] ?? '',
    );    
  }

}//class