import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../main_providers.dart';

class ShowAnswerButton extends ConsumerWidget {
  @override
  Widget build(BuildContext bldCtx, ScopedReader watch) {
    var screenHeight = MediaQuery.of(bldCtx).size.height * 0.35;
    return Container(
      width: double.infinity,
      height: screenHeight,
      child: ElevatedButton(
        child: Text(
          "Show Answer",
          style: TextStyle(
            fontSize: screenHeight * 0.15,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () => bldCtx.read(showAnsBtnVisibleProvider).state = false,
      ),
    );
  }
}