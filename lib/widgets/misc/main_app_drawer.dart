import 'package:flutter/material.dart';

class MainAppDrawer extends StatelessWidget {
  final Function selectHandler;

  MainAppDrawer(this.selectHandler);

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
              'Kanji Master!!',
              style: TextStyle(
                fontFamily: 'Anton',
                fontSize: 35,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(
            context,
            'Sync now',
            Icons.sync,
            selectHandler,
          ),
          buildListTile(
            context,
            'Settings',
            Icons.settings,
            null,
          ),
          buildListTile(
            context,
            'Badges',
            Icons.badge,
            null,
          ),
          buildListTile(
            context,
            'Feedback',
            Icons.feedback,
            null,
          ),
          buildListTile(
            context,
            'Tutorial',
            Icons.help,
            null,
          ),
        ],
      ),
    );
  }

  Widget buildListTile(
      BuildContext context, String title, IconData icon, Function tapHandler) {
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
      onTap: () {
        // ignore: unnecessary_statements
        tapHandler == null ? null : tapHandler();
        Navigator.pop(context);
      },
    );
  }
}
