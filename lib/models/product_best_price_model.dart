import 'dart:convert';

class ClientProductBestSaleModel {
  String? id;
  String? name;
  String? sumprice;
  String? sumtotalprimaryquantity;
  ClientProductBestSaleModel({
    this.id,
    this.name,
    this.sumprice,
    this.sumtotalprimaryquantity,
  });
  

  ClientProductBestSaleModel copyWith({
    String? id,
    String? name,
    String? sumprice,
    String? sumtotalprimaryquantity,
  }) {
    return ClientProductBestSaleModel(
      id: id ?? this.id,
      name: name ?? this.name,
      sumprice: sumprice ?? this.sumprice,
      sumtotalprimaryquantity: sumtotalprimaryquantity ?? this.sumtotalprimaryquantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sumprice': sumprice,
      'sumtotalprimaryquantity': sumtotalprimaryquantity,
    };
  }

  factory ClientProductBestSaleModel.fromMap(Map<String, dynamic> map) {
    return ClientProductBestSaleModel(
      id: map['id'],
      name: map['name'],
      sumprice: map['sumprice'],
      sumtotalprimaryquantity: map['sumtotalprimaryquantity'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientProductBestSaleModel.fromJson(String source) => ClientProductBestSaleModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClientProductBestSaleModel(id: $id, name: $name, sumprice: $sumprice, sumtotalprimaryquantity: $sumtotalprimaryquantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ClientProductBestSaleModel &&
      other.id == id &&
      other.name == name &&
      other.sumprice == sumprice &&
      other.sumtotalprimaryquantity == sumtotalprimaryquantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      sumprice.hashCode ^
      sumtotalprimaryquantity.hashCode;
  }
}
