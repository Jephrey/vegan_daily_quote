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
        'channel id', 'channel name', 'channel description',
        importance: Importance.Default,
        priority: Priority.Default,
        playSound: Preferences.to.notificationSound,
        ticker: 'VQD ticker');
    var notificationDetails = NotificationDetails(
        androidPlatformChannelSpecifics, null);

    cancelAll();

    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'Quote by ${QuotesStore.to.credits}',
        QuotesStore.to.quote,
        Time(Preferences.to.notificationHour, Preferences.to.notificationMinute),
        notificationDetails,
        payload: 'VQD payload');
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('Notification payload: $payload');
    }
  }

  Notifications() {
    initializationSettingsAndroid = AndroidInitializationSettings('notification');
    initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, null);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  cancelAll() {
    flutterLocalNotificationsPlugin.cancelAll();
  }
}
