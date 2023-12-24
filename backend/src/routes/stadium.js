const express = require("express");
const { authMiddleware } = require("../middlewares/authMiddleWare");
const stadiumRouter = express.Router();
const stadiumController = require("../controllers/stadium.controller");

stadiumRouter.post("/", authMiddleware, stadiumController.createStadiumController);

stadiumRouter.put("/", authMiddleware, stadiumController.updateStadiumController);

stadiumRouter.get("/", stadiumController.getStadiumController);

stadiumRouter.get("/all",authMiddleware, stadiumController.getAllStadiumsController);
stadiumRouter.delete("/", stadiumController.deleteStadiumController);

module.exports = { stadiumRouter };
