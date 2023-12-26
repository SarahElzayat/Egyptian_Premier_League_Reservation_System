
import 'package:flutter/material.dart';

final screensTitles = ['Home', 'Matches', 'Login', 'Sign Up', 'About', 'FIFA'];

AppBar AppBarComponent(context, {index = 5, title = "FIFA"}) {
  return AppBar(
    title: Text(title),
    automaticallyImplyLeading: false,
    actions: <Widget>[
      TextButton(
          onPressed: () => {Navigator.pushNamed(context, '/home')},
          child: const Text('Home')),
      TextButton(
          onPressed: () => {Navigator.pushNamed(context, '/upcoming_matches')},
          child: const Text('Upcoming Matches')),
      TextButton(
          onPressed: () => {Navigator.pushNamed(context, '/previous_matches')},
          child: const Text('Previous Matches')),
      TextButton(
          onPressed: () => {Navigator.pushNamed(context, '/add_match')},
          child: const Text('Add Matches')),
      TextButton(
          onPressed: () => {Navigator.pushNamed(context, '/login')},
          child: const Text('Login')),
      TextButton(
          onPressed: () => {Navigator.pushNamed(context, '/signup')},
          child: const Text('Signup')),
      TextButton(
          onPressed: () => {Navigator.pushNamed(context, '/about')},
          child: const Text('About')),
      TextButton(
          onPressed: () => {Navigator.pushNamed(context, '/profile')},
          child: const Text('profile')),
    ],
  );
}
