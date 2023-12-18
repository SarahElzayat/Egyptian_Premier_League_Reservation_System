const {
  loginService,
  registerService,
  updateUserService,
} = require("../services/user.service");

const login = async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await loginService(email, password);
    res.status(200).json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const regestration = async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await registerService(email, password);
    res.status(200).json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const update = async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await updateUserService(email, password);
    res.status(200).json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = { login, regestration, update };
