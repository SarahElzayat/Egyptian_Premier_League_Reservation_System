const { User } = require("../entities/user");
const { Reservation } = require("../entities/reservation");
const { Match } = require("../entities/match");
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
  await Reservation.destroy({
    where: {
      id,
    },
  });

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
