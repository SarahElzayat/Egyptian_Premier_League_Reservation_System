import 'package:flutter/material.dart';
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

class EditMatchScreen extends StatefulWidget {
  Match match = Match();
  EditMatchScreen({super.key, required this.match});

  @override
  State<EditMatchScreen> createState() => _EditMatchScreenState();
}

class _EditMatchScreenState extends State<EditMatchScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        context,
        index: 5,
        title: "Profile",
      ),
      // appBar: AppBar(
      //   title: Text('Profile'),
      // ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: widget.match.homeTeam!.name!,
                  decoration: const InputDecoration(labelText: 'home team'),
                  onSaved: (value) => widget.match.homeTeam!.name = value,
                ),
                TextFormField(
                  initialValue: widget.match.awayTeam!.name!,
                  decoration: const InputDecoration(labelText: 'away team'),
                  onSaved: (value) => widget.match.homeTeam!.name = value,
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
                  initialValue: widget.match.matchVenue!.name!,
                  decoration: const InputDecoration(labelText: 'Stadium'),
                  onSaved: (value) => widget.match.matchVenue!.name = value,
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
