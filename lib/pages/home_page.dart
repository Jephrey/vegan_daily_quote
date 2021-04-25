import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:vegan_daily_quote/controllers/quotes_controller.dart';
import 'package:vegan_daily_quote/pages/settings_page.dart';
import 'package:vegan_daily_quote/widgets/bottom_bar.dart';
import 'package:vegan_daily_quote/widgets/calendar.dart';
import 'package:vegan_daily_quote/widgets/quote.dart';
import 'package:vegan_daily_quote/i18n/homepage.i18n.dart';

class HomePage extends StatelessWidget {
  final String title;

  HomePage(this.title);

  @override
  Widget build(BuildContext context) {
    final QuotesController qs = Get.put(QuotesController());

    // SystemChannels.lifecycle.setMessageHandler((msg) {
    //   debugPrint('SystemChannels> $msg');
    //   if (msg!.contains('resumed')) {
    //     QuotesController.to.quoteOfTheDay();
    //     setState(() {});
    //   }
    //   return;
    // });

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
              Get.to(() => SettingsPage());
            },
          ),
          IconButton(
            tooltip: 'About'.i18n,
            icon: const Icon(Icons.info),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationIcon: const Icon(Icons.calendar_today),
                applicationName: title,
                applicationVersion: '0.7.0',
                applicationLegalese: '©2021 Jeffrey Rüsterholz Ⓥ',
              );
            },
          ),
        ],
      ),
      body: _layoutRotation(context),
    );
  }

  Widget _layoutRotation(BuildContext context) {
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
