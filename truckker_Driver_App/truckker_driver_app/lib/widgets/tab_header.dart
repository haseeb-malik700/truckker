import 'package:flutter/material.dart';

class TabHeader extends StatelessWidget {
  final IconData icon;
  final String tabText;

  const TabHeader({Key key, this.icon, this.tabText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(icon),
        Text(tabText, style: TextStyle(letterSpacing: 1.25))
      ],
    );
  }
}
