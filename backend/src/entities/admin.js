const { DataTypes } = require("sequelize");
const { db } = require("../database");
const Admin = db.define(
  "Admin",
  {
    username: {
      type: DataTypes.STRING(100),
      allowNull: false,
      primaryKey: true,
    },
    password: {
      type: DataTypes.STRING(200),
    },
  },
  {
    timestamps: false, // This line prevents the createdAt and updatedAt columns
    tableName: "Admin", // Specify the custom table name here
  }
);

module.exports = { Admin };
