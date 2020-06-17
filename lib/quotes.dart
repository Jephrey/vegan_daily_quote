// To parse this JSON data, do
//
//     final quotes = quotesFromJson(jsonString);
// File generated with the help of https://app.quicktype.io/

import 'dart:convert';

List<Quotes> quotesFromJson(String str) => List<Quotes>.from(json.decode(str).map((x) => Quotes.fromJson(x)));

String quotesToJson(List<Quotes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Quotes {
    Quotes({
        this.quote,
        this.credits,
        this.link,
    });

    String quote;
    String credits;
    String link;

    factory Quotes.fromJson(Map<String, dynamic> json) => Quotes(
        quote: json["quote"],
        credits: json["credits"],
        link: json["link"],
    );

    Map<String, dynamic> toJson() => {
        "quote": quote,
        "credits": credits,
        "link": link,
    };
}
