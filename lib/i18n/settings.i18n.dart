import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //
  static var _t = Translations("en_us") +
      {
        "en_us": "Settings",
        "nl_nl": "Instellingen",
        "de_de": "Einstellungen",
      } +
      {
        "en_us": "Theme Mode",
        "nl_nl": "Thema",
        "de_de": "Design",
      } +
      {
        "en_us": "System",
        "nl_nl": "Systeem",
        "de_de": "System",
      } +
      {
        "en_us": "Dark",
        "nl_nl": "Donker",
        "de_de": "Dunkel",
      } +
      {
        "en_us": "Light",
        "nl_nl": "Licht",
        "de_de": "Hell",
      } +
      {
        "en_us": "Notifications",
        "nl_nl": "Notificaties",
        "de_de": "Benachrichtigungen",
      } +
      {
        "en_us": "Receive Notifications",
        "nl_nl": "Notificaties ontvangen",
        "de_de": "Benachrichtigung erhalten",
      } +
      {
        "en_us": "Notification Time: ",
        "nl_nl": "Notificatietijd: ",
        "de_de": "Benachrichtigungzeit: ",
      } +
      {
        "en_us": "Change",
        "nl_nl": "Wijzigen",
        "de_de": "Ändern",
      } +
      {
        "en_us": "Notification Sound Enabled",
        "nl_nl": "Notificatiegeluid aan",
        "de_de": "Benachrichtingston an",
      };

  String get i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(int value) => localizePlural(value, this, _t);

  String version(Object modifier) => localizeVersion(modifier, this, _t);

  Map<String, String> allVersions() => localizeAllVersions(this, _t);
}