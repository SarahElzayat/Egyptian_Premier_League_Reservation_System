const {
  reserveTicketService,
  cancelreservationService,
  getReservationsService,
} = require("../services/reservation.service");

const reserveTicket = async (req, res) => {
  try {
    const data = req.body;
    const out = await reserveTicketService(data);
    const status = out.status || 200;
    const response = out.response || { message: "success" };
    res.status(status).json(response);
  } catch (error) {
    let status = error.status || 500;
    let message = error.message || "internal server error";
    res.status(status).json({ message });
  }
};

const cancelreservation = async (req, res) => {
  try {
    const data = req.query;
    const out = await cancelreservationService(data);
    const status = out.status || 200;
    const response = out.response || { message: "success" };
    res.status(status).json(response);
  } catch (error) {
    let status = error.status || 500;
    let message = error.message || "internal server error";
    res.status(status).json({ message });
  }
};

const getReservations = async (req, res) => {
  try {
    const data = req.query;
    const out = await getReservationsService(data);
    const status = out.status || 200;
    const response = out.response || { message: "success" };
    res.status(status).json(response);
  } catch (error) {
    let status = error.status || 500;
    let message = error.message || "internal server error";
    res.status(status).json({ message });
  }
};

module.exports = {
  reserveTicket,
  cancelreservation,
  getReservations,
};
