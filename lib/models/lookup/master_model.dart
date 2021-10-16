import 'dart:convert';

class MasterModel {
  String? id;
  String? name;
  MasterModel({
    this.id,
    this.name,
  });

  MasterModel copyWith({
    String? id,
    String? name,
  }) {
    return MasterModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory MasterModel.fromMap(Map<String, dynamic> map) {
    return MasterModel(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MasterModel.fromJson(String source) => MasterModel.fromMap(json.decode(source));

  @override
  String toString() => 'MasterModel(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MasterModel &&
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
