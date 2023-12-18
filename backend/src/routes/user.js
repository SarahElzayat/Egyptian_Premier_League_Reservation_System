const express = require("express");
const { authMiddleware } = require("../middlewares/authMiddleWare");
const userRouter = express.Router();
const userController = require("../controllers/user.controller");

userRouter.post("/login", userController.login);
userRouter.post("/signup", userController.regestration);
userRouter.put("/", authMiddleware, userController.update);
module.exports = { userRouter };
