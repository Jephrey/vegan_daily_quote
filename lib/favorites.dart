import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'i18n/favorites.i18n.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'.i18n),
      ),
    );
  }
}
