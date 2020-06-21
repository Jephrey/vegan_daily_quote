import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vegan_daily_quote/bottom_bar.dart';
import 'package:vegan_daily_quote/calendar.dart';
import 'package:vegan_daily_quote/quote.dart';
import 'package:vegan_daily_quote/quotes_store.dart';
import 'package:vegan_daily_quote/settings.dart';
import 'package:vegan_daily_quote/theme_controller.dart';

void main() {
  Get.lazyPut<ThemeController>(() => ThemeController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final QuotesStore qs = Get.put(QuotesStore.random());

  @override
  Widget build(BuildContext context) {
    ThemeController.to.getThemeModeFromPreferences();
    return Obx(
      () => GetMaterialApp(
        title: 'Vegan Daily Quote',
        theme: ThemeData.light().copyWith(primaryColor: Colors.lightGreen),
        darkTheme: ThemeData.dark().copyWith(primaryColor: Colors.green),
        themeMode: ThemeController.to.theme.value,
        home: Home(title: 'Vegan Daily Quote'),
      ),
    );
  }
}

class Home extends StatelessWidget {
  final String title;
  final QuotesStore qs = Get.find();
  Home({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ThemeController.to.setThemeMode(ThemeMode.dark);
    //print('${Theme.of(context).brightness}');

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh),
            onPressed: () {
              qs.random();
            },
          ),
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(Icons.settings),
            onPressed: () {
              Get.to(SettingsPage());
            },
          ),
          IconButton(
            tooltip: 'About',
            icon: const Icon(Icons.info),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationIcon: const Icon(Icons.calendar_today),
                applicationName: title,
                applicationVersion: '0.5.0',
                applicationLegalese: '©2020 Jeffrey Rüsterholz Ⓥ',
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Calender(),
          Quote(),
          BottomBar(),
        ],
      ),
    );
  }
}
