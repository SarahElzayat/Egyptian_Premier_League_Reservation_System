import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:web_frontend/src/components/appbar.dart';
import 'package:web_frontend/src/controller/authentication.dart';
import 'package:web_frontend/src/dio/constant_end_points.dart';

class AcceptUsersScreen extends StatefulWidget {
  const AcceptUsersScreen({super.key});

  @override
  State<AcceptUsersScreen> createState() => _AcceptUsersScreenState();
}

class _AcceptUsersScreenState extends State<AcceptUsersScreen> {
  var users = [];
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    // print(token);
    print('$baseUrl/admin/get_appended_users');
    // print(token);
    var headers = {'Content-type': 'application/json', 'token': '$token'};
    // print(headers);
    try {
      final response = await http.get(
          Uri.parse('$baseUrl/admin/get_appended_users'),
          headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        // print(jsonData);
        setState(() {
          users = jsonData['users'];
          // _fetchData();
          // data = jsonData['someKey']; // Change according to your JSON structure
        });
      } else {
        setState(() {
          print(response.statusCode);
          // data = "Failed to load data!";
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        // data = "Error occurred: $e";
      });
    }
  }

  // accept users function
  Future<void> handel_accept_user(BuildContext context, user) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    print(user);
    var headers = {'Content-type': 'application/json', 'token': '$token'};
    try {
      final response = await http.post(Uri.parse('$baseUrl/admin/approve'),
          headers: headers, body: json.encode({'username': user['username']}));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(jsonData);
        setState(() {
          _fetchData();
        });
      } else {
        setState(() {
          print(response.statusCode);
          // data = "Failed to load data!";
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        // data = "Error occurred: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(context,
          // index: 3,
          title: "Accept Users"),
      body: Center(
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.5,
          child: Column(
            children: [
              users.isNotEmpty
                  ? ListView(
                      shrinkWrap: true,
                      children: [
                        for (var user in users)
                          ListTile(
                            title: Text(user['username']),
                            subtitle: Text(user['email']),
                            trailing: ElevatedButton(
                              onPressed: () {
                                handel_accept_user(context, user);
                                // handel_login_admin(context);
                              },
                              child: const Text('Accept'),
                            ),
                          ),
                      ],
                    )
                  : const Text('No users to accept'),
            ],
          ),
        ),
      ),
    );
  }
}
