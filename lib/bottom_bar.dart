import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';
import 'package:vegan_daily_quote/quotes_store.dart';

class BottomBar extends StatelessWidget {
  final QuotesStore qs = Get.find();

  @override
  Widget build(BuildContext context) {
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
                      text: '${qs.quote}\n${qs.credits}\n${qs.link}'))
                  .then((_) {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text("Quote copied to clipboard")));
              });
            },
            child: Icon(Icons.content_copy),
          ),
        ),
        if (!kIsWeb)
          Tooltip(
            message: 'Share Quote',
            child: FlatButton(
              onPressed: () {
                Share.share('${qs.quote}\n${qs.credits}\n',
                    subject: 'Vegan Daily Quote');
              },
              child: Icon(Icons.share),
            ),
          ),
        Tooltip(
          message: 'Open link',
          child: FlatButton(
            onPressed: () async => {
              if (await canLaunch(qs.link)) {await launch(qs.link)}
            },
            child: Icon(Icons.link),
          ),
        ),
        Tooltip(
          message: 'Toggle favorite',
          child: FlatButton(
            onPressed: () {
              qs.toggleFavorite();
            },
            child: Obx(
              () => qs.isFavorite
                  ? Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : Icon(
                      Icons.favorite_border,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
