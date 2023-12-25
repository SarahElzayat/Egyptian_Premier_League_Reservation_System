import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
// import the user module
import 'package:web_frontend/src/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_dotenv/flutter_dotenv.dart';
const url = "http://192.168.1.87:3005";

Future<void> reserved_ticket(
    Map<String, Object> data, BuildContext context) async {
  print('hello');
  // load the token from the local storage and send it in the header
  SharedPreferences.getInstance().then((prefs) {
    String token = prefs.getString('token') ?? "";
    print(token);
    http.post(Uri.parse('$url/reservation'), body: json.encode(data), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'token': token
    }).then((response) {
      if (response.statusCode == 200) {
        print(response.body);
        // show success message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Success"),
              content: Text(json.decode(response.body)['message'] ??
                  "Failed to reserve ticket"),
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
      }
    });
  });
}
