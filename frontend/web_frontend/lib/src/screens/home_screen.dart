import 'package:flutter/material.dart';
import 'package:web_frontend/src/components/appbar.dart';

class HomeScreen extends StatelessWidget {
  List routes = [
    // {
    //   'name': 'Home',
    //   'route': '/home',
    // },
    {
      'name': 'Upcoming Matches',
      'route': '/upcoming_matches',
    },
    {
      'name': 'Previous Matches',
      'route': '/previous_matches',
    },
    {
      'name': 'Add Matches',
      'route': '/add_match',
    },
    {'name': 'Add Stadium', 'route': '/add_stadium'}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(context,
          // index: 1,
          title: "Home"),
      // title: "Home",
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(
              'https://media4.giphy.com/media/C2TugL3IThkO4jT5iv/giphy.gif?cid=6c09b952cug8a1dd0o4hevx621l5wlw7jfjb06fz9y8zcfc3&ep=v1_stickers_related&rid=giphy.gif&ct=s',
            ),
            Center(
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.3,
                child: ListView.builder(
                  itemCount: routes.length,
                  itemBuilder: (context, index) {
                    // Extract the name and route for each item.
                    final routeInfo = routes[index];
                    final name = routeInfo['name'] ?? 'Unnamed';
                    final route = routeInfo['route'];

                    return PrettyCard(
                      name: name,
                      onTap: () {
                        // Navigate to the route when tapped.
                        if (route != null) {
                          Navigator.pushNamed(context, route);
                        } else {
                          // Handle the case where the route is null.
                          print('Route for $name is not defined.');
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        // ],
        // )
      ),
    );
  }
}

class PrettyCard extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  PrettyCard({required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 10,
        shadowColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          width: 100,
          height: 100,
          padding: EdgeInsets.all(16),
          child: Center(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
