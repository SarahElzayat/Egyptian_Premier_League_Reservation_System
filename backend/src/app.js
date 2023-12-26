const { db } = require("./database");
const express = require("express");
const { NODE_ENV, PORT, VERSION } = require("./config");
require("dotenv").config();
const cors = require("cors");
const swaggerJSDoc = require("swagger-jsdoc");
const swaggerUi = require("swagger-ui-express");
YAML = require("yamljs");
const swaggerDefinition = YAML.load("./api-docs.yaml");
const options = {
  swaggerDefinition,
  // Paths to files containing OpenAPI definitions
  apis: ["./routes/*.js"],
};
const swaggerSpec = swaggerJSDoc(options);

// require all entities files here, just to create tables in database
require("./entities/admin");
require("./entities/team");
require("./entities/Stadium");
require("./entities/user");
require("./entities/match");
require("./entities/reservation");

// import all routes here
const { userRouter } = require("./routes/user");
const { adminRouter } = require("./routes/admin");
const { matchRouter } = require("./routes/match");
const { teamRouter } = require("./routes/team");
const { stadiumRouter } = require("./routes/stadium");

const { reservationRouter } = require("./routes/reservation");
class App {
  constructor() {
    this.app = express();
    this.env = NODE_ENV;
    this.port = PORT;
    this.connectToDatabase();
    this.initializeMiddlewares();
    this.app.use("/docs", swaggerUi.serve, swaggerUi.setup(swaggerSpec));
    this.appStatus();
    this.app.use("/user", userRouter);
    this.app.use("/admin", adminRouter);
    this.app.use("/match", matchRouter);
    this.app.use("/team", teamRouter);
    this.app.use("/stadium", stadiumRouter);
    this.app.use("/reservation", reservationRouter);
  }
  listen() {
    this.app.listen(this.port, () => {
      console.log("=================================");
      console.log(`🚀 App is listening on the port: ${this.port}`);
      console.log("=================================");
    });
  }
  getServer() {
    return this.app;
  }
  async connectToDatabase() {
    try {
      await db.sync({ sync: true });
      console.log("Connection has been established successfully.");
    } catch (error) {
      console.error("error", error);
      console.error(`Can't establish connection with the database!`);
    }
  }
  appStatus() {
    this.app.get("/health", (req, res) => {
      // Calculate uptime in seconds
      const uptime = process.uptime();

      // Define the response object
      const response = {
        env: this.env,
        version: VERSION, // Replace with your actual version
        uptime: uptime.toFixed(2), // Format uptime to two decimal places
      };

      // Send the response
      res.send(response);
    });
  }
  initializeMiddlewares() {
    this.app.use(express.json());
    this.app.use(cors());
  }
  initializeRoutes() {
    //
  }
}

module.exports = { App };
