const jwt = require("jsonwebtoken");
const { JWT_SECRET_KEY } = require("../config/index");

const authMiddleware = (req, res, next) => {
  const token = req.headers.token || req.headers.authorization;
  if (!token) {
    return res.status(401).json({
      error: "Authorization Token Missing",
      message: "Unauthorized: Missing Token",
    });
  }

  // Verify the token
  jwt.verify(token, JWT_SECRET_KEY, (err, decoded) => {
    if (err) {
      return res.status(401).json({
        error: "Invalid Token",
        message: "Unauthorized: Invalid or Expired Token",
      });
    }

    // Attach the decoded user information to the request object
    res.locals.token = token;

    // Call the next middleware or route handler
    next();
  });
};

module.exports = { authMiddleware };
