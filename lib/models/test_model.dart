import 'dart:convert';

class TestModel {
  String? id;
  String? name;
  String? address;
  TestModel({
    this.id,
    this.name,
    this.address,
  });

  TestModel copyWith({
    String? id,
    String? name,
    String? address,
  }) {
    return TestModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
    };
  }

  factory TestModel.fromMap(Map<String, dynamic> map) {
    return TestModel(
      id: map['id'],
      name: map['name'],
      address: map['address'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TestModel.fromJson(String source) => TestModel.fromMap(json.decode(source));

  @override
  String toString() => 'TestModel(id: $id, name: $name, address: $address)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TestModel &&
      other.id == id &&
      other.name == name &&
      other.address == address;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ address.hashCode;
}
