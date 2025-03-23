import { admin as firebaseAdmin } from '../config/firebase-config.js';
import asyncHandler from 'express-async-handler';

const verifyToken = asyncHandler(async (req, res, next) => {
    const token = req.headers.authorization?.split('Bearer ')[1];

    if (!token) {
        return res.status(401).json({ error: 'Unauthorized: No token provided' });
    }

    const decodedToken = await firebaseAdmin.auth().verifyIdToken(token);

    if (!decodedToken) {
        return res.status(400).json({ error: 'Unauthorized: Invalid token' });
    }

    req.token = decodedToken;

    next();
});

export default verifyToken;
