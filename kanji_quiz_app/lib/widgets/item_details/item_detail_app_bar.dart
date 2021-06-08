import 'package:kanji_quiz_app/model/learning_item_model.dart';
import 'package:kanji_quiz_app/helper_functions.dart';
import 'package:flutter/material.dart';

class ItemDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final LearningItem targetKanji;

  ItemDetailAppBar({
    Key key,
    this.appBar,
    this.targetKanji,
  }) : super(key: key);

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return AppBar(
      title: Text(
        'Item detail Page',
        style: TextStyle(
          fontSize: screenHeight * 0.03,
          fontFamily: 'Anton',
        ),
      ),
      actions: [
        PopupMenuButton(
          onSelected: (choice) => choiceAction(
            choice: choice,
            context: context,
            targetKanji: targetKanji,
          ),
          icon: Icon(
            Icons.more_vert,
          ),
          itemBuilder: (_) => [
            PopupMenuItem(
              value: VertOptions.Koohii,
              child: Text(
                'Search in Koohii',
                style: TextStyle(
                  fontSize: screenHeight * 0.03,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
