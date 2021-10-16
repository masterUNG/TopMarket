import 'dart:convert';

import 'package:flutter/material.dart';

class AuthenModel {
  String? id;
  String? name;
  String? token;
  String? clientcount;
  AuthenModel({
    this.id,
    this.name,
    this.token,
    this.clientcount,
  });
  

  AuthenModel copyWith({
    String? id,
    String? name,
    String? token,
    String? clientcount,
  }) {
    return AuthenModel(
      id: id ?? this.id,
      name: name ?? this.name,
      token: token ?? this.token,
      clientcount: clientcount ?? this.clientcount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'token': token,
      'clientcount': clientcount,
    };
  }

  factory AuthenModel.fromMap(Map<String, dynamic> map) {
    return AuthenModel(
      id: map['id'],
      name: map['name'],
      token: map['token'],
      clientcount: map['clientcount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthenModel.fromJson(String source) => AuthenModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AuthenModel(id: $id, name: $name, token: $token, clientcount: $clientcount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AuthenModel &&
      other.id == id &&
      other.name == name &&
      other.token == token &&
      other.clientcount == clientcount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      token.hashCode ^
      clientcount.hashCode;
  }
}
