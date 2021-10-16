import 'dart:convert';

class ClientProductDetailGeneralModel {
  String? id;
  String? barcode;
  String? name;
  String? desc;
  String? cost;
  String? price;
  String? typeid;
  String? typename;
  String? groupid;
  String? groupname;
  String? brandid;
  String? brandname;
  String? unitid;
  String? unitname;
  String? remain;
  String? min;
  String? max;
  String? isenablepackaging;
  String? model; 
  ClientProductDetailGeneralModel({
    this.id,
    this.barcode,
    this.name,
    this.desc,
    this.cost,
    this.price,
    this.typeid,
    this.typename,
    this.groupid,
    this.groupname,
    this.brandid,
    this.brandname,
    this.unitid,
    this.unitname,
    this.remain,
    this.min,
    this.max,
    this.isenablepackaging,
    this.model,
  });
  

  ClientProductDetailGeneralModel copyWith({
    String? id,
    String? barcode,
    String? name,
    String? desc,
    String? cost,
    String? price,
    String? typeid,
    String? typename,
    String? groupid,
    String? groupname,
    String? brandid,
    String? brandname,
    String? unitid,
    String? unitname,
    String? remain,
    String? min,
    String? max,
    String? isenablepackaging,
    String? model,
  }) {
    return ClientProductDetailGeneralModel(
      id: id ?? this.id,
      barcode: barcode ?? this.barcode,
      name: name ?? this.name,
      desc: desc ?? this.desc,
      cost: cost ?? this.cost,
      price: price ?? this.price,
      typeid: typeid ?? this.typeid,
      typename: typename ?? this.typename,
      groupid: groupid ?? this.groupid,
      groupname: groupname ?? this.groupname,
      brandid: brandid ?? this.brandid,
      brandname: brandname ?? this.brandname,
      unitid: unitid ?? this.unitid,
      unitname: unitname ?? this.unitname,
      remain: remain ?? this.remain,
      min: min ?? this.min,
      max: max ?? this.max,
      isenablepackaging: isenablepackaging ?? this.isenablepackaging,
      model: model ?? this.model,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'barcode': barcode,
      'name': name,
      'desc': desc,
      'cost': cost,
      'price': price,
      'typeid': typeid,
      'typename': typename,
      'groupid': groupid,
      'groupname': groupname,
      'brandid': brandid,
      'brandname': brandname,
      'unitid': unitid,
      'unitname': unitname,
      'remain': remain,
      'min': min,
      'max': max,
      'isenablepackaging': isenablepackaging,
      'model': model,
    };
  }

  factory ClientProductDetailGeneralModel.fromMap(Map<String, dynamic> map) {
    return ClientProductDetailGeneralModel(
      id: map['id'],
      barcode: map['barcode'],
      name: map['name'],
      desc: map['desc'],
      cost: map['cost'],
      price: map['price'],
      typeid: map['typeid'],
      typename: map['typename'],
      groupid: map['groupid'],
      groupname: map['groupname'],
      brandid: map['brandid'],
      brandname: map['brandname'],
      unitid: map['unitid'],
      unitname: map['unitname'],
      remain: map['remain'],
      min: map['min'],
      max: map['max'],
      isenablepackaging: map['isenablepackaging'],
      model: map['model'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientProductDetailGeneralModel.fromJson(String source) => ClientProductDetailGeneralModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClientProductDetailGeneralModel(id: $id, barcode: $barcode, name: $name, desc: $desc, cost: $cost, price: $price, typeid: $typeid, typename: $typename, groupid: $groupid, groupname: $groupname, brandid: $brandid, brandname: $brandname, unitid: $unitid, unitname: $unitname, remain: $remain, min: $min, max: $max, isenablepackaging: $isenablepackaging, model: $model)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ClientProductDetailGeneralModel &&
      other.id == id &&
      other.barcode == barcode &&
      other.name == name &&
      other.desc == desc &&
      other.cost == cost &&
      other.price == price &&
      other.typeid == typeid &&
      other.typename == typename &&
      other.groupid == groupid &&
      other.groupname == groupname &&
      other.brandid == brandid &&
      other.brandname == brandname &&
      other.unitid == unitid &&
      other.unitname == unitname &&
      other.remain == remain &&
      other.min == min &&
      other.max == max &&
      other.isenablepackaging == isenablepackaging &&
      other.model == model;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      barcode.hashCode ^
      name.hashCode ^
      desc.hashCode ^
      cost.hashCode ^
      price.hashCode ^
      typeid.hashCode ^
      typename.hashCode ^
      groupid.hashCode ^
      groupname.hashCode ^
      brandid.hashCode ^
      brandname.hashCode ^
      unitid.hashCode ^
      unitname.hashCode ^
      remain.hashCode ^
      min.hashCode ^
      max.hashCode ^
      isenablepackaging.hashCode ^
      model.hashCode;
  }
}
