class Match {
  int? id;
  String? date;
  String? time;
  String? mainReferee;
  String? linesmen1;
  String? linesmen2;
  int? homeTeamId;
  int? awayTeamId;
  int? matchVenueId;
  HomeTeam? homeTeam;
  HomeTeam? awayTeam;
  HomeTeam? matchVenue;

  Match(
      {this.id,
      this.date,
      this.time,
      this.mainReferee,
      this.linesmen1,
      this.linesmen2,
      this.homeTeamId,
      this.awayTeamId,
      this.matchVenueId,
      this.homeTeam,
      this.awayTeam,
      this.matchVenue});

  Match.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    mainReferee = json['main_referee'];
    linesmen1 = json['linesmen1'];
    linesmen2 = json['linesmen2'];
    homeTeamId = json['home_team_id'];
    awayTeamId = json['away_team_id'];
    matchVenueId = json['match_venue_id'];
    homeTeam = json['home_team'] != null
        ? new HomeTeam.fromJson(json['home_team'])
        : null;
    awayTeam = json['away_team'] != null
        ? new HomeTeam.fromJson(json['away_team'])
        : null;
    matchVenue = json['match_venue'] != null
        ? new HomeTeam.fromJson(json['match_venue'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['time'] = this.time;
    data['main_referee'] = this.mainReferee;
    data['linesmen1'] = this.linesmen1;
    data['linesmen2'] = this.linesmen2;
    data['home_team_id'] = this.homeTeamId;
    data['away_team_id'] = this.awayTeamId;
    data['match_venue_id'] = this.matchVenueId;
    if (this.homeTeam != null) {
      data['home_team'] = this.homeTeam!.toJson();
    }
    if (this.awayTeam != null) {
      data['away_team'] = this.awayTeam!.toJson();
    }
    if (this.matchVenue != null) {
      data['match_venue'] = this.matchVenue!.toJson();
    }
    return data;
  }
}

class HomeTeam {
  String? name;

  HomeTeam({this.name, required int id});

  HomeTeam.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
