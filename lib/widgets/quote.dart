import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../i18n/quote.i18n.dart';

import 'package:vegan_daily_quote/controllers/quotes_store.dart';

class Quote extends StatelessWidget {
  final QuotesController qs = Get.find<QuotesController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      child: Card(
        elevation: 4,
        child: InkWell(
          onLongPress: () {
            final String _link =
                qs.link.length > 0 ? qs.link : "No link available.".i18n;
            Get.snackbar(
              "Link to quote".i18n,
              _link,
              snackStyle: SnackStyle.FLOATING,
              snackPosition: SnackPosition.BOTTOM,
              icon: Icon(Icons.link),
              shouldIconPulse: true,
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Obx(() => AutoSizeText(
                        qs.quote,
                        minFontSize: 12,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 24),
                        maxLines: 8,
                      )),
                ),
              ),
              Obx(
                () => Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      '~ ${qs.credits} ~',
                      style:
                          TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
