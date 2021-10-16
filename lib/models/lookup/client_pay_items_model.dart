import 'dart:convert';

import 'package:flutter/material.dart';

class ClientPayItemsModel {
  String? id;
  String? name;
  ClientPayItemsModel({
    this.id,
    this.name,
  });

  

  ClientPayItemsModel copyWith({
    String? id,
    String? name,
  }) {
    return ClientPayItemsModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory ClientPayItemsModel.fromMap(Map<String, dynamic> map) {
    return ClientPayItemsModel(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientPayItemsModel.fromJson(String source) => ClientPayItemsModel.fromMap(json.decode(source));

  @override
  String toString() => 'ClientPayItemsModel(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ClientPayItemsModel &&
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
