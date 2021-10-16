import 'dart:convert';

import 'package:flutter/material.dart';

class ClientStatSaleDate {
  double? sale;
  String? date; 
  ClientStatSaleDate({
    this.sale,
    this.date,
  });
  

  ClientStatSaleDate copyWith({
    double? sale,
    String? date,
  }) {
    return ClientStatSaleDate(
      sale: sale ?? this.sale,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sale':  sale,
      'date': date,
    };
  }


  factory ClientStatSaleDate.fromMap(Map<String, dynamic> map) {
    return ClientStatSaleDate(
      sale: double.parse(map['sale']) ,
      date: map['date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientStatSaleDate.fromJson(String source) => ClientStatSaleDate.fromMap(json.decode(source));

  @override
  String toString() => 'ClientStatSaleDate(sale: $sale, date: $date)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ClientStatSaleDate &&
      other.sale == sale &&
      other.date == date;
  }

  @override
  int get hashCode => sale.hashCode ^ date.hashCode;
}
