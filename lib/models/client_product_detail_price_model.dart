import 'dart:convert';

class ClientProductDetailPriceModel {

  String? client;
  String? productid;
   String? productname;
  String? pricetypename;
  String? unitid;
  String? unitname;
  String? cost;
  String? price;
  String? pricetypeid;
  String? ispackaging;
  ClientProductDetailPriceModel({
    this.client,
    this.productid,
    this.productname,
    this.pricetypename,
    this.unitid,
    this.unitname,
    this.cost,
    this.price,
    this.pricetypeid,
    this.ispackaging,
  });
  

  ClientProductDetailPriceModel copyWith({
    String? client,
    String? productid,
    String? productname,
    String? pricetypename,
    String? unitid,
    String? unitname,
    String? cost,
    String? price,
    String? pricetypeid,
    String? ispackaging,
  }) {
    return ClientProductDetailPriceModel(
      client: client ?? this.client,
      productid: productid ?? this.productid,
      productname: productname ?? this.productname,
      pricetypename: pricetypename ?? this.pricetypename,
      unitid: unitid ?? this.unitid,
      unitname: unitname ?? this.unitname,
      cost: cost ?? this.cost,
      price: price ?? this.price,
      pricetypeid: pricetypeid ?? this.pricetypeid,
      ispackaging: ispackaging ?? this.ispackaging,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'client': client,
      'productid': productid,
      'productname': productname,
      'pricetypename': pricetypename,
      'unitid': unitid,
      'unitname': unitname,
      'cost': cost,
      'price': price,
      'pricetypeid': pricetypeid,
      'ispackaging': ispackaging,
    };
  }

  factory ClientProductDetailPriceModel.fromMap(Map<String, dynamic> map) {
    return ClientProductDetailPriceModel(
      client: map['client'],
      productid: map['productid'],
      productname: map['productname'],
      pricetypename: map['pricetypename'],
      unitid: map['unitid'],
      unitname: map['unitname'],
      cost: map['cost'],
      price: map['price'],
      pricetypeid: map['pricetypeid'],
      ispackaging: map['ispackaging'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientProductDetailPriceModel.fromJson(String source) => ClientProductDetailPriceModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClientProductDetailPriceModel(client: $client, productid: $productid, productname: $productname, pricetypename: $pricetypename, unitid: $unitid, unitname: $unitname, cost: $cost, price: $price, pricetypeid: $pricetypeid, ispackaging: $ispackaging)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ClientProductDetailPriceModel &&
      other.client == client &&
      other.productid == productid &&
      other.productname == productname &&
      other.pricetypename == pricetypename &&
      other.unitid == unitid &&
      other.unitname == unitname &&
      other.cost == cost &&
      other.price == price &&
      other.pricetypeid == pricetypeid &&
      other.ispackaging == ispackaging;
  }

  @override
  int get hashCode {
    return client.hashCode ^
      productid.hashCode ^
      productname.hashCode ^
      pricetypename.hashCode ^
      unitid.hashCode ^
      unitname.hashCode ^
      cost.hashCode ^
      price.hashCode ^
      pricetypeid.hashCode ^
      ispackaging.hashCode;
  }
}
