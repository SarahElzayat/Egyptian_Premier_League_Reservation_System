const { User } = require("../entities/user");
const { admin } = require("../entities/admin");
const approveService = async (data) => {
  const { username } = data;
  if (!username) {
    throw {
      status: 400,
      message: "username is required",
    };
  }
  const user = await User.findOne({ where: { username } });
  if (!user) {
    throw {
      status: 400,
      message: "invalid username",
    };
  }
  if (user.dataValues.status == "approved") {
    throw {
      status: 400,
      message: "user is already approved",
    };
  }
  //   update the status of the user to be approved
  await User.update(
    { status: "approved" },
    {
      where: {
        username,
      },
    }
  );
  return {
    status: 200,
    response: {
      message: "user approved successfully",
    },
  };
};

const deleteUserService = async (data) => {
  const { username } = data;
  if (!username) {
    throw {
      status: 400,
      message: "username is required",
    };
  }
  const user = await User.findOne({ where: { username } });
  if (!user) {
    throw {
      status: 400,
      message: "invalid username",
    };
  }
  //   delete the user
  await User.destroy({
    where: {
      username,
    },
  });
  console.log("user deleted successfully");
  return {
    status: 200,
    response: {
      message: "user deleted successfully",
    },
  };
};

const getAllAppendingUsersService = async (data) => {
  // seelct all useres where status is not approved
  // sort them by regesterAt from latest to recent
  // return them in the response
  // select only the regesterAt, username, email
  const out = await User.findAll({
    attributes: ["regesterAt", "username", "email"],
    where: {
      status: "not approved",
    },
    order: [["regesterAt", "ASC"]],
  });
  for (let i = 0; i < out.length; i++) {
    out[i] = out[i].dataValues;
  }
  return {
    status: 200,
    response: {
      users: out,
    },
  };
};

module.exports = {
  approveService,
  deleteUserService,
  getAllAppendingUsersService,
};
