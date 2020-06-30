import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //
  static var _t = Translations("en_us") +
      {
        "en_us": "Link to quote",
        "nl_nl": "Link naar citaat",
        "de_de": "Link zum Zitat",
      } +
      {
        "en_us": "No link available.",
        "nl_nl": "Geen link aanwezig.",
        "de_de": "Kein link vorhanden.",
      };

  String get i18n => localize(this, _t);
}