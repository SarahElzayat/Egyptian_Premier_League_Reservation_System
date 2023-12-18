const { DataTypes } = require("sequelize");
const { db } = require("../database");
const { Team } = require("./team");
const { Stadium } = require("./Stadium");
const Match = db.define(
  "Match",
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
      unique: true,
    },
    date_time: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    main_referee: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    linesmen1: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    linesmen2: {
      type: DataTypes.STRING,
      allowNull: false,
    },
  },
  {
    timestamps: false, // This line prevents the createdAt and updatedAt columns
    tableName: "Match", // Specify the custom table name here
  }
);

// Define associations with foreign keys
Match.belongsTo(Team, { as: "home_team", foreignKey: "home_team_id" });
Match.belongsTo(Team, { as: "away_team", foreignKey: "away_team_id" });
Match.belongsTo(Stadium, { as: "match_venue", foreignKey: "match_venue_id" });

module.exports = { Match };
