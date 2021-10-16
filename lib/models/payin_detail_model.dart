import 'dart:convert';

class ClientPayinDetailModel {

  String? description;
  String? quantity;
  String? price;
  String? total;
  String? employee;
  String? datetime;
  ClientPayinDetailModel({
    this.description,
    this.quantity,
    this.price,
    this.total,
    this.employee,
    this.datetime,
  });


  ClientPayinDetailModel copyWith({
    String? description,
    String? quantity,
    String? price,
    String? total,
    String? employee,
    String? datetime,
  }) {
    return ClientPayinDetailModel(
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      total: total ?? this.total,
      employee: employee ?? this.employee,
      datetime: datetime ?? this.datetime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'quantity': quantity,
      'price': price,
      'total': total,
      'employee': employee,
      'datetime': datetime,
    };
  }

  factory ClientPayinDetailModel.fromMap(Map<String, dynamic> map) {
    return ClientPayinDetailModel(
      description: map['description'],
      quantity: map['quantity'],
      price: map['price'],
      total: map['total'],
      employee: map['employee'],
      datetime: map['datetime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientPayinDetailModel.fromJson(String source) => ClientPayinDetailModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClientPayinDetail(description: $description, quantity: $quantity, price: $price, total: $total, employee: $employee, datetime: $datetime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ClientPayinDetailModel &&
      other.description == description &&
      other.quantity == quantity &&
      other.price == price &&
      other.total == total &&
      other.employee == employee &&
      other.datetime == datetime;
  }

  @override
  int get hashCode {
    return description.hashCode ^
      quantity.hashCode ^
      price.hashCode ^
      total.hashCode ^
      employee.hashCode ^
      datetime.hashCode;
  }
}
