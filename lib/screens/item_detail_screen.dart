import 'package:Kanji_quiz_app/widgets/shared/main_app_bar.dart';
import 'package:flutter/material.dart';

class ItemDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: 'Item Details',
        appBar: AppBar(),
      ),
      body: Center(
        child: Text('hi there'),
      ),
    );
  }
}
