import 'dart:convert';

import 'package:intl/intl.dart';

/*
//NumberFormat formatter = new NumberFormat()
NumberFormat formatter = NumberFormat('###,0.00');
  NumberFormat formatter2 = NumberFormat.decimalPattern();
  String getPriceForrmated() {
    //formatter2.decimalDigits = 2;
    double val = double.parse(this.price.toString());
    return NumberFormat.simpleCurrency(name: '').format(val)
    //return formatter.format(val);
  }

*/ 

class SmokeModel {
  String? id;
  String? name;
  String? price;
  String? lastbilltime;
  SmokeModel({
    this.id,
    this.name,
    this.price,
    this.lastbilltime,
  });

NumberFormat formatter = NumberFormat('###,0.00');
  NumberFormat formatter2 = NumberFormat.decimalPattern();
  String getPriceForrmated() {
    //formatter2.decimalDigits = 2;
    double val = double.parse(this.price.toString());
    return NumberFormat.simpleCurrency(name: '').format(val);
    //return formatter.format(val);
  }

  SmokeModel copyWith({
    String? id,
    String? name,
    String? price,
    String? lastbilltime,
  }) {
    return SmokeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      lastbilltime: lastbilltime ?? this.lastbilltime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'lastbilltime': lastbilltime,
    };
  }

  factory SmokeModel.fromMap(Map<String, dynamic> map) {
    return SmokeModel(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      lastbilltime: map['lastbilltime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SmokeModel.fromJson(String source) => SmokeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SmokeModel(id: $id, name: $name, price: $price, lastbilltime: $lastbilltime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SmokeModel &&
      other.id == id &&
      other.name == name &&
      other.price == price &&
      other.lastbilltime == lastbilltime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      price.hashCode ^
      lastbilltime.hashCode;
  }
}
