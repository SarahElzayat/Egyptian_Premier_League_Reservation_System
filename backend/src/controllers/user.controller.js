const {
  loginService,
  registerService,
  updateUserService,
} = require("../services/user.service");

const login = async (req, res) => {
  try {
    const data = req.body;
    const user = await loginService(data);
    const status = user.status || 200;
    const response = user.response || { message: "success" };
    res.status(status).json(response);
  } catch (error) {
    status = error.status || 500;
    message = error.message || "internal server error";
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
    status = error.status || 500;
    message = error.message || "internal server error";
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
    status = error.status || 500;
    message = error.message || "internal server error";
    res.status(status).json({ message });
  }
};

module.exports = { login, regestration, update };
