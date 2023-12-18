const {
  approveService,
  deleteUserService,
  getAllAppendingUsersService,
} = require("../services/admin.service");

const approveController = async (req, res) => {
  try {
    const data = req.body;
    const out = await approveService(data);
    res.status(200).json(out);
  } catch (error) {
    status = error.status || 500;
    message = error.message || "internal server error";
    res.status(status).json({ message });
  }
};

const deleteUserController = async (req, res) => {
  try {
    const data = req.query;
    const out = await deleteUserService(data);
    res.status(200).json(out);
  } catch (error) {
    status = error.status || 500;
    message = error.message || "internal server error";
    res.status(status).json({ message });
  }
};

const getAllAppendingUsersController = async (req, res) => {
  try {
    const data = req.body;
    const out = await getAllAppendingUsersService(data);
    res.status(200).json(out);
  } catch (error) {
    status = error.status || 500;
    message = error.message || "internal server error";
    res.status(status).json({ message });
  }
};

module.exports = {
  approveController,
  deleteUserController,
  getAllAppendingUsersController,
};
