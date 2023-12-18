const {
  loginService,
  registerService,
  updateUserService,
} = require("../services/user.service");

const login = async (req, res) => {
  try {
    const data = req.body;
    const user = await loginService(data);
    res.status(200).json(user);
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
    res.status(200).json(user);
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
    res.status(200).json(user);
  } catch (error) {
    status = error.status || 500;
    message = error.message || "internal server error";
    res.status(status).json({ message });
  }
};

module.exports = { login, regestration, update };
