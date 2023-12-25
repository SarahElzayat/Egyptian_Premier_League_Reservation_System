const express = require("express");
const { authMiddleware } = require("../middlewares/authMiddleWare");
const reservationRouter = express.Router();
const reservationController = require("../controllers/reservation.controller");

reservationRouter.post(
  "/",
  authMiddleware,
  reservationController.reserveTicket
);
reservationRouter.delete(
  "/",
  authMiddleware,
  reservationController.cancelreservation
);

reservationRouter.get("/", reservationController.getReservations);
reservationRouter.get(
  "/me",
  authMiddleware,
  reservationController.getReservations
);
module.exports = { reservationRouter };
