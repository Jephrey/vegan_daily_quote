import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'package:vegan_daily_quote/bottom_bar.dart';
import 'package:vegan_daily_quote/calendar.dart';
import 'package:vegan_daily_quote/preferences.dart';
import 'package:vegan_daily_quote/quote.dart';
import 'package:vegan_daily_quote/quotes_store.dart';
import 'package:vegan_daily_quote/settings.dart';
import 'package:vegan_daily_quote/theme_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut<ThemeController>(() => ThemeController());
  Get.lazyPut<QuotesStore>(() => QuotesStore());
  Get.lazyPut<Preferences>(() => Preferences());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeController.to.getThemeMode();
    const _appTitle = 'Vegan Daily Quote';
    return GetMaterialApp(
      title: _appTitle,
      theme: ThemeData.light().copyWith(primaryColor: Colors.lightGreen),
      darkTheme: ThemeData.dark().copyWith(primaryColor: Colors.green),
      themeMode: ThemeController.to.theme.value,
      home: MyHome(title: _appTitle),
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
  final QuotesStore qs = Get.put(QuotesStore.random());

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid;
  var initializationSettingsIOS;
  var initializationSettings;

  Future<void> _quoteNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel id', 'channel name', 'channel description',
        importance: Importance.None,
        priority: Priority.Low,
        ticker: 'vdq ticker');
    var iOSChannelSpecifics = IOSNotificationDetails();
    var notificationDetails = NotificationDetails(
        androidPlatformChannelSpecifics, iOSChannelSpecifics);

    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'Quote by ${QuotesStore.to.credits}',
        QuotesStore.to.quote,
        Time(12),
        notificationDetails,
        payload: 'vdq payload');
  }

  @override
  void initState() {
    super.initState();
    initializationSettingsAndroid = AndroidInitializationSettings('icon');
    initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    _quoteNotification();
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('Notification payload: $payload');
    }
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(body),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('Ok'),
                  onPressed: () async {
                    Navigator.of(context, rootNavigator: true).pop();
                    await Navigator.push(
                        context, MaterialPageRoute(builder: (context) => null));
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            icon: const Icon(Icons.repeat),
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
                applicationName: widget.title,
                applicationVersion: '0.5.0',
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
