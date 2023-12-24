const { Stadium } = require("../entities/Stadium");

const createStadiumService = async (data) => {
  const {
    name,
    dimension1,
    dimension2
  } = data;

  //   validate that each field is not empty
  if (
    !name ||
    !dimension1 ||
    !dimension2
  ) {
    throw {
      status: 400,
      message: "All fields are required",
    };
  }

  //   check if the stadium name is already there or not
  const stadium = await Stadium.findOne({ where: { name: name } });
  if (stadium) {
    throw {
      status: 400,
      message: "stadium already exists",
    };
  }

  // create a stadium
  const create_stadium = await Stadium.create({
    name,
    dimension1,
    dimension2
  });
  return {
    status: 201,
    response: {
      message: "stadium created successfully",
      stadium: create_stadium.dataValues,
    },
  };
};

const updateStadiumService = async (data) => {
  const {
    id,
    name,
    dimension1,
    dimension2
  } = data;

  //   validate that each field is not empty
  if (name || dimension1 || dimension2) {
    throw {
      status: 400,
      message: "a field to update is required",
    };
  }

  //   validate that the stadium id is found
  const stadium = await Stadium.findOne({ where: { id: id } });
  if (!stadium) {
    throw {
      status: 400,
      message: "invalid stadium id",
    };
  }
  
  if(!name){
    name = stadium.name;
  }
  if(!dimension1){
    dimension1 = stadium.dimension1;
  }
  if(!dimension2){
    dimension2 = stadium.dimension2;
  }

  //   update the team
  await Team.update(
    {
      name,
      dimension1,
      dimension2
    },
    {
      where: {
        id
      },
    }
  );
  
  const updated_stadium = await Stadium.findOne({ where: { id: id } });
  console.log(updated_stadium);
  return {
    status: 200,
    response: {
      message: "stadium updated successfully",
      stadium: updated_stadium.dataValues,
    },
  };
};

const getStadiumService = async (data) => {
  const { id } = data;
  if (!id) {
    throw {
      status: 400,
      message: "stadium id is required",
    };
  }
  const stadium = await Stadium.findOne({
    where: { id },
    include: [
      { model: Stadium, as: "name" }
    ],
  });

  if (!stadium) {
    throw {
      status: 400,
      message: "invalid stadium id",
    };
  }

  let stadium_data = stadium.dataValues;
  return {
    status: 200,
    response: {
        stadium: stadium_data,
    },
  };
};

const getAllStadiumsService = async (data) => {
    const stadiums = await Stadium.findAll({
        attributes: ["id", "name", "dimension1", "dimension2"]
      });
      
      for (let i = 0; i < stadiums.length; i++) {
        stadiums[i] = stadiums[i].dataValues;
      }

      return {
        status: 200,
        response: {
            stadium: stadiums,
        },
      };
};

const deleteStadiumService = async (data) => {
    const {
      id,
      name
    } = data;
  
    //   validate that id is not empty
    if (!id) {
      throw {
        status: 400,
        message: "stadium id is required",
      };
    }
  
    //   validate that the team id is found
    const stadium = await Stadium.findOne({ where: { id: id } });
    if (!stadium) {
      throw {
        status: 400,
        message: "invalid stadium id",
      };
    }
  
  
    //   delete the team
    await Stadium.destroy(
      {
        name
      },
      {
        where: {
          id
        },
      }
    );
  
    console.log("deleted stadium successfully");
    return {
      status: 200,
      response: {
        message: "stadium deleted successfully"
      },
    };
  };


module.exports = {
  createStadiumService,
  updateStadiumService,
  getStadiumService,
  getAllStadiumsService,
  deleteStadiumService
};
