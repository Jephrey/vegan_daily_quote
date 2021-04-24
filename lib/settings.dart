import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vegan_daily_quote/notifications.dart';
import 'package:vegan_daily_quote/preferences.dart';

import 'package:vegan_daily_quote/theme_controller.dart';

import 'i18n/settings.i18n.dart';

class SettingsPage extends StatelessWidget {
  Future<TimeOfDay> selectTime(BuildContext context) async {
    return await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
          hour: Preferences.to.notificationHour,
          minute: Preferences.to.notificationMinute),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'.i18n),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Theme Mode'.i18n,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              RadioListTile(
                title: Text('System'.i18n),
                value: ThemeMode.system,
                groupValue: ThemeController.to.themeMode,
                onChanged: (value) {
                  ThemeController.to.setThemeMode(value);
                },
              ),
              RadioListTile(
                title: Text('Dark'.i18n),
                value: ThemeMode.dark,
                groupValue: ThemeController.to.themeMode,
                onChanged: (value) {
                  ThemeController.to.setThemeMode(value);
                },
              ),
              RadioListTile(
                  title: Text('Light'.i18n),
                  value: ThemeMode.light,
                  groupValue: ThemeController.to.themeMode,
                  onChanged: (value) {
                    ThemeController.to.setThemeMode(value);
                  }),
                Text(
                  'Notifications'.i18n,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                SwitchListTile(
                  value: Preferences.to.notifications,
                  title: Text('Receive Notifications'.i18n),
                  onChanged: (value) {
                    Preferences.to.notifications = value;
                    if (value) {
                      Notifications.to.setNotification();
                    } else {
                      Notifications.to.cancelAll();
                    }
                  },
                ),
              SwitchListTile(
                value: Preferences.to.notificationSoundEnabled,
                title: Text('Notification Sound'.i18n),
                onChanged: (value) {
                  Preferences.to.notificationSoundEnabled = value;
                },
              ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Notification Time: '.i18n,
                      ),
                      FlatButton(
                        onPressed: () {
                          selectTime(context).then((time) => {
                                if (time != null)
                                  {
                                    Preferences.to.notificationHour = time.hour,
                                    Preferences.to.notificationMinute =
                                        time.minute,
                                    Notifications.to.setNotification(),
                                    debugPrint(
                                        'Time set: ${time.hour}:${time.minute}')
                                  }
                              });
                        },
                        child: Text(TimeOfDay(
                            hour: Preferences.to.notificationHour,
                            minute: Preferences.to.notificationMinute)
                            .format(context)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
