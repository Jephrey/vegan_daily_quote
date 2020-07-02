import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// All preferences in one place.
class Preferences extends GetxController {
  static Preferences get to => Get.find<Preferences>();

  final _prefs = GetStorage();

  var _theme = 'system'.obs; // Theme: light, dark, system.
  var _favorites = [].obs; // List of favorite quotes.
  var _notifications = true.obs; // Notification on or off.
  var _notificationHour = 12.obs; // Hour of notification.
  var _notificationMinute = 0.obs; // Minute of notification.
  var _notificationSoundEnabled = true.obs; // Sound or not.

  Preferences() {
     _theme.value = _prefs.read('theme') ?? 'system';
    _favorites.value = _prefs.read('favList') ?? [];
    _notifications.value = _prefs.read('notifications') ?? true;
    _notificationHour.value = _prefs.read('notificationHour') ?? 12;
    _notificationMinute.value = _prefs.read('notificationHour') ?? 0;
    _notificationSoundEnabled.value = _prefs.read('notificationSoundEnabled') ?? true;
  }

  // Theme.
  String get theme => _theme.value;
  set theme(String theme) {
    _theme.value = theme;
    _prefs.write('theme', theme);
  }

  // Favorites.
  get favorites => _favorites.value;
  set favorites(List<int> favorites) {
    _favorites.value = favorites;
    _prefs.write('favList', favorites);
  }

  // Notifications.
  bool get notifications => _notifications.value;
  set notifications(bool notifications) {
    _notifications.value = notifications;
    _prefs.write('notifications', notifications);
  }

  // Notification hour.
  int get notificationHour => _notificationHour.value;
  set notificationHour(int notificationHour) {
    _notificationHour.value = notificationHour;
    _prefs.write('notificationHour', notificationHour);
  }

  // Notification minute.
  int get notificationMinute => _notificationMinute.value;
  set notificationMinute(int notificationMinute) {
    _notificationMinute.value = notificationMinute;
    _prefs.write('notificationMinute', notificationMinute);
  }

  // Notification Sound Enabled?
  bool get notificationSoundEnabled => _notificationSoundEnabled.value;
  set notificationSoundEnabled(bool notificationSoundEnabled) {
    _notificationSoundEnabled.value = notificationSoundEnabled;
    _prefs.write('notificationSoundEnabled', notificationSoundEnabled);
  }
}
