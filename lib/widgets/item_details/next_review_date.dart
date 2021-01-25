import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:Kanji_quiz_app/widgets/shared/key_text_container.dart';

class NextReviewDate extends StatelessWidget {
  final DateTime dateChanged;
  final Map<String, Object> selectedItem;

  NextReviewDate(this.selectedItem, this.dateChanged);

  @override
  Widget build(BuildContext context) {
    var textContainer;
    var leadingText = 'Next review date: ';
    var dateFormater = DateFormat('dd/MM/yyyy HH:mm');

    switch (selectedItem['progressLevel']) {
      case 1:
        textContainer = KeyTextContainer(
          '$leadingText' +
              '${dateFormater.format(dateChanged.add(Duration(hours: 4)))}',
        );
        break;
      case 2:
        textContainer = KeyTextContainer(
          '$leadingText' +
              '${dateFormater.format(dateChanged.add(Duration(hours: 12)))}',
        );
        break;
      case 3:
        textContainer = KeyTextContainer(
          '$leadingText' +
              '${dateFormater.format(dateChanged.add(Duration(days: 2)))}',
        );
        break;
      case 4:
        textContainer = KeyTextContainer(
          '$leadingText' +
              '${dateFormater.format(dateChanged.add(Duration(days: 4)))}',
        );
        break;
      default:
        textContainer = KeyTextContainer(
          '$leadingText Learned item',
        );
        break;
    }
    return textContainer;
  }
}
