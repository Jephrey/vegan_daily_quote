import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// All preferences in one place.
class Preferences {
  static Preferences get to => Get.find<Preferences>();

  SharedPreferences _prefs;

  String _theme; // Theme: light, dark, system.
  List<String> _favorites; // List of favorite quotes.
  bool _notifications; // Notification on or off.
  int _notificationHour; // Hour of notification.
  int _notificationMinute; // Minute of notification.

  Preferences()  {
    _init();
  }

  // Theme.
  String get theme => _theme ?? 'system'; 
  set theme(String theme) {
    _theme = theme;    
    _setPreference('theme', theme);
  }

  // Favorites. (Preference store has no List of int.)
  List<String> get favorites => _favorites ?? [];
  set favorites(List<String> favorites) {
    _favorites = favorites;
    _setPreference('favList', favorites);
  }

  // Notifications.
  bool get notification => _notifications;
  set notifications(bool notifications) {
    _notifications = notifications;
    _setPreference('notifications', notifications);
  }

  // Notification hour.
  int get notificationHour => _notificationHour;
  set notificationHour(int notificationHour) {
    _notificationHour = notificationHour;
    _setPreference('notificationHour', notificationHour);
  }

  // Notification minute.
  int get notificationMinute => _notificationMinute;
  set notificationMinute(int notificationMinute) {
    _notificationMinute = notificationMinute;
    _setPreference('notificationHour', notificationMinute);
  }

  Future<void> _setPreference(String key, var value) async {
    if (value is String) {
      await _prefs.setString(key, value); 
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);    
    } else if (value is List<String>) {
      await _prefs.setStringList(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    }
  }

  _init() async {
    _prefs = await SharedPreferences.getInstance();
    _theme = _prefs.getString('theme') ?? 'system';
    _favorites = _prefs.getStringList('favList') ?? [];
    _notifications = _prefs.getBool('notifications') ?? true;
    _notificationHour = _prefs.getInt('notificationHour') ?? 12;
    _notificationMinute = _prefs.getInt('notificationHour') ?? 0;
  }
}