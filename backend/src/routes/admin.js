const express = require("express");
const { authMiddleware } = require("../middlewares/authMiddleWare");
const adminRouter = express.Router();
const adminController = require("../controllers/admin.controller");

adminRouter.post("/approve", authMiddleware, adminController.approveController);
adminRouter.delete(
  "/delet_user",
  authMiddleware,
  adminController.deleteUserController
);
adminRouter.get(
  "/get_appended_users",
  authMiddleware,
  adminController.getAllAppendingUsersController
);
module.exports = { adminRouter };
