import 'dart:convert';

class ClientProductDetailLOTModel {
 //{id: 030002, lot: 1, name: Astro A แดง, quantity: 36.00, remain: 49.00, percent: 136, datetime: test}
  String? id;
  String? lot;
  String? name;
  String? quantity;
  String? remain;
  String? percent;
  String? datetime;
  ClientProductDetailLOTModel({
    this.id,
    this.lot,
    this.name,
    this.quantity,
    this.remain,
    this.percent,
    this.datetime,
  });
  


  ClientProductDetailLOTModel copyWith({
    String? id,
    String? lot,
    String? name,
    String? quantity,
    String? remain,
    String? percent,
    String? datetime,
  }) {
    return ClientProductDetailLOTModel(
      id: id ?? this.id,
      lot: lot ?? this.lot,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      remain: remain ?? this.remain,
      percent: percent ?? this.percent,
      datetime: datetime ?? this.datetime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lot': lot,
      'name': name,
      'quantity': quantity,
      'remain': remain,
      'percent': percent,
      'datetime': datetime,
    };
  }

  factory ClientProductDetailLOTModel.fromMap(Map<String, dynamic> map) {
    return ClientProductDetailLOTModel(
      id: map['id'],
      lot: map['lot'],
      name: map['name'],
      quantity: map['quantity'],
      remain: map['remain'],
      percent: map['percent'],
      datetime: map['datetime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientProductDetailLOTModel.fromJson(String source) => ClientProductDetailLOTModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClientProductDetailLOTModel(id: $id, lot: $lot, name: $name, quantity: $quantity, remain: $remain, percent: $percent, datetime: $datetime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ClientProductDetailLOTModel &&
      other.id == id &&
      other.lot == lot &&
      other.name == name &&
      other.quantity == quantity &&
      other.remain == remain &&
      other.percent == percent &&
      other.datetime == datetime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      lot.hashCode ^
      name.hashCode ^
      quantity.hashCode ^
      remain.hashCode ^
      percent.hashCode ^
      datetime.hashCode;
  }
}
