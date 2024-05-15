import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_frontend/src/components/appbar.dart';
import 'package:web_frontend/src/controller/authentication.dart';
import 'package:web_frontend/src/controller/match.dart';
import 'package:web_frontend/src/controller/reservation.dart';
import '../models/match.dart';

import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_frontend/src/components/appbar.dart';
import 'package:web_frontend/src/components/dropdown_button.dart';
import 'package:http/http.dart' as http;
import 'package:web_frontend/src/controller/authentication.dart';
import '../shared//constants/constants.dart' as cons;

const url = cons.url;

class EditMatchScreen extends StatefulWidget {
  Match match = Match();
  EditMatchScreen({super.key, required this.match});

  @override
  State<EditMatchScreen> createState() => _EditMatchScreenState();
}

class _EditMatchScreenState extends State<EditMatchScreen> {
  List<dynamic> teams = [];
  List<dynamic> venues = [];
  int? selectedHomeTeamId;
  int? selectedAwayTeamId;
  int? selectedStadiumId;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  TextEditingController birthdayController = TextEditingController();

  Future<void> updateMatch(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Add your update user logic here
      await update_match(widget.match, context);
    }
  }

  Future<void> _getTeams() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      final response = await http.get(Uri.parse('$url/team/all'), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'token': '$token'
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          teams = jsonData['team']; //r Change according to your JSON structure
          // print(teams);
        });
      } else {
        setState(() {
          // data = "Failed to load data!";
        });
      }
    } catch (e) {
      setState(() {
        // data = "Error occurred: $e";
      });
    }
  }

  Future<void> _getVenues() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      final response = await http.get(Uri.parse('$url/stadium/all'), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'token': '$token'
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          venues =
              jsonData['stadium']; // Change according to your JSON structure
        });
      } else {
        setState(() {
          // data = "Failed to load data!";
        });
      }
    } catch (e) {
      setState(() {
        // data = "Error occurred: $e";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTeams();
    _getVenues();
    selectedHomeTeamId = widget.match.homeTeamId;
    selectedAwayTeamId = widget.match.awayTeamId;
    selectedStadiumId = widget.match.matchVenueId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        context,
        index: 5,
        title: "Profile",
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // TextFormField(
                //   initialValue: widget.match.homeTeam!.name!,
                //   decoration: const InputDecoration(labelText: 'home team'),
                //   onSaved: (value) => widget.match.homeTeam!.name = value,
                // ),
                //  TextFormField(
                //   initialValue: widget.match.awayTeam!.name!,
                //   decoration: const InputDecoration(labelText: 'away team'),
                //   onSaved: (value) => widget.match.homeTeam!.name = value,
                // ),

                // TextFormField(
                //   initialValue: widget.match.matchVenue!.name!,
                //   decoration: const InputDecoration(labelText: 'Stadium'),
                //   onSaved: (value) => widget.match.matchVenue!.name = value,
                // ),
                DropdownButtonFormField<int>(
                  value: selectedHomeTeamId,
                  decoration: const InputDecoration(labelText: 'Home Team'),
                  items: teams.map<DropdownMenuItem<int>>((team) {
                    return DropdownMenuItem<int>(
                      value: team['id'], // Assuming team has an id property
                      child: Text(
                          team['name']), // Assuming team has a name property
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedHomeTeamId = newValue;
                    });
                    widget.match.homeTeamId = newValue;
                  },
                ),
                DropdownButtonFormField<int>(
                  value: selectedAwayTeamId,
                  decoration: const InputDecoration(labelText: 'away Team'),
                  items: teams.map<DropdownMenuItem<int>>((team) {
                    return DropdownMenuItem<int>(
                      value: team['id'], // Assuming team has an id property
                      child: Text(
                          team['name']), // Assuming team has a name property
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedAwayTeamId = newValue;
                    });
                    widget.match.awayTeamId = newValue;
                  },
                ),
                DropdownButtonFormField<int>(
                  value: selectedStadiumId,
                  decoration: const InputDecoration(labelText: 'Stadium'),
                  items: venues.map<DropdownMenuItem<int>>((venue) {
                    return DropdownMenuItem<int>(
                      value: venue['id'], // Assuming team has an id property
                      child: Text(
                          venue['name']), // Assuming team has a name property
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedStadiumId = newValue;
                    });
                    widget.match.matchVenueId = newValue;
                  },
                ),
                TextFormField(
                  initialValue: widget.match.date.toString().split('T')[0],
                  decoration: const InputDecoration(labelText: 'Date'),
                  onSaved: (value) => widget.match.date = value,
                ),
                // Text("last Name: " + user.lastName!),
                TextFormField(
                  initialValue: widget.match.time.toString(),
                  decoration: const InputDecoration(labelText: 'time'),
                  onSaved: (value) => widget.match.time = value,
                ),

                TextFormField(
                  initialValue: widget.match.mainReferee,
                  decoration: const InputDecoration(labelText: 'mainReferee'),
                  onSaved: (value) => widget.match.mainReferee = value,
                ),
                TextFormField(
                  initialValue: widget.match.linesmen1,
                  decoration: const InputDecoration(labelText: 'linesmen1'),
                  onSaved: (value) => widget.match.linesmen1 = value,
                ),
                // Text("Gender: " + user.gender!),
                TextFormField(
                  initialValue: widget.match.linesmen2,
                  decoration: const InputDecoration(labelText: 'linesmen2'),
                  onSaved: (value) => widget.match.linesmen2 = value,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await updateMatch(context);
                  },
                  child: const Text('Update Match data'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
