const { User } = require("../entities/user");

const loginService = async (email, password) => {
  const user = await User.findOne({ where: { email, password } });
  if (!user) {
    throw new Error("User not found");
  }
  return user;
};

const registerService = async (email, password) => {
  const user = await User.create({ email, password });
  return user;
};

const updateUserService = async (email, password) => {
  const user = await User.update({ email, password });
  return user;
};

module.exports = { loginService, registerService, updateUserService };
