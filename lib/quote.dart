import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:vegan_daily_quote/quotes_store.dart';

class Quote extends StatefulWidget {
  final QuotesStore quoteStore;

  Quote({Key key, this.quoteStore}) : super(key: key);

  @override
  _QuoteState createState() => _QuoteState();
}

class _QuoteState extends State<Quote> {
  @override
  Widget build(BuildContext context) {
    String _quoteText = widget.quoteStore.quote['quote'];
    String _link = widget.quoteStore.quote['link'];
    String _credits = widget.quoteStore.quote['credits'];

    return Expanded(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(6),
        child: Card(
          elevation: 4,
          child: InkWell(
            onTap: () async => {
              if (await canLaunch(_link)) {await launch(_link)}
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                    child: AutoSizeText(
                      _quoteText,
                      style: TextStyle(fontSize: 24),
                      maxLines: 10,
                    ),
                  ),
                ),
                Text(
                  '~ $_credits ~',
                  style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height:20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
