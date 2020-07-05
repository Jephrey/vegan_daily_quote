import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //
  static var _t = Translations("en_us") +
  {
        "en_us": "Favorites",
        "nl_nl": "Favorieten",
        "de_de": "Favoriten",
      };

  String get i18n => localize(this, _t);
}