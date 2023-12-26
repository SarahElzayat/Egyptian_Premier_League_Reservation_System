const { User } = require("../entities/user");
const { Reservation } = require("../entities/reservation");
const { Match } = require("../entities/match");
const { Team } = require("../entities/team");
const { Stadium } = require("../entities/Stadium");
const reserveTicketService = async (data) => {
  const { matchId, userId, seat_row, seat_column, card_number, PIN } = data;
  if (
    !matchId ||
    !userId ||
    !seat_row ||
    !seat_column ||
    !card_number ||
    !PIN
  ) {
    throw {
      status: 400,
      message: "invalid parameters",
    };
  }
  if (card_number.toString().length != 16 || PIN.toString().length != 3) {
    throw {
      status: 400,
      message: "card number must be 16 number and PIN must be 3 numbers",
    };
  }

  const taken = await Reservation.count({
    where: {
      matchId,
      seat_row,
      seat_column,
    },
  });
  if (taken > 0) {
    throw {
      status: 400,
      message: "this seat already taken",
    };
  }
  const reservation = await Reservation.create({
    userId,
    matchId,
    seat_row,
    seat_column,
  });
  return {
    status: 200,
    response: reservation.dataValues,
  };
};

const cancelreservationService = async (data) => {
  const { id } = data;
  if (!id) {
    throw {
      status: 400,
      message: "invalid parameters",
    };
  }
  const out = await Reservation.count({
    where: {
      id,
    },
  });
  if (out == 0) {
    throw {
      status: 400,
      message: "this reservation dosnt exist",
    };
  }
  const reserv = await Reservation.findOne({
    where: {
      id,
    },
  });
  const matchId = reserv.dataValues["matchId"];
  console.log(matchId);
  const match = await Match.findOne({
    where: {
      id: matchId,
    },
  });
  //   check if the date of the match is at least 3 days in the future
  const match_date = match.dataValues["date"];
  const current = new Date().setHours(0, 0, 0, 0);
  const timeDifference = match_date.getTime() - current;
  const daysDifference = timeDifference / (1000 * 3600 * 24);
  if (daysDifference >= 3) {
    await Reservation.destroy({
      where: {
        id,
      },
    });
  } else {
    throw {
      status: 400,
      message:
        "you must cancel the reservation at least 3 days before the match",
    };
  }

  return {
    status: 200,
    response: {
      message: "reservation deleted succssfuly",
    },
  };
};

const getReservationsService = async (data) => {
  const { matchId, userId } = data;
  if (!matchId && !userId) {
    throw {
      status: 400,
      message: "invalid parameters",
    };
  }
  const whereClause = {};

  if (matchId !== undefined) {
    whereClause.matchId = matchId;
  }

  if (userId !== undefined) {
    whereClause.userId = userId;
  }

  const out = await Reservation.findAll({
    where: whereClause,
  });

  for (let i = 0; i < out.length; i++) {
    out[i] = out[i].dataValues;
    const mactch = await Match.findOne({
      where: { id: out[i].matchId },
      include: [
        { model: Team, as: "home_team" },
        { model: Team, as: "away_team" },
        { model: Stadium, as: "match_venue" },
      ],
    });
    out[i] = { ...mactch.dataValues, ...out[i] };
  }
  return {
    status: 200,
    response: {
      reservations: out,
    },
  };
};

module.exports = {
  reserveTicketService,
  cancelreservationService,
  getReservationsService,
};
