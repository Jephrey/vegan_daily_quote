import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
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
      child: FocusedMenuHolder(
        menuWidth: MediaQuery.of(context).size.width * 0.3,
        onPressed: () {},
        menuItems: <FocusedMenuItem>[
          FocusedMenuItem(
              title: Text('Copy'),
              onPressed: () {
                // Copy quote, credits and link to the clipboard.
                Clipboard.setData(new ClipboardData(
                        text: '$_quoteText\n$_credits\n$_link'))
                    .then((_) {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("Quote copied to clipboard")));
                });
              },
              trailingIcon: Icon(Icons.content_copy)),
          FocusedMenuItem(
              title: Text('Share'),
              onPressed: () {},
              trailingIcon: Icon(Icons.share)),
          FocusedMenuItem(
              title: Text('Favorite'),
              onPressed: () {
                setState(() {
                  widget.quoteStore.toggleFavorite();
                });
              },
              trailingIcon: widget.quoteStore.isFavorite()
                  ? Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : Icon(Icons.favorite_border)),
        ],
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: AutoSizeText(
                      _quoteText,
                      style: TextStyle(fontSize: 24),
                      maxLines: 5,
                    ),
                  ),
                  Text(
                    _credits,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
