import 'package:flutter/material.dart';
import 'package:web_frontend/src/components/appbar.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(context, index: 4),
      body: Center(
        child: Text('Welcome to the About Screen!'),
      ),
    );
  }
}
