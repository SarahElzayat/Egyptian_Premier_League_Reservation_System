import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:web_frontend/src/dio/constant_end_points.dart';
// import the user module
import 'package:web_frontend/src/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/match.dart';

// import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../shared/constants/constants.dart' as cons;

// import 'package:flutter_dotenv/flutter_dotenv.dart';
const url = cons.url;

Future<List<Match>> getUpcommingMatchs() async {
  final Response response =
      await http.get(Uri.parse('$url/match/all/upcomming'));
  if (response.statusCode == 200) {
    List<Match> matches = [];
    for (var match in json.decode(response.body)['match']) {
      matches.add(Match.fromJson(match));
    }
    return matches;
  } else {
    return [];
  }
}

Future<Map<String, Object>> getMatchDetails(
    int id, BuildContext context) async {
  final Response response = await http.get(Uri.parse('$url/match?id=$id'));
  if (response.statusCode == 200) {
    final res = json.decode(response.body);
    Match match = Match.fromJson(res['match']);
    return {
      'sucess': true,
      'match': match,
      'num_vacant_seats': res['match']['num_vacant_seats'],
      'num_booked_seats': res['match']['num_booked_seats'],
      'dimension1': res['match']['match_venue']['dimension1'],
      'dimension2': res['match']['match_venue']['dimension2'],
      'reserved_tickets': res['match']['reserved_tickets'],
    };
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

    return {'sucess': false, 'match': Match()};
  }
}

Future<void> update_match(Match macth, BuildContext context) async {
  // load the token from the local storage and send it in the header
  SharedPreferences.getInstance().then((prefs) {
    String token = prefs.getString('token') ?? "";
    http.put(Uri.parse('$url/match'),
        body: json.encode(macth.toJson()),
        headers: {
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
                  "updated match successfully"),
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
        // show error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("error message"),
              content: Text(json.decode(response.body)['message'] ??
                  "Failed to update match"),
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
