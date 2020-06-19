import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:vegan_daily_quote/quotes_store.dart';

class BottomBar extends StatefulWidget {
  final QuotesStore quoteStore;

  BottomBar({Key key, this.quoteStore}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    String _quoteText = widget.quoteStore.quote['quote'];
    String _link = widget.quoteStore.quote['link'];
    String _credits = widget.quoteStore.quote['credits'];

    return ButtonBar(
      alignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Tooltip(
          message: 'Copy Quote',
          child: FlatButton(
              onPressed: () {
                // Copy quote, credits and link to the clipboard.
                Clipboard.setData(new ClipboardData(
                        text: '$_quoteText\n$_credits\n$_link'))
                    .then((_) {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("Quote copied to clipboard")));
                });
              },
              child: Icon(Icons.content_copy)),
        ),
        Tooltip(
            message: 'Share Quote',
            child: FlatButton(
                onPressed: () {
                  Share.share('$_quoteText\n$_credits\n', subject: 'Vegan Daily Quote');
                },
                child: Icon(Icons.share))),
        Tooltip(
            message: 'Open link',
            child: FlatButton(
                onPressed: () async => {
                      if (await canLaunch(_link)) {await launch(_link)}
                    },
                child: Icon(Icons.link))),
        Tooltip(
          message: 'Toggle favorite',
          child: FlatButton(
              onPressed: () {
                setState(() {
                  widget.quoteStore.toggleFavorite();
                });
              },
              child: widget.quoteStore.isFavorite()
                  ? Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : Icon(Icons.favorite, color: Colors.grey,)),
        ),
      ],
    );
  }
}
