import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';
import '../i18n/bottom_bar.i18n.dart';

import 'package:vegan_daily_quote/controllers/quotes_controller.dart';

class BottomBar extends StatelessWidget {
  final QuotesController qs = Get.find();

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Tooltip(
          message: 'Copy Quote'.i18n,
          child: FlatButton(
            onPressed: () {
              // Copy quote, credits and link to the clipboard.
              Clipboard.setData(new ClipboardData(
                      text: '${qs.quote}\n${qs.credits}\n${qs.link}'))
                  .then((_) {
                Get.snackbar(
                  'Vegan Daily Quote',
                  "Quote copied to clipboard".i18n,
                  snackPosition: SnackPosition.BOTTOM,
                  icon: Icon(Icons.content_copy),
                  shouldIconPulse: true,
                );
              });
            },
            child: Icon(Icons.content_copy),
          ),
        ),
        if (!kIsWeb)
          Tooltip(
            message: 'Share Quote'.i18n,
            child: FlatButton(
              onPressed: () {
                Share.share('${qs.quote}\n${qs.credits}\n',
                    subject: 'Vegan Daily Quote');
              },
              child: Icon(Icons.share),
            ),
          ),
        Tooltip(
          message: 'Open link'.i18n,
          child: Obx(
            () => FlatButton(
              // Enable button if there is a link. Null disables the button.
              onPressed: qs.link.length > 0
                  ? () async =>
                      {if (await canLaunch(qs.link)) await launch(qs.link)}
                  : null,
              child: Icon(Icons.link),
            ),
          ),
        ),
        Tooltip(
          message: 'Toggle favorite'.i18n,
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
