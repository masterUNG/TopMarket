import 'dart:convert';

class ClientProductPrice {
  
  String? client;
  String? id;
  String? unit;
  String? name;
  String? cost;
  String? price;
  String? pricetypeid;

  ClientProductPrice({
    this.client,
    this.id,
    this.unit,
    this.name,
    this.cost,
    this.price,
    this.pricetypeid,
  });
  

  ClientProductPrice copyWith({
    String? client,
    String? id,
    String? unit,
    String? name,
    String? cost,
    String? price,
    String? pricetypeid,
  }) {
    return ClientProductPrice(
      client: client ?? this.client,
      id: id ?? this.id,
      unit: unit ?? this.unit,
      name: name ?? this.name,
      cost: cost ?? this.cost,
      price: price ?? this.price,
      pricetypeid: pricetypeid ?? this.pricetypeid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'client': client,
      'id': id,
      'unit': unit,
      'name': name,
      'cost': cost,
      'price': price,
      'pricetypeid': pricetypeid,
    };
  }

  factory ClientProductPrice.fromMap(Map<String, dynamic> map) {
    return ClientProductPrice(
      client: map['client'],
      id: map['id'],
      unit: map['unit'],
      name: map['name'],
      cost: map['cost'],
      price: map['price'],
      pricetypeid: map['pricetypeid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientProductPrice.fromJson(String source) => ClientProductPrice.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClientProductPrice(client: $client, id: $id, unit: $unit, name: $name, cost: $cost, price: $price, pricetypeid: $pricetypeid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ClientProductPrice &&
      other.client == client &&
      other.id == id &&
      other.unit == unit &&
      other.name == name &&
      other.cost == cost &&
      other.price == price &&
      other.pricetypeid == pricetypeid;
  }

  @override
  int get hashCode {
    return client.hashCode ^
      id.hashCode ^
      unit.hashCode ^
      name.hashCode ^
      cost.hashCode ^
      price.hashCode ^
      pricetypeid.hashCode;
  }
}
