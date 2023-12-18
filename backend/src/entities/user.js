const { DataTypes } = require("sequelize");
const { db } = require("../database");
const User = db.define(
  "User",
  {
    userId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true,
    },
    status: {
      type: DataTypes.ENUM("approved", "not approved"),
      allowNull: false,
    },
    role: {
      type: DataTypes.ENUM("manager", "fan"),
      allowNull: false,
    },
    username: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true,
    },
    password: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    email: {
      type: DataTypes.STRING,
      allowNull: false,
      // unique: true,
      // in the document there is no need to make the email unique
      validate: {
        isEmail: true,
      },
    },
    first_name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    last_name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    birth_of_date: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    gender: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    city: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    address: {
      type: DataTypes.STRING,
      allowNull: true, // Address is optional
    },
  },
  {
    timestamps: false, // This line prevents the createdAt and updatedAt columns
    tableName: "User", // Specify the custom table name here
  }
);

module.exports = { User };
