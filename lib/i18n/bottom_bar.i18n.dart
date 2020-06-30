import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //
  static var _t = Translations("en_us") +
      {
        "en_us": "Copy Quote",
        "nl_nl": "Citaat kopiëren",
        "de_de": "Zitat kopieren",
      } +
      {
        "en_us": "Share Quote",
        "nl_nl": "Citaat delen",
        "de_de": "Zitat teilen",
      } +
      {
        "en_us": "Open link",
        "nl_nl": "Link openen",
        "de_de": "Link öffnen",
      } +
      {
        "en_us": "Toggle favorite",
        "nl_nl": "Favoriet aan/uit",
        "de_de": "Favorit an/aus",
      } +
      {
        "en_us": "Quote copied to clipboard",
        "nl_nl": "Citaat naar klembord gekopieerd",
        "de_de": "Zitat in Zwischenablage kopiert",
      };

  String get i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(int value) => localizePlural(value, this, _t);

  String version(Object modifier) => localizeVersion(modifier, this, _t);

  Map<String, String> allVersions() => localizeAllVersions(this, _t);
}