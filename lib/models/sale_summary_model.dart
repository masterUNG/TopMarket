import 'dart:convert';

class SaleSummaryModel {
  //[{"salebillcount":"818","sumcostprice":"70504.28","sumprofit":"14344.72"}]

  String? salebillcount;
  String? sumcostprice;
  String? sumprofit;
  SaleSummaryModel({
    this.salebillcount,
    this.sumcostprice,
    this.sumprofit,
  });

  SaleSummaryModel copyWith({
    String? salebillcount,
    String? sumcostprice,
    String? sumprofit,
  }) {
    return SaleSummaryModel(
      salebillcount: salebillcount ?? this.salebillcount,
      sumcostprice: sumcostprice ?? this.sumcostprice,
      sumprofit: sumprofit ?? this.sumprofit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'salebillcount': salebillcount,
      'sumcostprice': sumcostprice,
      'sumprofit': sumprofit,
    };
  }

  factory SaleSummaryModel.fromMap(Map<String, dynamic> map) {
    return SaleSummaryModel(
      salebillcount: map['salebillcount'],
      sumcostprice: map['sumcostprice'],
      sumprofit: map['sumprofit'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SaleSummaryModel.fromJson(String source) => SaleSummaryModel.fromMap(json.decode(source));

  @override
  String toString() => 'SaleSummaryModel(salebillcount: $salebillcount, sumcostprice: $sumcostprice, sumprofit: $sumprofit)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SaleSummaryModel &&
      other.salebillcount == salebillcount &&
      other.sumcostprice == sumcostprice &&
      other.sumprofit == sumprofit;
  }

  @override
  int get hashCode => salebillcount.hashCode ^ sumcostprice.hashCode ^ sumprofit.hashCode;
}
