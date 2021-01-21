import 'dart:math';

import 'package:flutter/cupertino.dart';

class PassFormula {

  PassFormula(this.upperCase, this.lowerCase, this.haveNumbers, this.specialChars);

  bool upperCase = false;
  bool lowerCase = false;
  bool haveNumbers = false;
  bool specialChars = false;

  int length;

  String upperLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  String lowerLetters = 'abcdefghijklmnopqrstuvwxyz';
  String numbers = '0123456789';
  String symbols = '!@#[]%^&*()_+=';


  String getLowercase() {
    return lowerLetters[Random().nextInt(lowerLetters.length).round()];
  }

  String getUppercase() {
    return upperLetters[Random().nextInt(upperLetters.length).round()];
  }

  String getNumber() {
    return numbers[Random().nextInt(numbers.length).round()];
  }

  String getSymbol() {
    return symbols[Random().nextInt(symbols.length).round()];
  }


  String generatePassword(int length) {
    int len = length;

    String password = "";

    if (upperCase) {
      password += getUppercase();
    }

    if (lowerCase) { password += getLowercase(); }

    if (haveNumbers) { password += getNumber(); }

    if (specialChars) {
      password += getSymbol();
    }

    for (int i = password.length; i < len; i++) {
      String x = generateX();
      password += x;
    }

    return password;
  }

  String generateX() {
    List<String> xs = [];

    if (upperCase) {
      xs.add(getUppercase());
    }

    if (lowerCase) {
      xs.add(getLowercase());
    }

    if (haveNumbers) {
      xs.add(getNumber());
    }

    if (specialChars) {
      xs.add(getSymbol());
    }

    if (xs.length == 0) return "";

    return xs[Random().nextInt(xs.length).round()];
  }
}