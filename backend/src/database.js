const Sequelize = require("sequelize");
const {
  DB_USER,
  DB_PASSWORD,
  DB_HOST,
  DB_PORT,
  DB_DATABASE,
} = require("./config");
const db = new Sequelize({
  dialect: "postgres",
  host: DB_HOST,
  port: DB_PORT,
  username: DB_USER,
  password: DB_PASSWORD,
  database: DB_DATABASE,
  logging: false,
  // dialectOptions: {
  //   ssl: {
  //     require: true, // This is a security feature to ensure that the connection is encrypted.
  //     rejectUnauthorized: false, // It's important to handle SSL verification securely in production environments.
  //   },
  // },
});
module.exports = { db };
