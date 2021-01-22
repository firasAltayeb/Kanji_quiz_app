import 'package:flutter/material.dart';

class MainAppDrawer extends StatelessWidget {
  final Function selectHandler;

  MainAppDrawer(this.selectHandler);

  @override
  Widget build(BuildContext context) {
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

  Widget drawerListView(BuildContext context, double height) {
    return ListView(
      children: ListTile.divideTiles(
        context: context,
        tiles: [
          buildListTile(
            height,
            'Sync now',
            Icons.sync,
            selectHandler,
          ),
          buildListTile(
            height,
            'Settings',
            Icons.settings,
            selectHandler,
          ),
          buildListTile(
            height,
            'Badges',
            Icons.badge,
            null,
          ),
          buildListTile(
            height,
            'Feedback',
            Icons.feedback,
            null,
          ),
          buildListTile(
            height,
            'Tutorial',
            Icons.help,
            null,
          ),
        ],
      ).toList(),
    );
  }

  Widget buildListTile(var height, var title, var icon, var tapHandler) {
    return ListTile(
      contentPadding: EdgeInsets.all(20),
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
