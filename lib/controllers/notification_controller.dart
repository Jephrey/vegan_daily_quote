import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:get/get.dart';
import 'package:vegan_daily_quote/controllers/preferences_controller.dart';
import 'package:vegan_daily_quote/controllers/quotes_controller.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationController {
  static NotificationController get to => Get.find<NotificationController>();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid;
  var initializationSettings;

  Future<void> setNotification() async {
    cancelAll();

    tz.initializeTimeZones();
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    // If the notification time is before the current time then
    // use tomorrow's quote.
    final _hour = PreferencesController.to.notificationHour;
    final _min = PreferencesController.to.notificationMinute;

    String _quote;
    String _credits;

    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, _hour, _min);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
      List<String> _tomorrow = QuotesController.to.tomorrowsQuote;
      _quote = _tomorrow[0];
      _credits = _tomorrow[1];
    } else {
      _quote = QuotesController.to.quote;
      _credits = QuotesController.to.credits;
    }

    var bigTextStyleInformation = BigTextStyleInformation('<i>$_quote</i>',
        htmlFormatBigText: true,
        contentTitle: '<b>$_credits</b>',
        htmlFormatContentTitle: true);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'vdq 1', 'channel vdq', 'Vegan Daily Quote',
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
        playSound: PreferencesController.to.notificationSoundEnabled,
        styleInformation: bigTextStyleInformation,
        ticker: 'VDQ ticker');
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      '',
      '',
      scheduledDate,
      platformChannelSpecifics,
      payload: 'VDQ payload',
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  Future onSelectNotification(String? payload) async {
    debugPrint('Notification payload: $payload');
    setNotification(); // Set for next day.
  }

  NotificationController() {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('notification');
    final initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future<void> cancelAll() async {
    flutterLocalNotificationsPlugin.cancelAll();
  }
}
