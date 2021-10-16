import 'dart:convert';

class SumPriceModel {
  String sumprice = "";
  SumPriceModel({
    this.sumprice="",
  });

  SumPriceModel copyWith({
    String? sumprice,
  }) {
    return SumPriceModel(
      sumprice: sumprice ?? this.sumprice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sumprice': sumprice,
    };
  }

  factory SumPriceModel.fromMap(Map<String, dynamic> map) {
    return SumPriceModel(
      sumprice: map['sumprice'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SumPriceModel.fromJson(String source) => SumPriceModel.fromMap(json.decode(source));

  @override
  String toString() => 'SumPriceModel(sumprice: $sumprice)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SumPriceModel &&
      other.sumprice == sumprice;
  }

  @override
  int get hashCode => sumprice.hashCode;
}
