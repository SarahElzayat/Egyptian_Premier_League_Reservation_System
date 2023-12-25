const {
    createStadiumService,
    updateStadiumService,
    getStadiumService,
    getAllStadiumsService,
    deleteStadiumService
  } = require("../services/stadium.service");
  
const createStadiumController = async (req, res) => {
try {
    const data = req.body;
    const out = await createStadiumService(data);
    const status = out.status || 200;
    const response = out.response || { message: "success" };
    res.status(status).json(response);
} catch (error) {
    const status = error.status || 500;
    const message = error.message || "internal server error";
    res.status(status).json({ message });
}
};

const updateStadiumController = async (req, res) => {
try {
    const data = req.body;
    const out = await updateStadiumService(data);
    const status = out.status || 200;
    const response = out.response || { message: "success" };
    res.status(status).json(response);
} catch (error) {
    const status = error.status || 500;
    const message = error.message || "internal server error";
    res.status(status).json({ message });
}
};
const getStadiumController = async (req, res) => {
try {
    const data = req.query;
    const out = await getStadiumService(data);
    const status = out.status || 200;
    const response = out.response || { message: "success" };
    res.status(status).json(response);
} catch (error) {
    const status = error.status || 500;
    const message = error.message || "internal server error";
    res.status(status).json({ message });
}
};

const getAllStadiumsController = async (req, res) => {
try {
    const data = req.query;
    const out = await getAllStadiumsService(data);
    const status = out.status || 200;
    const response = out.response || { message: "success" };
    res.status(status).json(response);
} catch (error) {
    const status = error.status || 500;
    const message = error.message || "internal server error";
    res.status(status).json({ message });
}
};

const deleteStadiumController = async (req, res) => {
    try {
        const data = req.query;
        const out = await deleteStadiumService(data);
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
createStadiumController,
updateStadiumController,
getStadiumController,
getAllStadiumsController,
deleteStadiumController
};
  