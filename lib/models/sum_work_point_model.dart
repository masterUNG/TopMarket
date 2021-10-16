import 'dart:convert';

class SumWorkPointModel {
  String? saleamount;
  String? sumexpenditureamount;
  String? returnamount;
  String? incomeremainamount;
  String? sentamount;
  String? cashamount;
  String? accountamount;
  String? missingamount;
  String? salebeforediscount;
  String? discount;
  String? payinamount;
  String? payoutamount;
  String? arrearsamount;
  String? arrearspayamount;
  String? sumprofit;
  String? sumcost;
  String? emp;
  String? phone;
  String? email;
  String? line;
  String? durationworktime;
    String? checkintime;

      String finalProfit() {
    try {
      double profitRemain = double.parse(this.sumprofit!) -
          double.parse(this.sumexpenditureamount!);

      return profitRemain.toString();
    } catch (erorr) {
      return "ยังไม่สามารถคำนวนได้";
    }
  }

  
  SumWorkPointModel({
    this.saleamount,
    this.sumexpenditureamount,
    this.returnamount,
    this.incomeremainamount,
    this.sentamount,
    this.cashamount,
    this.accountamount,
    this.missingamount,
    this.salebeforediscount,
    this.discount,
    this.payinamount,
    this.payoutamount,
    this.arrearsamount,
    this.arrearspayamount,
    this.sumprofit,
    this.sumcost,
    this.emp,
    this.phone,
    this.email,
    this.line,
    this.durationworktime,
    this.checkintime,
  });




  SumWorkPointModel copyWith({
    String? saleamount,
    String? sumexpenditureamount,
    String? returnamount,
    String? incomeremainamount,
    String? sentamount,
    String? cashamount,
    String? accountamount,
    String? missingamount,
    String? salebeforediscount,
    String? discount,
    String? payinamount,
    String? payoutamount,
    String? arrearsamount,
    String? arrearspayamount,
    String? sumprofit,
    String? sumcost,
    String? emp,
    String? phone,
    String? email,
    String? line,
    String? durationworktime,
    String? checkintime,
  }) {
    return SumWorkPointModel(
      saleamount: saleamount ?? this.saleamount,
      sumexpenditureamount: sumexpenditureamount ?? this.sumexpenditureamount,
      returnamount: returnamount ?? this.returnamount,
      incomeremainamount: incomeremainamount ?? this.incomeremainamount,
      sentamount: sentamount ?? this.sentamount,
      cashamount: cashamount ?? this.cashamount,
      accountamount: accountamount ?? this.accountamount,
      missingamount: missingamount ?? this.missingamount,
      salebeforediscount: salebeforediscount ?? this.salebeforediscount,
      discount: discount ?? this.discount,
      payinamount: payinamount ?? this.payinamount,
      payoutamount: payoutamount ?? this.payoutamount,
      arrearsamount: arrearsamount ?? this.arrearsamount,
      arrearspayamount: arrearspayamount ?? this.arrearspayamount,
      sumprofit: sumprofit ?? this.sumprofit,
      sumcost: sumcost ?? this.sumcost,
      emp: emp ?? this.emp,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      line: line ?? this.line,
      durationworktime: durationworktime ?? this.durationworktime,
      checkintime: checkintime ?? this.checkintime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'saleamount': saleamount,
      'sumexpenditureamount': sumexpenditureamount,
      'returnamount': returnamount,
      'incomeremainamount': incomeremainamount,
      'sentamount': sentamount,
      'cashamount': cashamount,
      'accountamount': accountamount,
      'missingamount': missingamount,
      'salebeforediscount': salebeforediscount,
      'discount': discount,
      'payinamount': payinamount,
      'payoutamount': payoutamount,
      'arrearsamount': arrearsamount,
      'arrearspayamount': arrearspayamount,
      'sumprofit': sumprofit,
      'sumcost': sumcost,
      'emp': emp,
      'phone': phone,
      'email': email,
      'line': line,
      'durationworktime': durationworktime,
      'checkintime': checkintime,
    };
  }

  factory SumWorkPointModel.fromMap(Map<String, dynamic> map) {
    return SumWorkPointModel(
      saleamount: map['saleamount'],
      sumexpenditureamount: map['sumexpenditureamount'],
      returnamount: map['returnamount'],
      incomeremainamount: map['incomeremainamount'],
      sentamount: map['sentamount'],
      cashamount: map['cashamount'],
      accountamount: map['accountamount'],
      missingamount: map['missingamount'],
      salebeforediscount: map['salebeforediscount'],
      discount: map['discount'],
      payinamount: map['payinamount'],
      payoutamount: map['payoutamount'],
      arrearsamount: map['arrearsamount'],
      arrearspayamount: map['arrearspayamount'],
      sumprofit: map['sumprofit'],
      sumcost: map['sumcost'],
      emp: map['emp'],
      phone: map['phone'],
      email: map['email'],
      line: map['line'],
      durationworktime: map['durationworktime'],
      checkintime: map['checkintime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SumWorkPointModel.fromJson(String source) => SumWorkPointModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SumWorkPointModel(saleamount: $saleamount, sumexpenditureamount: $sumexpenditureamount, returnamount: $returnamount, incomeremainamount: $incomeremainamount, sentamount: $sentamount, cashamount: $cashamount, accountamount: $accountamount, missingamount: $missingamount, salebeforediscount: $salebeforediscount, discount: $discount, payinamount: $payinamount, payoutamount: $payoutamount, arrearsamount: $arrearsamount, arrearspayamount: $arrearspayamount, sumprofit: $sumprofit, sumcost: $sumcost, emp: $emp, phone: $phone, email: $email, line: $line, durationworktime: $durationworktime, checkintime: $checkintime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SumWorkPointModel &&
      other.saleamount == saleamount &&
      other.sumexpenditureamount == sumexpenditureamount &&
      other.returnamount == returnamount &&
      other.incomeremainamount == incomeremainamount &&
      other.sentamount == sentamount &&
      other.cashamount == cashamount &&
      other.accountamount == accountamount &&
      other.missingamount == missingamount &&
      other.salebeforediscount == salebeforediscount &&
      other.discount == discount &&
      other.payinamount == payinamount &&
      other.payoutamount == payoutamount &&
      other.arrearsamount == arrearsamount &&
      other.arrearspayamount == arrearspayamount &&
      other.sumprofit == sumprofit &&
      other.sumcost == sumcost &&
      other.emp == emp &&
      other.phone == phone &&
      other.email == email &&
      other.line == line &&
      other.durationworktime == durationworktime &&
      other.checkintime == checkintime;
  }

  @override
  int get hashCode {
    return saleamount.hashCode ^
      sumexpenditureamount.hashCode ^
      returnamount.hashCode ^
      incomeremainamount.hashCode ^
      sentamount.hashCode ^
      cashamount.hashCode ^
      accountamount.hashCode ^
      missingamount.hashCode ^
      salebeforediscount.hashCode ^
      discount.hashCode ^
      payinamount.hashCode ^
      payoutamount.hashCode ^
      arrearsamount.hashCode ^
      arrearspayamount.hashCode ^
      sumprofit.hashCode ^
      sumcost.hashCode ^
      emp.hashCode ^
      phone.hashCode ^
      email.hashCode ^
      line.hashCode ^
      durationworktime.hashCode ^
      checkintime.hashCode;
  }
}
