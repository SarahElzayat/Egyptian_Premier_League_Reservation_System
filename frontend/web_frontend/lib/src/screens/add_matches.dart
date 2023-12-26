import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_frontend/src/components/appbar.dart';
import 'package:web_frontend/src/components/dropdown_button.dart';
import 'package:http/http.dart' as http;
import 'package:web_frontend/src/controller/authentication.dart';

class AddMatchesScreen extends StatefulWidget {
  const AddMatchesScreen({super.key});

  @override
  State<AddMatchesScreen> createState() => _AddMatchesScreenState();
}

class _AddMatchesScreenState extends State<AddMatchesScreen> {
  dynamic? selectedAwayTeam;
  dynamic? selectedHomeTeam;
  String? selectedReferee;
  // String? matchDate;
  String? linesman1;
  String? linesman2;
  dynamic? venue;
  List<dynamic> teams = [];
  List<dynamic> venues = [];
  DateTime? matchDate;
  TextEditingController birthdayController = TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2500),
    );
    if (picked != null && picked != matchDate) {
      setState(() {
        matchDate = picked;

        birthdayController.text =
            "${picked.toLocal()}".split(' ')[0].toString().split('-')[1] +
                "-" +
                "${picked.toLocal()}".split(' ')[0].toString().split('-')[2] +
                "-" +
                "${picked.toLocal()}".split(' ')[0].toString().split('-')[0];
        print(matchDate);
      });
    }
  }

  TimeOfDay? selectedTime;

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
      initialEntryMode:
          TimePickerEntryMode.dial, // or TimePickerEntryMode.input
    );

    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;

        // new varianle with the value of time a
      });
    }
  }

  // add match function
  Future<void> handel_add_match(BuildContext context) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    print(token);
    print(selectedHomeTeam['id']);
    print(selectedAwayTeam['id']);
    print(selectedReferee);
    print(linesman1);
    print(linesman2);
    print(birthdayController.text);
    print(selectedTime);
    print(venue['id']);
    try {
      final response = await http.post(Uri.parse('$url/match'),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'token': '$token'
          },
          body: jsonEncode({
            "home_team_id": selectedHomeTeam['id'],
            "away_team_id": selectedAwayTeam['id'],
            "match_venue_id": venue['id'],
            // "date": matchDate.toString(),
            "date": birthdayController.text,
            "time": '${selectedTime?.hour}:${selectedTime?.minute}',
            "main_referee": selectedReferee,
            "linesmen1": linesman1,
            "linesmen2": linesman2,
          }));

      if (response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        print(jsonData);
        setState(() {
          print('tmam');
          // navigate
        });
        Navigator.pushNamed(context, '/upcoming_matches');
      } else {
        setState(() {
          print('msh mam');
          print(json.decode(response.body));

          // show the error dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("error message"),
                content: Text(json.decode(response.body)['message'] ??
                    "Failed to add match"),
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

          // data = "Failed to load data!";
        });
      }
    } catch (e) {
      setState(() {
        print('shit');
        // data = "Error occurred: $e";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getTeams();
    _getVenues();
  }

  Future<void> _getTeams() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    print(token);
    try {
      final response = await http.get(Uri.parse('$url/team/all'), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'token': '$token'
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(jsonData);
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
    print(token);
    try {
      final response = await http.get(Uri.parse('$url/stadium/all'), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'token': '$token'
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(jsonData);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(context,
          title: "Add Matches"), // index 3 is for Add Matches
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.5,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text('Home Team:'),
                          DropdownButton<dynamic>(
                            value: selectedHomeTeam,
                            onChanged: (newValue) {
                              setState(() {
                                selectedHomeTeam = newValue;
                                // You might also want to reset the away team if it's the same as the home team
                                if (selectedAwayTeam == newValue) {
                                  selectedAwayTeam = null;
                                }
                              });
                            },
                            items: teams
                                .where((team) => team != selectedAwayTeam)
                                .map<DropdownMenuItem<dynamic>>(
                                    (dynamic value) {
                              return DropdownMenuItem<dynamic>(
                                value: value,
                                child: Text(value['name'].toString()),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      SizedBox(width: 50),
                      Column(
                        children: [
                          Text('Away Team:'),
                          DropdownButton<dynamic>(
                            value: selectedAwayTeam,
                            onChanged: (newValue) {
                              setState(() {
                                selectedAwayTeam = newValue;
                                // Similar to above, reset the home team if it's the same as the away team
                                if (selectedHomeTeam == newValue) {
                                  selectedHomeTeam = null;
                                }
                              });
                            },
                            items: teams
                                .where((team) => team != selectedHomeTeam)
                                .map<DropdownMenuItem<dynamic>>(
                                    (dynamic value) {
                              return DropdownMenuItem<dynamic>(
                                value: value,
                                child: Text(value['name'].toString()),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      SizedBox(width: 50),
                      Column(
                        children: [
                          Text('Venue:'),
                          DropdownButton<dynamic>(
                            value: venue,
                            onChanged: (newValue) {
                              setState(() {
                                venue = newValue;
                                // You might also want to reset the away team if it's the same as the home team
                              });
                            },
                            items: venues.map<DropdownMenuItem<dynamic>>(
                                (dynamic value) {
                              return DropdownMenuItem<dynamic>(
                                value: value,
                                child: Text(value['name'].toString()),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ],
                  ),

                  TextFormField(
                      decoration: InputDecoration(labelText: 'Linesman 1'),
                      onChanged: (value) {
                        setState(() {
                          linesman1 = value;
                        });
                      }),
                  TextFormField(
                      decoration: InputDecoration(labelText: 'Linesman 2'),
                      onChanged: (value) {
                        setState(() {
                          linesman2 = value;
                        });
                      }),
                  TextFormField(
                      decoration: InputDecoration(labelText: 'Referee'),
                      onChanged: (value) {
                        setState(() {
                          selectedReferee = value;
                        });
                      }),

                  SizedBox(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Date',
                        hintText: 'Select date',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () {
                            _selectDate(context);
                          },
                        ),
                      ),
                      controller: birthdayController,
                      readOnly: true,
                      // validator: (value) {
                      //   if (value?.isEmpty ?? true) {
                      //     return 'Please select the date';
                      //   }
                      //   matchDate = value;
                      //   print('DAAAAAAAATE');
                      //   print(value);
                      //   return null;
                      // },
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    // mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        selectedTime != null
                            ? selectedTime!.format(context)
                            : 'No time selected',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () => _pickTime(context),
                        child: Text('Select Time'),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 50,
                  ),
                  // Add more widgets here for other match details
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => handel_add_match(context),
                      child: Text("Add Match"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
