import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:vegan_daily_quote/quotes_store.dart';

class Quote extends StatelessWidget {
  final QuotesStore qs = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(6),
        child: Card(
          elevation: 4,
          child: InkWell(
            onTap: () async => {
              if (await canLaunch(qs.link)) {await launch(qs.link)}
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                    child: Obx(() => AutoSizeText(
                          qs.quote,
                          style: TextStyle(fontSize: 24),
                          maxLines: 10,
                        )),
                  ),
                ),
                Obx(() => Text(
                      '~ ${qs.credits} ~',
                      style:
                          TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                    )),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
