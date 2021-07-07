import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:kanji_quiz_app/screens/badges_screen.dart';
import '../../main_providers.dart';

class MainAppDrawer extends ConsumerWidget {
  Widget build(BuildContext context, ScopedReader watch) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: screenHeight * 0.15,
            padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Kanji Master!!',
              style: TextStyle(
                fontFamily: 'Anton',
                fontSize: screenHeight * 0.04,
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
          buildListTile(
            height,
            'Sync now',
            Icons.sync,
            () {
              ctx.read(syncNowProvider).state++;
              Navigator.pop(ctx);
            },
          ),
          buildListTile(
            height,
            'Badges',
            Icons.badge,
            () => Navigator.of(ctx).pushNamed(BadgesScreen.routeName),
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

  Widget buildListTile(var height, var title, var icon, var tapHandler) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(
        10,
        height * 0.025,
        10,
        height * 0.025,
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
