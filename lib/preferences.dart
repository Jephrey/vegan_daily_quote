import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// All preferences in one place.
class Preferences extends GetxController {
  static Preferences get to => Get.find<Preferences>();

  SharedPreferences _prefs;

  var _theme = 'system'.obs; // Theme: light, dark, system.
  var _favorites = <String>[].obs; // List of favorite quotes.
  var _notifications = true.obs; // Notification on or off.
  var _notificationHour = 12.obs; // Hour of notification.
  var _notificationMinute = 0.obs; // Minute of notification.
  var _notificationSound = true.obs; // Sound or not.

  Preferences()  {
    _init();
  }

  // Theme.
  String get theme => _theme.value; 
  set theme(String theme) {
    _theme.value = theme;    
    _setPreference('theme', theme);
  }

  // Favorites. (Preference store has no List of int.)
  get favorites => _favorites.value;
  set favorites(List<String> favorites) {
    _favorites.value = favorites;
    _setPreference('favList', favorites);
  }

  // Notifications.
  bool get notifications => _notifications.value;
  set notifications(bool notifications) {
    _notifications.value = notifications;
    _setPreference('notifications', notifications);
  }

  // Notification hour.
  int get notificationHour => _notificationHour.value;
  set notificationHour(int notificationHour) {
    _notificationHour.value = notificationHour;
    _setPreference('notificationHour', notificationHour);
  }

  // Notification minute.
  int get notificationMinute => _notificationMinute.value;
  set notificationMinute(int notificationMinute) {
    _notificationMinute.value = notificationMinute;
    _setPreference('notificationMinute', notificationMinute);
  }

  // Notification minute.
  bool get notificationSound => _notificationSound.value;
  set notificationSound(bool notificationSound) {
    _notificationSound.value = notificationSound;
    _setPreference('notificationSound', notificationSound);
  }

  Future<void> _setPreference(String key, var value) async {
    if (value is String) {
      await _prefs?.setString(key, value); 
    } else if (value is int) {
      await _prefs?.setInt(key, value);
    } else if (value is bool) {
      await _prefs?.setBool(key, value);    
    } else if (value is List<String>) {
      await _prefs?.setStringList(key, value);
    } else if (value is double) {
      await _prefs?.setDouble(key, value);
    }
  }

  _init() async {
    _prefs = await SharedPreferences.getInstance();
    _theme.value = _prefs.getString('theme') ?? 'system';
    _favorites.value = _prefs.getStringList('favList') ?? [];
    _notifications.value = _prefs.getBool('notifications') ?? true;
    _notificationHour.value = _prefs.getInt('notificationHour') ?? 12;
    _notificationMinute.value = _prefs.getInt('notificationHour') ?? 0;
    _notificationSound.value = _prefs.getBool('notificationSound') ?? true;
  }
}