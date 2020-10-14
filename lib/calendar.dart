import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'i18n/calendar.i18n.dart';

class Calender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var today = DateTime.now();
    var month = DateFormat.MMMM().format(today.toLocal()).toUpperCase().i18n;
    var day = DateFormat.d().format(today.toLocal());

    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: 140.0,
      margin: EdgeInsets.all(4),
      child: Card(
        color: Colors.white,
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AutoSizeText(
              month,
              style: TextStyle(
                fontSize: 16,
                color: ThemeData.fallback().textTheme.headline1.color,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              // textAlign: TextAlign.center,
            ),
            const Divider(
              thickness: 3,
              color: Colors.black12,
            ),
            AutoSizeText(
              day,
              style: TextStyle(
                  fontSize: 60,
                  color: Colors.red,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxFontSize: 70,
            ),
          ],
        ),
      ),
    );
  }
}
