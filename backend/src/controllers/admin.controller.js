const {
  approveService,
  deleteUserService,
  getAllAppendingUsersService,
} = require("../services/admin.service");

const approveController = async (req, res) => {
  try {
    const data = req.body;
    const out = await approveService(data);
    const status = out.status || 200;
    const response = out.response || { message: "success" };
    res.status(status).json(response);
  } catch (error) {
    const status = error.status || 500;
    const message = error.message || "internal server error";
    res.status(status).json({ message });
  }
};

const deleteUserController = async (req, res) => {
  try {
    const data = req.query;
    const out = await deleteUserService(data);
    const status = out.status || 200;
    const response = out.response || { message: "success" };
    res.status(status).json(response);
  } catch (error) {
    const status = error.status || 500;
    const message = error.message || "internal server error";
    res.status(status).json({ message });
  }
};

const getAllAppendingUsersController = async (req, res) => {
  try {
    const data = req.body;
    const out = await getAllAppendingUsersService(data);
    const status = out.status || 200;
    const response = out.response || { message: "success" };
    res.status(status).json(response);
  } catch (error) {
    const status = error.status || 500;
    const message = error.message || "internal server error";
    res.status(status).json({ message });
  }
};

module.exports = {
  approveController,
  deleteUserController,
  getAllAppendingUsersController,
};
