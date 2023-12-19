const { Match } = require("../entities/match");
const { Team } = require("../entities/team");
const { Stadium } = require("../entities/Stadium");
const { Reservation } = require("../entities/reservation");
const { Op } = require("sequelize");

const createMatchService = async (data) => {
  const {
    home_team_id,
    away_team_id,
    match_venue_id,
    date,
    time,
    main_referee,
    linesmen1,
    linesmen2,
  } = data;
  //   validate that each field is not empty
  if (
    !home_team_id ||
    !away_team_id ||
    !match_venue_id ||
    !date ||
    !time ||
    !main_referee ||
    !linesmen1 ||
    !linesmen2
  ) {
    throw {
      status: 400,
      message: "All fields are required",
    };
  }
  //   validate that the match_venue_id is valid
  const stadium = await Stadium.findOne({ where: { id: match_venue_id } });
  const team1 = await Team.findOne({ where: { id: home_team_id } });
  const team2 = await Team.findOne({ where: { id: away_team_id } });

  if (!stadium) {
    throw {
      status: 400,
      message: "invalid stadium id",
    };
  }
  if (!team1) {
    throw {
      status: 400,
      message: "invalid home team id",
    };
  }
  if (!team2) {
    throw {
      status: 400,
      message: "invalid away team id",
    };
  }
  if (home_team_id == away_team_id) {
    throw {
      status: 400,
      message: "home team and away team can't be the same",
    };
  }
  // create the match
  const creatd_match = await Match.create({
    home_team_id,
    away_team_id,
    match_venue_id,
    date,
    time,
    main_referee,
    linesmen1,
    linesmen2,
  });
  return {
    status: 201,
    response: {
      message: "match created successfully",
      match: creatd_match.dataValues,
    },
  };
};

const updateMatchService = async (data) => {
  const {
    id,
    home_team_id,
    away_team_id,
    match_venue_id,
    date,
    time,
    main_referee,
    linesmen1,
    linesmen2,
  } = data;
  //   validate that each field is not empty
  if (!id) {
    throw {
      status: 400,
      message: "match id is required",
    };
  }

  //   validate that the match_venue_id is valid
  const match = await Match.findOne({ where: { id: id } });
  if (!match) {
    throw {
      status: 400,
      message: "invalid match id",
    };
  }

  if (home_team_id && away_team_id && home_team_id == away_team_id) {
    throw {
      status: 400,
      message: "home team and away team can't be the same",
    };
  } else if (home_team_id) {
    const team1 = await Team.findOne({ where: { id: home_team_id } });
    if (!team1) {
      throw {
        status: 400,
        message: "invalid home team id",
      };
    }
    if (team1.dataValues.id == match.dataValues.away_team_id) {
      throw {
        status: 400,
        message: "home team and away team can't be the same",
      };
    }
  } else if (away_team_id) {
    const team2 = await Team.findOne({ where: { id: away_team_id } });
    if (!team2) {
      throw {
        status: 400,
        message: "invalid away team id",
      };
    }
    if (team2.dataValues.id == match.dataValues.home_team_id) {
      throw {
        status: 400,
        message: "home team and away team can't be the same",
      };
    }
  }
  //   if the user send match_venue_id then check if the venue is valid
  if (match_venue_id) {
    const stadium = await Stadium.findOne({ where: { id: match_venue_id } });
    if (!stadium) {
      throw {
        status: 400,
        message: "invalid stadium id",
      };
    }
  }
  //   update the match
  await Match.update(
    {
      home_team_id,
      away_team_id,
      match_venue_id,
      date,
      time,
      main_referee,
      linesmen1,
      linesmen2,
    },
    {
      where: {
        id,
      },
    }
  );
  const updated_match = await Match.findOne({ where: { id: id } });
  console.log(updated_match);
  return {
    status: 200,
    response: {
      message: "match updated successfully",
      match: updated_match.dataValues,
    },
  };
};

const getMatchService = async (data) => {
  const { id } = data;
  if (!id) {
    throw {
      status: 400,
      message: "match id is required",
    };
  }
  const match = await Match.findOne({
    where: { id },
    include: [
      { model: Team, as: "home_team" },
      { model: Team, as: "away_team" },
      { model: Stadium, as: "match_venue" },
    ],
  });
  if (!match) {
    throw {
      status: 400,
      message: "invalid match id",
    };
  }
  let match_data = match.dataValues;
  let total_tickets =
    match_data.match_venue.dimension1 * match_data.match_venue.dimension2;
  let booked_tickets = await Reservation.count({ where: { matchId: id } });
  match_data["num_vacant_seats"] = total_tickets - booked_tickets;
  match_data["num_booked_seats"] = booked_tickets;
  let reserved_tickets = await Reservation.findAll({
    where: { matchId: id },
    attributes: ["seat_row", "seat_column"],
  });
  for (let i = 0; i < reserved_tickets.length; i++) {
    reserved_tickets[i] = [
      reserved_tickets[i].dataValues.seat_row,
      reserved_tickets[i].dataValues.seat_column,
    ];
  }
  match_data["reserved_tickets"] = reserved_tickets;
  return {
    status: 200,
    response: {
      match: match_data,
    },
  };
};
const getAllUpcommingMatchService = async (data) => {
  let currentDate = new Date(); // current date
  const currentTime = new Date(); // current time

  const matches = await Match.findAll({
    where: {
      date: {
        [Op.gt]: currentDate, // Matches with date greater than current date
      },
      // [Op.or]: [
      //   // Matches with the same date but a later time
      //   { date: currentDate, time: { [Op.gt]: currentTime } },
      // ],
    },
  });

  // match_data["reserved_tickets"] = reserved_tickets;
  return {
    status: 200,
    response: {
      match: matches,
    },
  };
};
const getAllPastMatchService = async (data) => {
  const { id } = data;
  if (!id) {
    throw {
      status: 400,
      message: "match id is required",
    };
  }
  const match = await Match.findOne({
    where: { id },
    include: [
      { model: Team, as: "home_team" },
      { model: Team, as: "away_team" },
      { model: Stadium, as: "match_venue" },
    ],
  });
  if (!match) {
    throw {
      status: 400,
      message: "invalid match id",
    };
  }
  let match_data = match.dataValues;
  let total_tickets =
    match_data.match_venue.dimension1 * match_data.match_venue.dimension2;
  let booked_tickets = await Reservation.count({ where: { matchId: id } });
  match_data["num_vacant_seats"] = total_tickets - booked_tickets;
  match_data["num_booked_seats"] = booked_tickets;
  let reserved_tickets = await Reservation.findAll({
    where: { matchId: id },
    attributes: ["seat_row", "seat_column"],
  });
  for (let i = 0; i < reserved_tickets.length; i++) {
    reserved_tickets[i] = [
      reserved_tickets[i].dataValues.seat_row,
      reserved_tickets[i].dataValues.seat_column,
    ];
  }
  match_data["reserved_tickets"] = reserved_tickets;
  return {
    status: 200,
    response: {
      match: match_data,
    },
  };
};
module.exports = {
  createMatchService,
  updateMatchService,
  getMatchService,
  getAllUpcommingMatchService,
  getAllPastMatchService,
};
