import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:vegan_daily_quote/pages/home_page.dart';
import 'dart:ui';

import 'package:vegan_daily_quote/notifications.dart';
import 'package:vegan_daily_quote/controllers/preferences_controller.dart';
import 'package:vegan_daily_quote/controllers/quotes_controller.dart';
import 'package:vegan_daily_quote/controllers/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  Get.lazyPut<ThemeController>(() => ThemeController());
  Get.lazyPut<QuotesController>(() => QuotesController());
  Get.lazyPut<PreferencesController>(() => PreferencesController());

  if (!kIsWeb) Get.put(Notifications());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeController.to.getThemeMode();
    const _appTitle = 'Vegan Daily Quote';
    return GetMaterialApp(
      onReady: () async {
        // Get and set the locale.
        Intl.defaultLocale = window.locale.languageCode;
        await initializeDateFormatting(window.locale.countryCode);
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', "US"),
        const Locale('nl', "NL"),
        const Locale('de', "DE"),
      ],
      title: _appTitle,
      theme: ThemeData.light().copyWith(primaryColor: Colors.lightGreen),
      darkTheme: ThemeData.dark().copyWith(primaryColor: Colors.green),
      themeMode: ThemeController.to.theme.value,
      home: I18n(child: HomePage(_appTitle)),
    );
  }
}
