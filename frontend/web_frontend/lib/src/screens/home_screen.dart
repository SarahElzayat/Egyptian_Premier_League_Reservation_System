import 'package:flutter/material.dart';
import 'package:web_frontend/src/components/appbar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(context,
          // index: 1,
          title: "Home"),
      // title: "Home",
      body: Center(
          child: Column(
        children: [
          Image.network(
              'https://media4.giphy.com/media/C2TugL3IThkO4jT5iv/giphy.gif?cid=6c09b952cug8a1dd0o4hevx621l5wlw7jfjb06fz9y8zcfc3&ep=v1_stickers_related&rid=giphy.gif&ct=s'),
        ],
      )),
    );
  }
}
