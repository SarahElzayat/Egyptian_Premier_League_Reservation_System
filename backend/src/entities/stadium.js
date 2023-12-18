const { DataTypes } = require("sequelize");
const { db } = require("../database");

const Stadium = db.define(
  "Stadium",
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
    dimension1: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    dimension2: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
  },
  {
    timestamps: false, // This line prevents the createdAt and updatedAt columns
    tableName: "Stadium", // Specify the custom table name here
  }
);

module.exports = { Stadium };
