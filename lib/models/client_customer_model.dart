import 'dart:convert';

import 'package:flutter/material.dart';

class ClientCustomerModel {
  String? id;
  String? phone;
  String? line;
  String? fullname;
  String? province;
  String? customergroup;
  String? price;
  String? points;
  String? currentcredit;
  String? sale;
  ClientCustomerModel({
    this.id,
    this.phone,
    this.line,
    this.fullname,
    this.province,
    this.customergroup,
    this.price,
    this.points,
    this.currentcredit,
    this.sale,
  });
  

  ClientCustomerModel copyWith({
    String? id,
    String? phone,
    String? line,
    String? fullname,
    String? province,
    String? customergroup,
    String? price,
    String? points,
    String? currentcredit,
    String? sale,
  }) {
    return ClientCustomerModel(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      line: line ?? this.line,
      fullname: fullname ?? this.fullname,
      province: province ?? this.province,
      customergroup: customergroup ?? this.customergroup,
      price: price ?? this.price,
      points: points ?? this.points,
      currentcredit: currentcredit ?? this.currentcredit,
      sale: sale ?? this.sale,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phone': phone,
      'line': line,
      'fullname': fullname,
      'province': province,
      'customergroup': customergroup,
      'price': price,
      'points': points,
      'currentcredit': currentcredit,
      'sale': sale,
    };
  }

  factory ClientCustomerModel.fromMap(Map<String, dynamic> map) {
    return ClientCustomerModel(
      id: map['id'],
      phone: map['phone'],
      line: map['line'],
      fullname: map['fullname'],
      province: map['province'],
      customergroup: map['customergroup'],
      price: map['price'],
      points: map['points'],
      currentcredit: map['currentcredit'],
      sale: map['sale'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientCustomerModel.fromJson(String source) => ClientCustomerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClientCustomerModel(id: $id, phone: $phone, line: $line, fullname: $fullname, province: $province, customergroup: $customergroup, price: $price, points: $points, currentcredit: $currentcredit, sale: $sale)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ClientCustomerModel &&
      other.id == id &&
      other.phone == phone &&
      other.line == line &&
      other.fullname == fullname &&
      other.province == province &&
      other.customergroup == customergroup &&
      other.price == price &&
      other.points == points &&
      other.currentcredit == currentcredit &&
      other.sale == sale;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      phone.hashCode ^
      line.hashCode ^
      fullname.hashCode ^
      province.hashCode ^
      customergroup.hashCode ^
      price.hashCode ^
      points.hashCode ^
      currentcredit.hashCode ^
      sale.hashCode;
  }
}

/*
    id: map['id'],
      phone: map['phone'],
      line: map['line'],
      fullname: map['fullname'],
      province: map['province'],
      customergroup: map['customergroup'],
      price: double.parse(map['price']) ,
      points: int.parse(map['points']),
      currentcredit: double.parse(map['currentcredit']) ,
      sale: double.parse( map['sale']),
*/
