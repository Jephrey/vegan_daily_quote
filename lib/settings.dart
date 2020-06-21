import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vegan_daily_quote/theme_controller.dart';


class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[  
          Text(
            'Theme Mode',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.left,
          ),
          RadioListTile(
            title: Text('System'),
            value: ThemeMode.system,
            groupValue: ThemeController.to.themeMode,
            onChanged: (value) {
              ThemeController.to.setThemeMode(value);
            },
          ),
          RadioListTile(
            title: Text('Dark'),
            value: ThemeMode.dark,
            groupValue: ThemeController.to.themeMode,
            onChanged: (value) {
                ThemeController.to.setThemeMode(value);
              },
          ),
          RadioListTile(
            title: Text('Light'),
            value: ThemeMode.light,
            groupValue: ThemeController.to.themeMode,
            onChanged: (value) {
                ThemeController.to.setThemeMode(value);
              }
          ),
        ],
      ),
    ));
  }
}
