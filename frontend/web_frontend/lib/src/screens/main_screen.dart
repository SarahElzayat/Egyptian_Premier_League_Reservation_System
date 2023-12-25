import 'package:flutter/material.dart';
import 'package:web_frontend/src/components/appbar.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FIFA Zeft'),
        actions: <Widget>[
          TextButton(
              onPressed: () => {Navigator.pushNamed(context, '/home')},
              child: const Text('Home')),
          TextButton(
              onPressed: () => {Navigator.pushNamed(context, '/matches')},
              child: const Text('Matches')),
          TextButton(
              onPressed: () => {Navigator.pushNamed(context, '/login')},
              child: const Text('Login')),
          TextButton(
              onPressed: () => {Navigator.pushNamed(context, '/signup')},
              child: const Text('Signup')),
          TextButton(
              onPressed: () => {Navigator.pushNamed(context, '/about')},
              child: const Text('About')),
        ],
      ),
      body: Center(
        child: Text(
          'Aaaah',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
