import 'package:auto_size_text/auto_size_text.dart';
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
      height: 200,
      margin: EdgeInsets.all(6),
      child: Card(
        elevation: 4,
        child: InkWell(
          onTap: () async => {
            if (await canLaunch(link) != null) {
                await launch(link)
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: AutoSizeText(
                  quoteText,
                  style: TextStyle(fontSize: 24),
                  maxLines: 5,
                ),
              ),
              Text(
                credits,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
