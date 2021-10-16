import 'dart:convert';

class ProductModel2 {
  String? id;
  String? name;
  ProductModel2({
    this.id,
    this.name,
  });

  ProductModel2 copyWith({
    String? id,
    String? name,
  }) {
    return ProductModel2(
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

  factory ProductModel2.fromMap(Map<String, dynamic> map) {
    return ProductModel2(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel2.fromJson(String source) => ProductModel2.fromMap(json.decode(source));

  @override
  String toString() => 'ProductModel2(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProductModel2 &&
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
