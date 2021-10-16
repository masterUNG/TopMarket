import 'dart:convert';
class ClientSupplierModel {
  String? id;
  String? name;
  String? address;
  String? province;
  ClientSupplierModel({
    this.id,
    this.name,
    this.address,
    this.province,
  });

  ClientSupplierModel copyWith({
    String? id,
    String? name,
    String? address,
    String? province,
  }) {
    return ClientSupplierModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      province: province ?? this.province,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'province': province,
    };
  }

  factory ClientSupplierModel.fromMap(Map<String, dynamic> map) {
    return ClientSupplierModel(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      province: map['province'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientSupplierModel.fromJson(String source) => ClientSupplierModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClientSupplierModel(id: $id, name: $name, address: $address, province: $province)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ClientSupplierModel &&
      other.id == id &&
      other.name == name &&
      other.address == address &&
      other.province == province;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      address.hashCode ^
      province.hashCode;
  }
}
