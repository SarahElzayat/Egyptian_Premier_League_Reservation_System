const express = require("express");
const { authMiddleware } = require("../middlewares/authMiddleWare");
const teamRouter = express.Router();
const teamController = require("../controllers/team.controller");

teamRouter.post("/", authMiddleware, teamController.createTeamController);

teamRouter.put("/", authMiddleware, teamController.updateTeamController);

teamRouter.get("/", teamController.getTeamController);

teamRouter.get("/all",teamController.getAllTeamsController);
teamRouter.post("/",authMiddleware, teamController.getAllTeamsController);
teamRouter.put("/",authMiddleware, teamController.getAllTeamsController);
teamRouter.delete("/", teamController.getAllTeamsController);
teamRouter.get("/", teamController.getAllTeamsController);

module.exports = { teamRouter };
