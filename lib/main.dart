import 'package:flutter/material.dart';
import 'package:vegan_daily_quote/calendar.dart';
import 'package:vegan_daily_quote/quote.dart';
import 'package:vegan_daily_quote/quotes.dart';
import 'package:intl/intl.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vegan Daily Quote',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Vegan Daily Quote'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Quotes> _quotes;
  final _dayOfYear = new Random().nextInt(9); //int.parse(DateFormat("D").format(DateTime.now())) % 3;

  Future<List<Quotes>> fetchQuotes(BuildContext context) async {
    final jsonString =
        await DefaultAssetBundle.of(context).loadString('assets/quotes.json');
    return quotesFromJson(jsonString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Calender(),
          FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _quotes = snapshot.data;
                  return Quote(
                    quoteText: _quotes[_dayOfYear].quote,
                    credits: _quotes[_dayOfYear].credits,
                    link: _quotes[_dayOfYear].link,
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
              future: fetchQuotes(context)),
        ],
      ),
    );
  }
}
