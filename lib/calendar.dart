import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Calender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var today = DateTime.now();
    var month = DateFormat.MMMM().format(today.toLocal()).toUpperCase();
    var day = DateFormat.d().format(today.toLocal());

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          margin: EdgeInsets.all(4),
          child: Card(
            color: Colors.white,
            elevation: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AutoSizeText(
                  month,
                  style: TextStyle(fontSize: 16),
                  maxLines: 1,
                  // textAlign: TextAlign.center,
                ),
                const Divider(
                  thickness: 3,
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
        ),
        Container(
          width: 120.0,
          height: 120.0,
          margin: EdgeInsets.all(4),
        ),
      ],
    );
  }
}
