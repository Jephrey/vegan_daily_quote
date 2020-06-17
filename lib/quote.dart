import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Quote extends StatelessWidget {
  final String quoteText;
  final String credits;
  final String link;

  const Quote({Key key, this.quoteText, this.credits, this.link})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 220,
      margin: EdgeInsets.all(8),
      child: Card(
        child: InkWell(
          onTap: () async => {
            if (await canLaunch(link) != null) {
                await launch(link)
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.all(4),
                child: Text(
                  quoteText,
                  overflow: TextOverflow.clip,
                  style: TextStyle(fontSize: 22),
                  textAlign: TextAlign.left,
                ),
              ),
              const Divider(
                indent: 20,
                endIndent: 20,
              ),
              Text(
                credits,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
