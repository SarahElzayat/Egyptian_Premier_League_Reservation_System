const {
  createMatchService,
  updateMatchService,
  getMatchService,
  getAllUpcommingMatchService,
  getAllPastMatchService,
} = require("../services/match.service");

const createMatchController = async (req, res) => {
  try {
    const data = req.body;
    const out = await createMatchService(data);
    const status = out.status || 200;
    const response = out.response || { message: "success" };
    res.status(status).json(response);
  } catch (error) {
    const status = error.status || 500;
    const message = error.message || "internal server error";
    res.status(status).json({ message });
  }
};

const updateMatchController = async (req, res) => {
  try {
    const data = req.body;
    const out = await updateMatchService(data);
    const status = out.status || 200;
    const response = out.response || { message: "success" };
    res.status(status).json(response);
  } catch (error) {
    const status = error.status || 500;
    const message = error.message || "internal server error";
    res.status(status).json({ message });
  }
};
const getMatchController = async (req, res) => {
  try {
    const data = req.query;
    const out = await getMatchService(data);
    const status = out.status || 200;
    const response = out.response || { message: "success" };
    res.status(status).json(response);
  } catch (error) {
    const status = error.status || 500;
    const message = error.message || "internal server error";
    res.status(status).json({ message });
  }
};

const getAllUpcommingMatchController = async (req, res) => {
  try {
    const data = req.query;
    const out = await getAllUpcommingMatchService(data);
    const status = out.status || 200;
    const response = out.response || { message: "success" };
    res.status(status).json(response);
  } catch (error) {
    const status = error.status || 500;
    const message = error.message || "internal server error";
    res.status(status).json({ message });
  }
};
const getAllPastMatchController = async (req, res) => {
  try {
    const data = req.query;
    const out = await getAllPastMatchService(data);
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
  createMatchController,
  updateMatchController,
  getMatchController,
  getAllUpcommingMatchController,
  getAllPastMatchController,
};
