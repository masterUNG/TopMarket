import 'dart:convert';
import 'package:intl/intl.dart';

class ClientSaleModel {
  String? id;
  String? datetime;
  String? price;
  String? discount;
  String? finalprice;
  String? cost;
  String? profit;
  String? employee;


  NumberFormat formatter = NumberFormat('###,0.00');
  NumberFormat formatter2 = NumberFormat.decimalPattern();
  String getFinalPriceFormatted() {
    double val = double.parse(this.finalprice.toString());
    return NumberFormat.simpleCurrency(name: '').format(val);
  }
  ClientSaleModel({
    this.id,
    this.datetime,
    this.price,
    this.discount,
    this.finalprice,
    this.cost,
    this.profit,
    this.employee,
  });


  ClientSaleModel copyWith({
    String? id,
    String? datetime,
    String? price,
    String? discount,
    String? finalprice,
    String? cost,
    String? profit,
    String? employee,
  }) {
    return ClientSaleModel(
      id: id ?? this.id,
      datetime: datetime ?? this.datetime,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      finalprice: finalprice ?? this.finalprice,
      cost: cost ?? this.cost,
      profit: profit ?? this.profit,
      employee: employee ?? this.employee,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'datetime': datetime,
      'price': price,
      'discount': discount,
      'finalprice': finalprice,
      'cost': cost,
      'profit': profit,
      'employee': employee,
    };
  }

  factory ClientSaleModel.fromMap(Map<String, dynamic> map) {
    return ClientSaleModel(
      id: map['id'],
      datetime: map['datetime'],
      price: map['price'],
      discount: map['discount'],
      finalprice: map['finalprice'],
      cost: map['cost'],
      profit: map['profit'],
      employee: map['employee'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientSaleModel.fromJson(String source) => ClientSaleModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClientSaleModel(id: $id, datetime: $datetime, price: $price, discount: $discount, finalprice: $finalprice, cost: $cost, profit: $profit, employee: $employee)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ClientSaleModel &&
      other.id == id &&
      other.datetime == datetime &&
      other.price == price &&
      other.discount == discount &&
      other.finalprice == finalprice &&
      other.cost == cost &&
      other.profit == profit &&
      other.employee == employee;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      datetime.hashCode ^
      price.hashCode ^
      discount.hashCode ^
      finalprice.hashCode ^
      cost.hashCode ^
      profit.hashCode ^
      employee.hashCode;
  }
}
