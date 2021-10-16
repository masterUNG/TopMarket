import 'dart:convert';

class ClientProdctPrice2Model {
  String? client;
  String? id;
  String? unitname;
  String? unitid;
  String? name;
  String? cost;
  String? price;
  String? pricetypeid;
  String? ispackageing;
  String? productname;
  ClientProdctPrice2Model({
    this.client,
    this.id,
    this.unitname,
    this.unitid,
    this.name,
    this.cost,
    this.price,
    this.pricetypeid,
    this.ispackageing,
    this.productname,
  });
  

  ClientProdctPrice2Model copyWith({
    String? client,
    String? id,
    String? unitname,
    String? unitid,
    String? name,
    String? cost,
    String? price,
    String? pricetypeid,
    String? ispackageing,
    String? productname,
  }) {
    return ClientProdctPrice2Model(
      client: client ?? this.client,
      id: id ?? this.id,
      unitname: unitname ?? this.unitname,
      unitid: unitid ?? this.unitid,
      name: name ?? this.name,
      cost: cost ?? this.cost,
      price: price ?? this.price,
      pricetypeid: pricetypeid ?? this.pricetypeid,
      ispackageing: ispackageing ?? this.ispackageing,
      productname: productname ?? this.productname,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'client': client,
      'id': id,
      'unitname': unitname,
      'unitid': unitid,
      'name': name,
      'cost': cost,
      'price': price,
      'pricetypeid': pricetypeid,
      'ispackageing': ispackageing,
      'productname': productname,
    };
  }

  factory ClientProdctPrice2Model.fromMap(Map<String, dynamic> map) {
    return ClientProdctPrice2Model(
      client: map['client'],
      id: map['id'],
      unitname: map['unitname'],
      unitid: map['unitid'],
      name: map['name'],
      cost: map['cost'],
      price: map['price'],
      pricetypeid: map['pricetypeid'],
      ispackageing: map['ispackageing'],
      productname: map['productname'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientProdctPrice2Model.fromJson(String source) => ClientProdctPrice2Model.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClientProdctPrice2Model(client: $client, id: $id, unitname: $unitname, unitid: $unitid, name: $name, cost: $cost, price: $price, pricetypeid: $pricetypeid, ispackageing: $ispackageing, productname: $productname)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ClientProdctPrice2Model &&
      other.client == client &&
      other.id == id &&
      other.unitname == unitname &&
      other.unitid == unitid &&
      other.name == name &&
      other.cost == cost &&
      other.price == price &&
      other.pricetypeid == pricetypeid &&
      other.ispackageing == ispackageing &&
      other.productname == productname;
  }

  @override
  int get hashCode {
    return client.hashCode ^
      id.hashCode ^
      unitname.hashCode ^
      unitid.hashCode ^
      name.hashCode ^
      cost.hashCode ^
      price.hashCode ^
      pricetypeid.hashCode ^
      ispackageing.hashCode ^
      productname.hashCode;
  }
}
