const express = require("express");
const { authMiddleware } = require("../middlewares/authMiddleWare");
const stadiumRouter = express.Router();
const stadiumController = require("../controllers/stadium.controller");

stadiumRouter.post("/", authMiddleware, stadiumController.createStadiumController);

stadiumRouter.put("/", authMiddleware, stadiumController.updateStadiumController);

stadiumRouter.get("/", stadiumController.getStadiumController);

stadiumRouter.get("/all", stadiumController.getAllStadiumsController);
stadiumRouter.post("/",authMiddleware, stadiumController.getAllStadiumsController);
stadiumRouter.put("/",authMiddleware, stadiumController.getAllStadiumsController);
stadiumRouter.delete("/", stadiumController.getAllStadiumsController);

module.exports = { stadiumRouter };
