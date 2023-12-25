// import 'package:flutter/material.dart';

// class AppBarComponent extends StatefulWidget {
//   const AppBarComponent({super.key});

//   @override
//   State<AppBarComponent> createState() => _AppBarComponentState();
// }

// class _AppBarComponentState extends State<AppBarComponent> {
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: const Text('FIFA Zeft'),
//       actions: <Widget>[
//         TextButton(
//             onPressed: () => {Navigator.pushNamed(context, '/home')},
//             child: const Text('Home')),
//         TextButton(
//             onPressed: () => {Navigator.pushNamed(context, '/matches')},
//             child: const Text('Matches')),
//         TextButton(
//             onPressed: () => {Navigator.pushNamed(context, '/login')},
//             child: const Text('Login')),
//         TextButton(
//             onPressed: () => {Navigator.pushNamed(context, '/signup')},
//             child: const Text('Signup')),
//         TextButton(
//             onPressed: () => {Navigator.pushNamed(context, '/about')},
//             child: const Text('About')),
//       ],
//     );
//   }
// }

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
