import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../main_providers.dart';

class ShowAnswerButton extends ConsumerWidget {
  @override
  Widget build(BuildContext bldCtx, ScopedReader watch) {
    var screenHeight = MediaQuery.of(bldCtx).size.height;
    return Container(
      width: double.infinity,
      height: screenHeight * 0.35,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        gradient: LinearGradient(
          colors: [
            Colors.yellow[700],
            Colors.orange[400],
          ],
        ),
      ),
      child: TextButton(
        child: Text(
          "Show Answer",
          style: TextStyle(
            fontSize: screenHeight * 0.05,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        onPressed: () {
          HapticFeedback.vibrate();
          bldCtx.read(showAnsBtnVisibleProvider).state = false;
        },
      ),
    );
  }
}
