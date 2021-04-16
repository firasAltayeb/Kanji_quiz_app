import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/model/kanji_model.dart';
import 'package:flutter/material.dart';
import '../../main_providers.dart';

class KanjiInteractiveRow extends ConsumerWidget {
  final double widgetHeight;
  final List<Kanji> kanjiList;
  final Function selectHandler;

  KanjiInteractiveRow({
    @required this.kanjiList,
    @required this.widgetHeight,
    @required this.selectHandler,
  });

  Widget build(BuildContext context, ScopedReader watch) {
    return SizedBox(
      height: widgetHeight,
      child: GridView.builder(
          itemCount: kanjiList.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: widgetHeight,
            childAspectRatio: 1.25,
          ),
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, i) {
            return InkWell(
              onTap: selectHandler == null
                  ? null
                  : () => selectHandler(
                        context,
                        kanjiList[i],
                      ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Ink(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          watch(templateAddressProvider(kanjiList[i])),
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  if (kanjiList[i].itemType != "Primitive")
                    Container(
                      height: widgetHeight * 0.65,
                      child: Text(
                        kanjiList[i].characterLook,
                        style: TextStyle(
                          fontSize: widgetHeight * 0.4,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }),
    );
  }
}
