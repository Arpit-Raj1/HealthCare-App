import { admin as firebaseAdmin } from "../config/firebase-config.js";

const verifyToken = asyncHandler(async (req, res, next) => {
  const token = req.headers.authorization?.split("Bearer ")[1];

  if (!token) {
    return res.status(401).json({ error: "Unauthorized: No token provided" });
  }

  const decodedToken = await firebaseAdmin.auth().verifyIdToken(token);
  req.user = decodedToken;
  next();
});
