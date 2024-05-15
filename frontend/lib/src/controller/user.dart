import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
// import the user module
import 'package:web_frontend/src/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../shared/constants/constants.dart' as cons;

// import 'package:flutter_dotenv/flutter_dotenv.dart';
const url = cons.url;

// update user data
Future<bool> updateUserData(
    Map<String, dynamic> query, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? "";
  final Response response = await http.put(Uri.parse('$url/user'),
      body: json.encode(query),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'token': token
      });
  if (response.statusCode == 200) {
    User user = User.fromJson(json.decode(response.body)['user']);
    // save the user in the local storage
    prefs.setString('user', json.encode(user));
    // show success message
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success"),
          content: Text(json.decode(response.body)['message'] ??
              "updated data successfully"),
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
    return true;
  } else {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("failed"),
          content: Text(
              json.decode(response.body)['message'] ?? "updated data failed"),
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
    return false;
  }
}
