import 'package:flutter/material.dart';

Widget MatchComponent(home_team, away_team, match_id, date_time) => Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                home_team.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              const Text("  VS  ",
                  style: TextStyle(
                    fontSize: 36,
                    // fontWeight: FontWeight.w900,
                  )),
              Text(
                away_team.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(match_id.toString(),
              style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue)),
          Text(date_time.toString(),
              style: const TextStyle(fontSize: 16, color: Colors.blue
                  // fontWeight: FontWeight.bold,
                  )),
        ],
      ),
    );
