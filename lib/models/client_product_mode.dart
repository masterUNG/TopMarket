import 'dart:convert';

class ClientProductModel {
  String? id;
  String? barcode;
  String? name;
  String? cost;
  String? remain;
  String? type;
  String? brand;
  String? desc; 
  String? unit;
  String? totalquantity;
  String? totalsumprice;
  String? maxprice;
  String? minprice;
  ClientProductModel({
    this.id,
    this.barcode,
    this.name,
    this.cost,
    this.remain,
    this.type,
    this.brand,
    this.desc,
    this.unit,
    this.totalquantity,
    this.totalsumprice,
    this.maxprice,
    this.minprice,
  });


  ClientProductModel copyWith({
    String? id,
    String? barcode,
    String? name,
    String? cost,
    String? remain,
    String? type,
    String? brand,
    String? desc,
    String? unit,
    String? totalquantity,
    String? totalsumprice,
    String? maxprice,
    String? minprice,
  }) {
    return ClientProductModel(
      id: id ?? this.id,
      barcode: barcode ?? this.barcode,
      name: name ?? this.name,
      cost: cost ?? this.cost,
      remain: remain ?? this.remain,
      type: type ?? this.type,
      brand: brand ?? this.brand,
      desc: desc ?? this.desc,
      unit: unit ?? this.unit,
      totalquantity: totalquantity ?? this.totalquantity,
      totalsumprice: totalsumprice ?? this.totalsumprice,
      maxprice: maxprice ?? this.maxprice,
      minprice: minprice ?? this.minprice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'barcode': barcode,
      'name': name,
      'cost': cost,
      'remain': remain,
      'type': type,
      'brand': brand,
      'desc': desc,
      'unit': unit,
      'totalquantity': totalquantity,
      'totalsumprice': totalsumprice,
      'maxprice': maxprice,
      'minprice': minprice,
    };
  }

  factory ClientProductModel.fromMap(Map<String, dynamic> map) {
    return ClientProductModel(
      id: map['id'],
      barcode: map['barcode'],
      name: map['name'],
      cost: map['cost'],
      remain: map['remain'],
      type: map['type'],
      brand: map['brand'],
      desc: map['desc'],
      unit: map['unit'],
      totalquantity: map['totalquantity'],
      totalsumprice: map['totalsumprice'],
      maxprice: map['maxprice'],
      minprice: map['minprice'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientProductModel.fromJson(String source) => ClientProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClientProductModel(id: $id, barcode: $barcode, name: $name, cost: $cost, remain: $remain, type: $type, brand: $brand, desc: $desc, unit: $unit, totalquantity: $totalquantity, totalsumprice: $totalsumprice, maxprice: $maxprice, minprice: $minprice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ClientProductModel &&
      other.id == id &&
      other.barcode == barcode &&
      other.name == name &&
      other.cost == cost &&
      other.remain == remain &&
      other.type == type &&
      other.brand == brand &&
      other.desc == desc &&
      other.unit == unit &&
      other.totalquantity == totalquantity &&
      other.totalsumprice == totalsumprice &&
      other.maxprice == maxprice &&
      other.minprice == minprice;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      barcode.hashCode ^
      name.hashCode ^
      cost.hashCode ^
      remain.hashCode ^
      type.hashCode ^
      brand.hashCode ^
      desc.hashCode ^
      unit.hashCode ^
      totalquantity.hashCode ^
      totalsumprice.hashCode ^
      maxprice.hashCode ^
      minprice.hashCode;
  }
}
