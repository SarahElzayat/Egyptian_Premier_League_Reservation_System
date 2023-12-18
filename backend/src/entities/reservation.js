const { DataTypes } = require("sequelize");
const { db } = require("../database");
const { Match } = require("./match");
const { User } = require("./user");

const Reservation = db.define(
  "Reservation",
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
      unique: true,
    },
    seat_row: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    seat_column: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
  },
  {
    timestamps: false, // This line prevents the createdAt and updatedAt columns
    tableName: "Reservation", // Specify the custom table name here
  }
);

// Define associations with foreign keys
Reservation.belongsTo(Match, { foreignKey: "matchId" });
Reservation.belongsTo(User, { foreignKey: "userId" });

module.exports = { Reservation };
