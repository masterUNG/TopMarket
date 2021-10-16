import 'dart:convert';


class ProductReorderModel {
  String? id;
  String? name;
  String? unit;
  String? remain;
  ProductReorderModel({
    this.id,
    this.name,
    this.unit,
    this.remain,
  });

  ProductReorderModel copyWith({
    String? id,
    String? name,
    String? unit,
    String? remain,
  }) {
    return ProductReorderModel(
      id: id ?? this.id,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      remain: remain ?? this.remain,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'unit': unit,
      'remain': remain,
    };
  }

  factory ProductReorderModel.fromMap(Map<String, dynamic> map) {
    return ProductReorderModel(
      id: map['id'],
      name: map['name'],
      unit: map['unit'],
      remain: map['remain'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductReorderModel.fromJson(String source) => ProductReorderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductReorderModel(id: $id, name: $name, unit: $unit, remain: $remain)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProductReorderModel &&
      other.id == id &&
      other.name == name &&
      other.unit == unit &&
      other.remain == remain;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      unit.hashCode ^
      remain.hashCode;
  }
}
