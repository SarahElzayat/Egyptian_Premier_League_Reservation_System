const {
  loginService,
  registerService,
  updateUserService,
  getAllServices,
} = require("../services/user.service");

const login = async (req, res) => {
  try {
    const data = req.body;
    const user = await loginService(data);
    const status = user.status || 200;
    const response = user.response || { message: "success" };
    res.status(status).json(response);
  } catch (error) {
    const status = error.status || 500;
    const message = error.message || "internal server error";
    res.status(status).json({ message });
  }
};

const regestration = async (req, res) => {
  try {
    const data = req.body;
    const user = await registerService(data);
    const status = user.status || 200;
    const response = user.response || { message: "success" };
    res.status(status).json(response);
  } catch (error) {
    const status = error.status || 500;
    const message = error.message || "internal server error";
    res.status(status).json({ message });
  }
};

const update = async (req, res) => {
  try {
    const data = req.body;
    const user = await updateUserService(data);
    const status = user.status || 200;
    const response = user.response || { message: "success" };
    res.status(status).json(response);
  } catch (error) {
    const status = error.status || 500;
    const message = error.message || "internal server error";
    res.status(status).json({ message });
  }
};
const getAll = async (req, res) => {
  try {
    const data = req.body;
    const user = await getAllServices(data);
    const status = user.status || 200;
    const response = user.response || { message: "success" };
    res.status(status).json(response);
  } catch (error) {
    const status = error.status || 500;
    const message = error.message || "internal server error";
    res.status(status).json({ message });
  }
};

module.exports = { login, regestration, update, getAll };
