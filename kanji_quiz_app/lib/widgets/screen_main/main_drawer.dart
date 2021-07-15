import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:kanji_quiz_app/screens/extra_badges_screen.dart';
import '../../main_providers.dart';

class MainAppDrawer extends ConsumerWidget {
  Widget build(BuildContext context, ScopedReader watch) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: screenHeight * 0.12,
            decoration: BoxDecoration(
              color: Colors.orange[400],
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/decorations/gold_crown.png",
                ),
              ),
            ),
          ),
          Expanded(
            child: drawerListView(context, screenHeight),
          ),
        ],
      ),
    );
  }

  Widget drawerListView(BuildContext ctx, double height) {
    return ListView(
      children: ListTile.divideTiles(
        context: ctx,
        tiles: [
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(
              10,
              0,
              10,
              height * 0.02,
            ),
            title: Text(
              'Sync progress',
              style: TextStyle(
                fontSize: height * 0.03,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Icon(
              Icons.sync,
              size: height * 0.03,
            ),
            onTap: () {
              ctx.read(syncNowProvider).state++;
              Navigator.pop(ctx);
            },
          ),
          buildListTile(
            height,
            'Extra badges',
            Icons.badge,
            () {
              Navigator.pop(ctx);
              Navigator.of(ctx).pushNamed(ExtraBadgesScreen.routeName);
            },
          ),
          buildListTile(
            height,
            'Feedback',
            Icons.feedback,
            () => Navigator.pop(ctx),
          ),
          buildListTile(
            height,
            'Tutorial',
            Icons.help,
            () => Navigator.pop(ctx),
          ),
        ],
      ).toList(),
    );
  }

  Widget buildListTile(height, title, icon, tapHandler) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(
        10,
        height * 0.02,
        10,
        height * 0.02,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: height * 0.03,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Icon(
        icon,
        size: height * 0.03,
      ),
      onTap: tapHandler,
    );
  }
}
