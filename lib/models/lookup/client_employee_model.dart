import 'dart:convert';
class ClientLookupEmployeeModel {
  
  String? id;
  String? name;
  String? dep;
  String? province;
  ClientLookupEmployeeModel({
    this.id,
    this.name,
    this.dep,
    this.province,
  });

  ClientLookupEmployeeModel copyWith({
    String? id,
    String? name,
    String? dep,
    String? province,
  }) {
    return ClientLookupEmployeeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      dep: dep ?? this.dep,
      province: province ?? this.province,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dep': dep,
      'province': province,
    };
  }

  factory ClientLookupEmployeeModel.fromMap(Map<String, dynamic> map) {
    return ClientLookupEmployeeModel(
      id: map['id'],
      name: map['name'],
      dep: map['dep'],
      province: map['province'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientLookupEmployeeModel.fromJson(String source) => ClientLookupEmployeeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClientLookupEmployeeModel(id: $id, name: $name, dep: $dep, province: $province)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ClientLookupEmployeeModel &&
      other.id == id &&
      other.name == name &&
      other.dep == dep &&
      other.province == province;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      dep.hashCode ^
      province.hashCode;
  }
}
