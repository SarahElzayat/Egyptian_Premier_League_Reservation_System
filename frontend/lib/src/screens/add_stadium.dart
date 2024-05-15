import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_frontend/src/components/appbar.dart';
import "../controller/authentication.dart";
import 'package:http/http.dart' as http;

class AddStadiumScreen extends StatefulWidget {
  // bool admin;
  AddStadiumScreen({super.key});
  @override
  _AddStadiumScreenState createState() => _AddStadiumScreenState();
}

class _AddStadiumScreenState extends State<AddStadiumScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String stadium_name = '';
  int? columns;
  int? rows;
  bool error = false;
  String errorMessage = '';

  // add stadium
  Future<void> handel_add_stadium(BuildContext context) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      final response = await http.post(Uri.parse('$url/stadium'),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'token': '$token'
          },
          body: jsonEncode({
            'name': stadium_name,
            'dimension1': rows,
            'dimension2': columns
          }));

      if (response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        print(jsonData);
        setState(() {
          print('tmam');
          // navigate
        });
        Navigator.pushNamed(context, '/home');
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(context,
          // index: 3,
          title: "Add Stadium"),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.3,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Stadium Name'),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your stadium name';
                      }
                      // Add more validation logic here if needed.
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        stadium_name = value;
                      });
                    },
                  ),
                  // TextFormField(
                  //   keyboardType: TextInputType.number,
                  //   decoration: const InputDecoration(labelText: 'Rows'),
                  //   // obscureText: true,
                  //   validator: (value) {
                  //     if (value?.isEmpty ?? true) {
                  //       return 'Please enter your password';
                  //     }
                  //     // Add more validation logic here if needed.
                  //     return null;
                  //   },
                  //   onChanged: (value) {
                  //     setState(() {
                  //       rows = value as int?;
                  //     });
                  //   },
                  // ),
                  SizedBox(
                    height: 50,
                  ),
                  Text('Rows'),
                  CupertinoPicker(
                    itemExtent: 50.0,
                    onSelectedItemChanged: (int index) {
                      setState(() {
                        rows = index;
                      });
                    },
                    children: List<Widget>.generate(100, (int index) {
                      return Center(child: Text('$index'));
                    }),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text('Columns'),
                  CupertinoPicker(
                    itemExtent: 50.0,
                    onSelectedItemChanged: (int index) {
                      setState(() {
                        columns = index;
                      });
                    },
                    children: List<Widget>.generate(100, (int index) {
                      return Center(child: Text('$index'));
                    }),
                  ),

                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Form is valid, you can perform login logic here.
                        handel_add_stadium(context);
                      }
                    },
                    child: const Text('Add Stadium'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
