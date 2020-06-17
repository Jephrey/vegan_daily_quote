import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Calender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var today = DateTime.now();
    var month = DateFormat.MMMM().format(today.toLocal());
    var day = DateFormat.d().format(today.toLocal());

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          margin: EdgeInsets.all(6),
          child: Card(
            color: Colors.white60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  month,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const Divider(thickness: 4,),
                Text(
                  day,
                  style: TextStyle(fontSize: 58, color: Colors.red, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
