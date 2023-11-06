import 'package:flutter/services.dart';

extension StringExtensions on String?{
  // String get inCaps =>
  //     notEmpty && this!.length > 0 ? '${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}' : '';
  //
  // String get capitalizeFirstOfEach =>
  //     notEmpty ? this!.replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.inCaps).join(' ') : '';

  // String get everyFirstDigit => Helper.getEveryFirstDigit(this);

  // String get nullSafe => Helper.checkNull(this);
  String get nullSafe => this ?? '';

  // String placeholder(String? def) => empty ? def.nullSafe : nullSafe;

  String get nullStr => this ?? '------';

  // bool get notEmpty => !Helper.isEmpty(this);

  // bool get empty => Helper.isEmpty(this);
  //
  // int get toInt => Helper.parseInt(this);
  //
  // double get toDouble => Helper.parseDouble(this);

  void get copy => Clipboard.setData(ClipboardData(text: this.nullSafe));

  // List<String> get toList => Helper.toList(this);

  // String get t => Strings.get(this);

  // bool get isNumeric => this.notEmpty && double.tryParse(this ?? '0') != null;
  //
  // String get formatNumber => Helper.formatNumber(this ?? '0');

  // String get formatNumberWithPlus => Helper.formatNumber(this ?? '0', withPlus: true);
  // String get formatNumberWithPlusBracket => Helper.formatNumber(this ?? '0', withPlus: true,withBracket:true);

  // String get starred => Helper.starred(nullSafe, 6);
  // String get toCommaSeparatedPrice {
  //   return NumberFormat('#,##,###.##').format(this.placeholder('0').toDouble);
  // }
}