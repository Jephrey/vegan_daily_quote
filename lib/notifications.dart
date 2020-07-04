import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:get/get.dart';
import 'package:vegan_daily_quote/preferences.dart';
import 'package:vegan_daily_quote/quotes_store.dart';

class Notifications {
  static Notifications get to => Get.find<Notifications>();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid;
  var initializationSettings;

  Future<void> setNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'vdq 1', 'channel vdq', 'Vegan Daily Quote',
        importance: Importance.Default,
        priority: Priority.Default,
        playSound: Preferences.to.notificationSoundEnabled,
        ticker: 'VQD ticker');
    var notificationDetails =
        NotificationDetails(androidPlatformChannelSpecifics, null);

    cancelAll();

    // If the notification time is before the current time then
    // use tomorrow's quote.
    var _now = TimeOfDay.now();
    var _hour = Preferences.to.notificationHour;
    var _min = Preferences.to.notificationMinute;

    String _quote;
    String _credits;
    if (_hour <= _now.hour && _min <= _now.minute) {
      List<String> _tomorrow = QuotesStore.to.tomorrowsQuote;
      _quote = _tomorrow[0];
      _credits = _tomorrow[1];
    } else {
      _quote = QuotesStore.to.quote;
      _credits = QuotesStore.to.credits;
    }

    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0, 'Quote by $_credits', _quote, Time(_hour, _min), notificationDetails,
        payload: 'VQD payload');
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('Notification payload: $payload');
    }
    setNotification(); // Set for next day.
  }

  Notifications() {
    initializationSettingsAndroid =
        AndroidInitializationSettings('notification');
    initializationSettings =
        new InitializationSettings(initializationSettingsAndroid, null);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  cancelAll() {
    flutterLocalNotificationsPlugin.cancelAll();
  }
}
