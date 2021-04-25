import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //
  static var _t = Translations("en_us") +
      {
        "en_us": "Refresh",
        "nl_nl": "Vernieuw",
        "de_de": "Erneuern",
      } +
      {
        "en_us": "Settings",
        "nl_nl": "Instellingen",
        "de_de": "Einstellungen",
      } +
      {
        "en_us": "About",
        "nl_nl": "Over",
        "de_de": "Über",
      };

  String get i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(int value) => localizePlural(value, this, _t);

  String version(Object modifier) => localizeVersion(modifier, this, _t);

  Map<String?, String> allVersions() => localizeAllVersions(this, _t);
}
