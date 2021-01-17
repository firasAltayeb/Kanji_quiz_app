import 'package:flutter/material.dart';

class MainAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Kanji App!',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 35,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(
            'Sync now',
            Icons.sync,
            null,
          ),
          buildListTile(
            'Settings',
            Icons.settings,
            null,
          ),
          buildListTile(
            'Badges',
            Icons.badge,
            null,
          ),
          buildListTile(
            'Feedback',
            Icons.feedback,
            null,
          ),
          buildListTile(
            'Tutorial',
            Icons.help,
            null,
          ),
        ],
      ),
    );
  }

  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Icon(
        icon,
        size: 26,
      ),
      onTap: () {},
    );
  }
}
