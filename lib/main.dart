import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

import 'package:vegan_daily_quote/bottom_bar.dart';
import 'package:vegan_daily_quote/calendar.dart';
import 'package:vegan_daily_quote/notifications.dart';
import 'package:vegan_daily_quote/preferences.dart';
import 'package:vegan_daily_quote/quote.dart';
import 'package:vegan_daily_quote/quotes_store.dart';
import 'package:vegan_daily_quote/settings.dart';
import 'package:vegan_daily_quote/theme_controller.dart';

import 'i18n/main.i18n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureLocalTimeZone();

  await GetStorage.init();
  Get.lazyPut<ThemeController>(() => ThemeController());
  Get.lazyPut<QuotesStore>(() => QuotesStore());
  Get.lazyPut<Preferences>(() => Preferences());
  if (!kIsWeb) Get.put(Notifications());
  runApp(MyApp());
}

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
  debugPrint('Timezone: $currentTimeZone');
  tz.setLocalLocation(tz.getLocation(currentTimeZone));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeController.to.getThemeMode();
    const _appTitle = 'Vegan Daily Quote';
    return GetMaterialApp(
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
      home: I18n(child: MyHome(title: _appTitle)),
    );
  }
}

class MyHome extends StatefulWidget {
  final String title;
  
  MyHome({Key key, this.title}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final QuotesStore qs = Get.put(QuotesStore());

  @override
  void initState() {
    super.initState();

    if (!kIsWeb) Notifications.to.setNotification();
  }

  @override
  Widget build(BuildContext context) {
    SystemChannels.lifecycle.setMessageHandler((msg) {
      debugPrint('SystemChannels> $msg');
      if (msg.contains('resumed')) {
        QuotesStore.to.quoteOfTheDay();
        setState(() {});
      }
      return null;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            tooltip: 'Refresh'.i18n,
            icon: const Icon(Icons.repeat),
            onPressed: () {
              qs.random();
            },
          ),
          IconButton(
            tooltip: 'Settings'.i18n,
            icon: const Icon(Icons.settings),
            onPressed: () {
              Get.to(SettingsPage());
            },
          ),
          IconButton(
            tooltip: 'About'.i18n,
            icon: const Icon(Icons.info),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationIcon: const Icon(Icons.calendar_today),
                applicationName: widget.title,
                applicationVersion: '0.6.0',
                applicationLegalese: '©2020 Jeffrey Rüsterholz Ⓥ',
              );
            },
          ),
        ],
      ),
      body: _layoutRotation(),
    );
  }

  Widget _layoutRotation() {
    Orientation orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.portrait) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Calender(),
          Expanded(
            flex: 5,
            child: Quote(),
          ),
          Expanded(
            flex: 1,
            child: BottomBar(),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            children: [
              Calender(),
            ],
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Quote(),
                ),
                Expanded(flex: 1, child: BottomBar()),
              ],
            ),
          ),
        ],
      );
    }
  }
}


