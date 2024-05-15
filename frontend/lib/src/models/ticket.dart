// class ticket {
//   int? id;
//   int? seatRow;
//   int? seatColumn;
//   int? matchId;
//   int? userId;

//   ticket({this.id, this.seatRow, this.seatColumn, this.matchId, this.userId});

//   ticket.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     seatRow = json['seat_row'];
//     seatColumn = json['seat_column'];
//     matchId = json['matchId'];
//     userId = json['userId'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['seat_row'] = this.seatRow;
//     data['seat_column'] = this.seatColumn;
//     data['matchId'] = this.matchId;
//     data['userId'] = this.userId;
//     return data;
//   }
// }
class tickets {
  List<Reservations>? reservations;

  tickets({this.reservations});

  tickets.fromJson(Map<String, dynamic> json) {
    if (json['reservations'] != null) {
      reservations = <Reservations>[];
      json['reservations'].forEach((v) {
        reservations!.add(new Reservations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reservations != null) {
      data['reservations'] = this.reservations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reservations {
  int? id;
  int? seatRow;
  int? seatColumn;
  int? matchId;
  int? userId;
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
  MatchVenue? matchVenue;

  Reservations(
      {this.id,
      this.seatRow,
      this.seatColumn,
      this.matchId,
      this.userId,
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

  Reservations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    seatRow = json['seat_row'];
    seatColumn = json['seat_column'];
    matchId = json['matchId'];
    userId = json['userId'];
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
        ? new MatchVenue.fromJson(json['match_venue'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seat_row'] = this.seatRow;
    data['seat_column'] = this.seatColumn;
    data['matchId'] = this.matchId;
    data['userId'] = this.userId;
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
  int? id;
  String? name;

  HomeTeam({this.id, this.name});

  HomeTeam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class MatchVenue {
  int? id;
  String? name;
  int? dimension1;
  int? dimension2;

  MatchVenue({this.id, this.name, this.dimension1, this.dimension2});

  MatchVenue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dimension1 = json['dimension1'];
    dimension2 = json['dimension2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dimension1'] = this.dimension1;
    data['dimension2'] = this.dimension2;
    return data;
  }
}
