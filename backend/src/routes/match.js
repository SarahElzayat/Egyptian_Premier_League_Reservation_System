const express = require("express");
const { authMiddleware } = require("../middlewares/authMiddleWare");
const matchRouter = express.Router();
const matchController = require("../controllers/match.controller");

matchRouter.post("/", authMiddleware, matchController.createMatchController);
matchRouter.put("/", authMiddleware, matchController.updateMatchController);
matchRouter.get("/", matchController.getMatchController);
matchRouter.get(
  "/all/upcomming",
  matchController.getAllUpcommingMatchController
);
matchRouter.get("/all/past", matchController.getAllPastMatchController);
module.exports = { matchRouter };
