import 'package:flutter/material.dart';
import 'package:web_frontend/src/components/appbar.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(context, index: 3),
      body: Center(
        child: Text('Welcome to the SignUp Screen!'),
      ),
    );
  }
}
