import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:vegan_daily_quote/quotes_store.dart';

class Quote extends StatelessWidget {
  final QuotesStore qs = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      child: Card(
        elevation: 4,
        child: InkWell(
          onTap: () async => {
            if (await canLaunch(qs.link)) {await launch(qs.link)}
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
              Obx(() => Expanded(
                    flex: 1,
                    child: Text(
                      '~ ${qs.credits} ~',
                      style:
                          TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
