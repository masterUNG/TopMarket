import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ClientProductStockSearchModel {

String? id;
String? lot;
String? name;
String? datetime;
String? quantity;
String? remain;
String? receiveid;
String? emp;

String formatDate() {
  List<String> date= this.datetime!.split(' ');
  return date[0].toString();
}

  ClientProductStockSearchModel({
    this.id,
    this.lot,
    this.name,
    this.datetime,
    this.quantity,
    this.remain,
    this.receiveid,
    this.emp,
  });


  ClientProductStockSearchModel copyWith({
    String? id,
    String? lot,
    String? name,
    String? datetime,
    String? quantity,
    String? remain,
    String? receiveid,
    String? emp,
  }) {
    return ClientProductStockSearchModel(
      id: id ?? this.id,
      lot: lot ?? this.lot,
      name: name ?? this.name,
      datetime: datetime ?? this.datetime,
      quantity: quantity ?? this.quantity,
      remain: remain ?? this.remain,
      receiveid: receiveid ?? this.receiveid,
      emp: emp ?? this.emp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lot': lot,
      'name': name,
      'datetime': datetime,
      'quantity': quantity,
      'remain': remain,
      'receiveid': receiveid,
      'emp': emp,
    };
  }

  factory ClientProductStockSearchModel.fromMap(Map<String, dynamic> map) {
    return ClientProductStockSearchModel(
      id: map['id'],
      lot: map['lot'],
      name: map['name'],
      datetime: map['datetime'],
      quantity: map['quantity'],
      remain: map['remain'],
      receiveid: map['receiveid'],
      emp: map['emp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientProductStockSearchModel.fromJson(String source) => ClientProductStockSearchModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClientProductStockSearchModel(id: $id, lot: $lot, name: $name, datetime: $datetime, quantity: $quantity, remain: $remain, receiveid: $receiveid, emp: $emp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ClientProductStockSearchModel &&
      other.id == id &&
      other.lot == lot &&
      other.name == name &&
      other.datetime == datetime &&
      other.quantity == quantity &&
      other.remain == remain &&
      other.receiveid == receiveid &&
      other.emp == emp;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      lot.hashCode ^
      name.hashCode ^
      datetime.hashCode ^
      quantity.hashCode ^
      remain.hashCode ^
      receiveid.hashCode ^
      emp.hashCode;
  }
}
