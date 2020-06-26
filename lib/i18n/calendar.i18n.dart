import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //
  static var _t = Translations("en_us") +
      {
        "en_us": "JANUARY",
        "nl_nl": "JANUARI",
        "de_de": "JANUAR",
      } +
      {
        "en_us": "FEBRUARY",
        "nl_nl": "FEBRUARI",
        "de_de": "FEBRUAR",
      } +
      {
        "en_us": "MARCH",
        "nl_nl": "MAART",
        "de_de": "MÄRZ",
      } +
      {
        "en_us": "APRIL",
        "nl_nl": "APRIL",
        "de_de": "APRIL",
      } +
      {
        "en_us": "MAY",
        "nl_nl": "MEI",
        "de_de": "MAI",
      } +
      {
        "en_us": "JUNE",
        "nl_nl": "JUNI",
        "de_de": "JUNI",
      } +
      {
        "en_us": "JULY",
        "nl_nl": "JULI",
        "de_de": "JULI",
      } +
      {
        "en_us": "AUGUST",
        "nl_nl": "AUGUSTUS",
        "de_de": "AUGUST",
      } +
      {
        "en_us": "SEPTEMBER",
        "nl_nl": "SEPTEMBER",
        "de_de": "SEPTEMBER",
      } +
      {
        "en_us": "OCTOBER",
        "nl_nl": "OKTOBER",
        "de_de": "OKTOBER",
      } +
      {
        "en_us": "NOVEMBER",
        "nl_nl": "NOVEMBER",
        "de_de": "NOVEMBER",
      } +
      {
        "en_us": "DECEMBER",
        "nl_nl": "DECEMBER",
        "de_de": "DEZEMBER",
      };

  String get i18n => localize(this, _t);
}