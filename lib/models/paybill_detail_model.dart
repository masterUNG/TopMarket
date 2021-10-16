import 'dart:convert';

class ClientPayBillDetailModel {

  String? description;
  String? quantity;
  String? price;
  String? total;
  String? supplier;
  String? datetime;
  ClientPayBillDetailModel({
    this.description,
    this.quantity,
    this.price,
    this.total,
    this.supplier,
    this.datetime,
  });
  

  ClientPayBillDetailModel copyWith({
    String? description,
    String? quantity,
    String? price,
    String? total,
    String? supplier,
    String? datetime,
  }) {
    return ClientPayBillDetailModel(
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      total: total ?? this.total,
      supplier: supplier ?? this.supplier,
      datetime: datetime ?? this.datetime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'quantity': quantity,
      'price': price,
      'total': total,
      'supplier': supplier,
      'datetime': datetime,
    };
  }

  factory ClientPayBillDetailModel.fromMap(Map<String, dynamic> map) {
    return ClientPayBillDetailModel(
      description: map['description'],
      quantity: map['quantity'],
      price: map['price'],
      total: map['total'],
      supplier: map['supplier'],
      datetime: map['datetime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientPayBillDetailModel.fromJson(String source) => ClientPayBillDetailModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClientPayBillDetailModel(description: $description, quantity: $quantity, price: $price, total: $total, supplier: $supplier, datetime: $datetime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ClientPayBillDetailModel &&
      other.description == description &&
      other.quantity == quantity &&
      other.price == price &&
      other.total == total &&
      other.supplier == supplier &&
      other.datetime == datetime;
  }

  @override
  int get hashCode {
    return description.hashCode ^
      quantity.hashCode ^
      price.hashCode ^
      total.hashCode ^
      supplier.hashCode ^
      datetime.hashCode;
  }
}
