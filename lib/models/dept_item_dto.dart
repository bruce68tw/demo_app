class DeptItemDto {
  int sn;
  String name;

  DeptItemDto({required this.sn, required this.name});

  ///convert json to model, static for be parameter !!
  static DeptItemDto fromJson(Map<String, dynamic> json){
    return DeptItemDto(
      sn : json['sn'],
      name : json['name'],
    );    
  }

}//class