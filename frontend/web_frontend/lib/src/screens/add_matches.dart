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
  String? selectedHomeTeam;
  String? selectedAwayTeam;
  String? selectedReferee;
  String? matchDate;
  String? linesman1;
  String? linesman2;
  String? venue;
  final teams = ['Team A', 'Team B', 'Team C', 'Team D'];
  final referees = ['Referee A', 'Referee B', 'Referee C', 'Referee D'];
  final linesmen = ['Linesman A', 'Linesman B', 'Linesman C', 'Linesman D'];
  final venues = ['Venue A', 'Venue B', 'Venue C', 'Venue D'];
  DateTime? selectedDate;
  TextEditingController birthdayController = TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birthdayController.text =
            "${picked.toLocal()}".split(' ')[0]; // Format the date as needed
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
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    print(token);
    try {
      final response = await http.get(Uri.parse('$url/team/all'), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(jsonData);
        setState(() {
          // data = jsonData['someKey']; // Change according to your JSON structure
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
                          DropdownButton<String>(
                            value: selectedHomeTeam,
                            onChanged: (newValue) {
                              setState(() {
                                selectedHomeTeam = newValue;
                              });
                            },
                            items: teams
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      SizedBox(width: 50),
                      Column(
                        children: [
                          Text('Away Team:'),
                          DropdownButton<String>(
                            value: selectedAwayTeam,
                            onChanged: (newValue) {
                              setState(() {
                                selectedAwayTeam = newValue;
                              });
                            },
                            items: teams
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text('Linesman 1:'),
                          DropdownButton<String>(
                            value: linesman1,
                            onChanged: (newValue) {
                              setState(() {
                                linesman1 = newValue!;
                              });
                            },
                            items: linesmen
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      SizedBox(width: 50),
                      Column(
                        children: [
                          Text('Linesman 2:'),
                          DropdownButton<String>(
                            value: linesman2,
                            onChanged: (newValue) {
                              setState(() {
                                linesman2 = newValue!;
                              });
                            },
                            items: linesmen
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text('Referee:'),
                          DropdownButton<String>(
                            value: selectedReferee,
                            onChanged: (newValue) {
                              setState(() {
                                selectedReferee = newValue;
                              });
                            },
                            items: referees
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      SizedBox(width: 50),
                      Column(
                        children: [
                          Text('Venue:'),
                          DropdownButton<String>(
                            value: venue,
                            onChanged: (newValue) {
                              setState(() {
                                selectedReferee = newValue;
                              });
                            },
                            items: venues
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(
                    width: 200,
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
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please select the date';
                        }
                        matchDate = value!;
                        return null;
                      },
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
                  // Add more widgets here for other match details
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
