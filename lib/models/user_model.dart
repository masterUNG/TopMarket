import 'dart:convert';

class UserModel {

final String id;
final String name;
final String password;
  UserModel({
    required this.id,
    required this.name,
    required this.password,
  });



  UserModel copyWith({
    String? id,
    String? name,
    String? password,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'User(id: $id, name: $name, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.id == id &&
      other.name == name &&
      other.password == password;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ password.hashCode;
}
