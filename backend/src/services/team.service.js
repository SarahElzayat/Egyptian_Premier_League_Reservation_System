const { Team } = require("../entities/team");

const createTeamService = async (data) => {
  const {
    name
  } = data;

  //   validate that each field is not empty
  if (
    !name
  ) {
    throw {
      status: 400,
      message: "All fields are required",
    };
  }

  //   validate that the team name is valid
  const team = await Team.findOne({ where: { name: name } });

  if (team) {
    throw {
      status: 400,
      message: "invalid team name",
    };
  }

  // create a team
  const create_team = await Team.create({
    name
  });
  return {
    status: 201,
    response: {
      message: "team created successfully",
      team: create_team.dataValues,
    },
  };
};

const updateTeamService = async (data) => {
  const {
    id,
    name
  } = data;

  //   validate that each field is not empty
  if (!id) {
    throw {
      status: 400,
      message: "team id is required",
    };
  }

  //   validate that the team id is found
  const team = await Team.findOne({ where: { id: id } });
  if (!team) {
    throw {
      status: 400,
      message: "invalid team id",
    };
  }


  //   update the team
  await Team.update(
    {
      name
    },
    {
      where: {
        id
      },
    }
  );

  const updated_team = await Team.findOne({ where: { id: id } });
  console.log(updated_team);
  return {
    status: 200,
    response: {
      message: "team updated successfully",
      team: updated_team.dataValues,
    },
  };
};

const getTeamService = async (data) => {
  const { id } = data;
  if (!id) {
    throw {
      status: 400,
      message: "team id is required",
    };
  }
  const team = await Team.findOne({
    where: { id },
    include: [
      { model: Team, as: "name" }
    ],
  });

  if (!team) {
    throw {
      status: 400,
      message: "invalid team id",
    };
  }

  let team_data = team.dataValues;
  return {
    status: 200,
    response: {
      team: team_data,
    },
  };
};

const getAllTeamsService = async (data) => {
    const teams = await Team.findAll({
        attributes: ["id", "name"]
      });
      
      for (let i = 0; i < teams.length; i++) {
        teams[i] = teams[i].dataValues;
      }

      return {
        status: 200,
        response: {
          team: teams,
        },
      };
};

const deleteTeamService = async (data) => {
    const {
      id,
      name
    } = data;
  
    //   validate that id is not empty
    if (!id) {
      throw {
        status: 400,
        message: "team id is required",
      };
    }
  
    //   validate that the team id is found
    const team = await Team.findOne({ where: { id: id } });
    if (!team) {
      throw {
        status: 400,
        message: "invalid team id",
      };
    }
  
  
    //   delete the team
    await Team.destroy(
      {
        name
      },
      {
        where: {
          id
        },
      }
    );
  
    console.log("deleted team successfully");
    return {
      status: 200,
      response: {
        message: "team deleted successfully"
      },
    };
  };


module.exports = {
  createTeamService,
  updateTeamService,
  getTeamService,
  getAllTeamsService,
  deleteTeamService
};
