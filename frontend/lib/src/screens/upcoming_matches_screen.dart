import 'package:flutter/material.dart';
import 'package:web_frontend/src/components/appbar.dart';
import 'package:web_frontend/src/components/match_component.dart';
import 'package:web_frontend/src/controller/match.dart';
import '../models/match.dart';

class UpcomingMatchesScreen extends StatefulWidget {
  @override
  State<UpcomingMatchesScreen> createState() => _UpcomingMatchesScreenState();
}

class _UpcomingMatchesScreenState extends State<UpcomingMatchesScreen> {
  final res = {
    "upcomming": [
      {
        "home_team": "Team A",
        "away_team": "Team B",
        "match_id": 1,
        "date_time": "date_time"
      },
      {
        "home_team": "Team C",
        "away_team": "Team D",
        "match_id": 2,
        "date_time": "date_time"
      },
      {
        "home_team": "Team C",
        "away_team": "Team D",
        "match_id": 2,
        "date_time": "date_time"
      },
      {
        "home_team": "Team C",
        "away_team": "Team D",
        "match_id": 2,
        "date_time": "date_time"
      },
      {
        "home_team": "Team C",
        "away_team": "Team D",
        "match_id": 2,
        "date_time": "date_time"
      },
      {
        "home_team": "Team C",
        "away_team": "Team D",
        "match_id": 2,
        "date_time": "date_time"
      },
      {
        "home_team": "Team C",
        "away_team": "Team D",
        "match_id": 2,
        "date_time": "date_time"
      },
      {
        "home_team": "Team C",
        "away_team": "Team D",
        "match_id": 2,
        "date_time": "date_time"
      },
      {
        "home_team": "Team C",
        "away_team": "Team D",
        "match_id": 2,
        "date_time": "date_time"
      },
      {
        "home_team": "Team C",
        "away_team": "Team D",
        "match_id": 2,
        "date_time": "date_time"
      },
      {
        "home_team": "Team C",
        "away_team": "Team D",
        "match_id": 2,
        "date_time": "date_time"
      },
      {
        "home_team": "Team E",
        "away_team": "Team F",
        "match_id": 3,
        "date_time": "date_time"
      }
    ]
  };
  List<Match> matches = [];
  Future<void> getMatches() async {
    final res = await getUpcommingMatchs();
    setState(() {
      for (var match in res) {
        matches.add(match);
      }
    });
  }

// call the loading the data in initState
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMatches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarComponent(context,
            // index: 1,
            title: " Upcoming Matches"),
        body: Center(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.4,
            child: ListView(
              children: [
                for (var match in matches)
                  MatchComponent(match.homeTeam?.name, match.awayTeam?.name,
                      match.id, match.date!.split('T')[0], match.time!, context)
              ],
            ),
          ),
        ));
  }
}
