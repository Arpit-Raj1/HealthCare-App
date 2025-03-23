import { Router } from 'express';

import { checkUserExistenceInDatabase, updateUserDetails } from '../controllers/auth-controllers.js';
import verifyToken from '../middlewares/verify-token.js';
const authRouter = Router();

// authRouter.post('/sign-up', signUpUser);
// authRouter.post('/sign-in', signInUser);

authRouter.post('/verify', verifyToken, checkUserExistenceInDatabase);
authRouter.post('/create-profile', verifyToken, updateUserDetails);

export default authRouter;
