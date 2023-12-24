const express = require("express");
const { authMiddleware } = require("../middlewares/authMiddleWare");
const teamRouter = express.Router();
const teamController = require("../controllers/team.controller");

teamRouter.post("/", authMiddleware, teamController.createTeamController);

teamRouter.put("/", authMiddleware, teamController.updateTeamController);

teamRouter.get("/", teamController.getTeamController);

teamRouter.get("/all",authMiddleware, teamController.getAllTeamsController);
teamRouter.delete("/", teamController.deleteTeamController);

module.exports = { teamRouter };
