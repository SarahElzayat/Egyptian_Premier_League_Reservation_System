const {
    createTeamService,
    updateTeamService,
    getTeamService,
    getAllTeamsService
  } = require("../services/team.service");
  
const createTeamController = async (req, res) => {
try {
    const data = req.body;
    const out = await createTeamService(data);
    const status = out.status || 200;
    const response = out.response || { message: "success" };
    res.status(status).json(response);
} catch (error) {
    const status = error.status || 500;
    const message = error.message || "internal server error";
    res.status(status).json({ message });
}
};
  
const updateTeamController = async (req, res) => {
try {
    const data = req.body;
    const out = await updateTeamService(data);
    const status = out.status || 200;
    const response = out.response || { message: "success" };
    res.status(status).json(response);
} catch (error) {
    const status = error.status || 500;
    const message = error.message || "internal server error";
    res.status(status).json({ message });
}
};
const getTeamController = async (req, res) => {
try {
    const data = req.query;
    const out = await getTeamService(data);
    const status = out.status || 200;
    const response = out.response || { message: "success" };
    res.status(status).json(response);
} catch (error) {
    const status = error.status || 500;
    const message = error.message || "internal server error";
    res.status(status).json({ message });
}
};

const getAllTeamsController = async (req, res) => {
    try {
      const data = req.query;
      const out = await getAllTeamsService(data);
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
createTeamController,
updateTeamController,
getTeamController,
getAllTeamsController
};
