import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../widgets/main_screen/main_screen_app_bar.dart';

class BadgesScreen extends ConsumerWidget {
  static const routeName = '/badges-screen';
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: MainScreenAppBar(
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
