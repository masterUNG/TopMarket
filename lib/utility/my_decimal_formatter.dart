import 'dart:convert';
import 'package:intl/intl.dart';

class MyNumberFormatter {
  NumberFormat formatter = NumberFormat('###,0.00');
  NumberFormat formatter2 = NumberFormat.decimalPattern();

  static String formatDecimal(String number) {
    try {
      double val = double.parse(number);
      return NumberFormat.simpleCurrency(name: '').format(val);
    } catch (exception) {
      return number;
    }
  }

  static String formatInteger(String number) {
    return number;
    // String? intNum = number.split(".")[0];
    // return intNum;
    //int val = int.parse(intNum);
    //return NumberFormat.simpleCurrency(name: '').format(val);
  }
}
