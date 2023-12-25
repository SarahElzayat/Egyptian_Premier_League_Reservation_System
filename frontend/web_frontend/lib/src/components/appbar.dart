import 'package:flutter/material.dart';

class AppBarComponent extends StatefulWidget {
  const AppBarComponent({super.key});

  @override
  State<AppBarComponent> createState() => _AppBarComponentState();
}

class _AppBarComponentState extends State<AppBarComponent> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }
}
