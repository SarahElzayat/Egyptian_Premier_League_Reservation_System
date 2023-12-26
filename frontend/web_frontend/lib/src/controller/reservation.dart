import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:web_frontend/src/models/ticket.dart';
// import the user module
import 'package:web_frontend/src/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../models/ticket.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../shared/constants/constants.dart' as cons;

// import 'package:flutter_dotenv/flutter_dotenv.dart';
const url = cons.url;

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
                  "reserve ticket successfully"),
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

Future<tickets> get_my_tickets(BuildContext context) async {
  // call end point reservation/me and send token to the header
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? "";
  final Response response = await http.get(Uri.parse('$url/reservation/me'),
      headers: {'Content-type': 'application/json', 'token': token});
  if (response.statusCode == 200) {
    tickets data = tickets.fromJson(json.decode(response.body));
    return data;
  } else {
    // pop page and show error message
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("error message"),
          content: Text(json.decode(response.body)['message'] ??
              "Failed to load match details"),
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
  return tickets();
}

Future<void> cancelReservationControler(int id, BuildContext context) async {
  // load the token from the local storage and send it in the header
  SharedPreferences.getInstance().then((prefs) {
    String token = prefs.getString('token') ?? "";
    http.delete(Uri.parse('$url/reservation?id=$id'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'token': token
    }).then((response) {
      if (response.statusCode == 200) {
        // show success message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Success"),
              content: Text(json.decode(response.body)['message'] ??
                  "cancel reservation done successfully"),
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
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Failed"),
              content: Text(json.decode(response.body)['message'] ??
                  "cancel reservation failed"),
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
