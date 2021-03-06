// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:vegan_daily_quote/controllers/preferences_controller.dart';
import 'package:vegan_daily_quote/widgets/quote.dart';
import 'package:vegan_daily_quote/controllers/quotes_controller.dart';

void main() {
  Get.lazyPut<QuotesController>(() => QuotesController());
  Get.lazyPut<PreferencesController>(() => PreferencesController());

  // Quote should contain text.
  testWidgets('Quote should be created.', (WidgetTester tester) async {
    final quote = Quote();

    await tester.pumpWidget(
        MaterialApp(
          home: Container(child: quote),
        ),
        Duration(milliseconds: 300));
    expect(find.byWidget(quote), findsOneWidget);
  });
}
