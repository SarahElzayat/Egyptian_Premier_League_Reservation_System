import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:web_frontend/src/components/appbar.dart';
import 'package:web_frontend/src/controller/authentication.dart';
import 'package:web_frontend/src/dio/constant_end_points.dart';

class DeleteUsersScreen extends StatefulWidget {
  const DeleteUsersScreen({super.key});

  @override
  State<DeleteUsersScreen> createState() => _DeleteUsersScreenState();
}

class _DeleteUsersScreenState extends State<DeleteUsersScreen> {
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
    // print('$baseUrl/user/all');
    // print(token);
    var headers = {'Content-type': 'application/json', 'token': '$token'};
    // print(headers);
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/user/all'), headers: headers);

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
    // print(user);
    var headers = {
      'Content-type': 'application/json',
      'token': '$token',
      // 'username': '${user['username']}'
    };
    try {
      final response = await http.delete(
          Uri.parse('$baseUrl/admin/delet_user?username=${user['username']}'),
          headers: headers,
          body: json.encode({'username': user['username']}));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(jsonData);

        setState(() {
          _fetchData();
        });

        // show sucess dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Success"),
              content: Text(json.decode(response.body)['message'] ??
                  "User deleted successfully"),
              actions: <Widget>[
                ElevatedButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop(); // Dismiss the dialog
                  },
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          print(response.statusCode);
          print(response.body);
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
          title: "Delete Users"),
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
                            subtitle:
                                Text('${user['email']} - ${user['role']}.'),
                            trailing: ElevatedButton(
                              onPressed: () {
                                handel_accept_user(context, user);
                                // handel_login_admin(context);
                              },
                              child: const Text('Delete'),
                            ),
                          ),
                      ],
                    )
                  : const Text('No users to delete'),
            ],
          ),
        ),
      ),
    );
  }
}
