import 'package:Kanji_quiz_app/widgets/shared/main_app_bar.dart';
import 'package:flutter/material.dart';

class ItemDetailScreen extends StatelessWidget {
  final dynamic selectedItem;

  ItemDetailScreen(this.selectedItem);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: 'Item Details',
        appBar: AppBar(),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              kanjiPicture(
                selectedItem['colorPhotoAddress'],
                MediaQuery.of(context).size.width * 0.4,
                MediaQuery.of(context).size.height * 0.3,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget kanjiPicture(String address, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(address),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
