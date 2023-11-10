import 'package:intl/intl.dart';

String formatNumberWithComma(double number) {
  if (number >= 100 && number <= 999) {
    NumberFormat formatter = NumberFormat("#,##");
    return formatter.format(number);
  } else {
    NumberFormat formatter = NumberFormat("#,##");
    return formatter.format(number);
  }
}

String formattaCurrun(int value) {
  String formattedValue = NumberFormat.currency(
    symbol: '', // Set the currency symbol to empty if not needed
    decimalDigits: 0,
    locale: 'en_US', // Set the desired locale for formatting
  ).format(value);
  return formattedValue;
}

String formattaCurruns(double value) {
  String formattedValue = NumberFormat.currency(
    symbol: '', // Set the currency symbol to empty if not needed
    decimalDigits: 2,
    locale: 'en_US', // Set the desired locale for formatting
  ).format(value);
  return formattedValue;
}

double formataCurrun(int value) {
  NumberFormat.currency(
    symbol: '', // Set the currency symbol to empty if not needed
    // decimalDigits: 0,
    locale: 'en_US', // Set the desired locale for formatting
  ).format(value);
  // double ints = double.parse(formattedValue);
  return value / 100;
}

String formattaCurrunAverage(int value) {
  String formattedValue = NumberFormat.currency(
    symbol: '', // Set the currency symbol to empty if not needed
    decimalDigits: 0,
    locale: 'en_US', // Set the desired locale for formatting
  ).format(value / 100);
  return formattedValue;
}

String formatMCap(int value) {
  String formattedValue = NumberFormat.currency(
    symbol: '', // Set the currency symbol to empty if not needed
    decimalDigits: 0,
    locale: 'en_US', // Set the desired locale for formatting
  ).format(value);
  return formattedValue;
}

String formattaCurrunVolume(int value) {
  String formattedValue = NumberFormat.currency(
    symbol: '', // Set the currency symbol to empty if not needed
    decimalDigits: 0,
    locale: 'en_US', // Set the desired locale for formatting
  ).format(value * 100);
  return formattedValue;
}

String formatChange(double value) {
  String formattedValue = NumberFormat.currency(
    symbol: '', // Set the currency symbol to empty if not needed
    decimalDigits: 0,
    locale: 'en_US', // Set the desired locale for formatting
  ).format(value / 100);
  return formattedValue;
}

double formatIndex4k(double value) {
  NumberFormat.currency(
    symbol: '', // Set the currency symbol to empty if not needed
    // decimalDigits: 0,
    locale: 'en_US', // Set the desired locale for formatting
  ).format(value);
  // double ints = double.parse(formattedValue);
  return value / 1000;
}

double formatIndex2k(double value) {
  NumberFormat.currency(
    symbol: '', // Set the currency symbol to empty if not needed
    // decimalDigits: 0,
    locale: 'en_US', // Set the desired locale for formatting
  ).format(value);
  // double ints = double.parse(formattedValue);
  return value / 100;
}

double formatMCapM(double value) {
  NumberFormat.currency(
    symbol: '', // Set the currency symbol to empty if not needed
    // decimalDigits: 0,
    locale: 'en_US', // Set the desired locale for formatting
  ).format(value);
  // double ints = double.parse(formattedValue);
  return value / 1000000;
}

double formatMCapB(double value) {
  NumberFormat.currency(
    symbol: '', // Set the currency symbol to empty if not needed
    decimalDigits: 2,
    locale: 'en_US', // Set the desired locale for formatting
  ).format(value);
  // double ints = double.parse(formattedValue);
  return value / 1000000000;
}

String formatM(double value) {
  final formatter = NumberFormat('#,##0.0000', 'en_US');
  return formatter.format(value / 1000000);
}

String formatB(double value) {
  final formatter = NumberFormat('#,##0.0000', 'en_US');
  return formatter.format(value / 1000000000);
}
