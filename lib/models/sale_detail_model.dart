import 'dart:convert';
import 'package:intl/intl.dart';

class SaleDetailModel {
  String? id;
  String? product;
  String? unit;
  String? quantity;
  String? price;
  String? sumprice;

  SaleDetailModel({
    this.id,
    this.product,
    this.unit,
    this.quantity,
    this.price,
    this.sumprice,
  });

  NumberFormat formatter = NumberFormat('###,0.00');
  NumberFormat formatter2 = NumberFormat.decimalPattern();

  String getPriceForrmated() {
    //formatter2.decimalDigits = 2;
    double val = double.parse(this.price.toString());
    return NumberFormat.simpleCurrency(name: '').format(val);
    //return formatter.format(val);
  }

  String getSumPriceForrmated() {
    //formatter2.decimalDigits = 2;
    double val = double.parse(this.sumprice.toString());
    return NumberFormat.simpleCurrency(name: '').format(val);
    //return formatter.format(val);
  }
  String getQuantityForrmated() {
    //formatter2.decimalDigits = 2;
    double val = double.parse(this.sumprice.toString());
    return NumberFormat.simpleCurrency(name: '').format(val);
    //return formatter.format(val);
  }
  SaleDetailModel copyWith({
    String? id,
    String? product,
    String? unit,
    String? quantity,
    String? price,
    String? sumprice,
  }) {
    return SaleDetailModel(
      id: id ?? this.id,
      product: product ?? this.product,
      unit: unit ?? this.unit,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      sumprice: sumprice ?? this.sumprice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': product,
      'unit': unit,
      'quantity': quantity,
      'price': price,
      'sumprice': sumprice,
    };
  }

  factory SaleDetailModel.fromMap(Map<String, dynamic> map) {
    return SaleDetailModel(
      id: map['id'],
      product: map['product'],
      unit: map['unit'],
      quantity: map['quantity'],
      price: map['price'],
      sumprice: map['sumprice'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SaleDetailModel.fromJson(String source) =>
      SaleDetailModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SaleDetailModel(id: $id, product: $product, unit: $unit, quantity: $quantity, price: $price, sumprice: $sumprice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SaleDetailModel &&
        other.id == id &&
        other.product == product &&
        other.unit == unit &&
        other.quantity == quantity &&
        other.price == price &&
        other.sumprice == sumprice;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        product.hashCode ^
        price.hashCode ^
        quantity.hashCode ^
        price.hashCode ^
        sumprice.hashCode;
  }
}
