const { DataTypes } = require("sequelize");
const { db } = require("../database");

const Team = db.define(
  "Team",
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
      unique: true,
    },
    name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
  },
  {
    timestamps: false, // This line prevents the createdAt and updatedAt columns
    tableName: "Team", // Specify the custom table name here
  }
);

module.exports = { Team };
